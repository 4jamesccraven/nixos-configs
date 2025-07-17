{
  self,
  pkgs,
  lib ? pkgs.lib,
  ...
}:

let
  neovimConfig =
    let
      rawNeovimConfig =
        self.nixosConfigurations.vaal.config.home-manager.users.jamescraven.programs.neovim;

      init = rawNeovimConfig.extraLuaConfig;
      dependencies = rawNeovimConfig.extraPackages;
      pluginsRaw = rawNeovimConfig.plugins;
    in
    {
      init = init;
      dependencies = map lib.getName dependencies;
      plugins = map (
        plg:
        let
          packageName = if plg ? plugin then plg.plugin.meta.homepage else plg.meta.homepage;
          name = if plg ? plugin then lib.getName plg.plugin else lib.getName plg;
          config = if plg ? config then plg.config else "";
        in
        {
          packageName = lib.removeSuffix "/" (lib.removePrefix "https://github.com/" packageName);
          name = name;
          config = config;
        }
      ) pluginsRaw;
    };

  jsonFile = (pkgs.formats.json { }).generate "neovim.json" neovimConfig;

  lazyBootstrap =
    pkgs.writeText "lazy.lua" # lua
      ''
        -- Bootstrap lazy.nvim
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not (vim.uv or vim.loop).fs_stat(lazypath) then
          local lazyrepo = "https://github.com/folke/lazy.nvim.git"
          local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
          if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
              { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
              { out, "WarningMsg" },
              { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
          end
        end
        vim.opt.rtp:prepend(lazypath)

        require("lazy").setup({
          spec = {
            { import = "plugins" },
          },
        })
      '';

  mapFunction =
    pkgs.writeText "map.lua" # lua
      ''
        local function map(mode, lhs, rhs, opts)
            opts = opts or { noremap = true, silent = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        return map
      '';

  header = pkgs.stdenvNoCC.mkDerivation {
    name = "alpha-nvim-header";

    src = ../../assets/header.tar.gz;

    phases = [
      "unpackPhase"
      "installPhase"
    ];

    unpackPhase = ''
      tar xzf $src
    '';

    installPhase = ''
      mkdir -p $out
      cp header.lua $out
    '';
  };

  script = pkgs.callPackage ./script.nix { pkgs = pkgs; };
in
pkgs.writeShellScriptBin "exportNeovim" ''
  ${script}/bin/export_nvim \
    --json ${jsonFile} \
    --header ${header}/header.lua \
    --lazy ${lazyBootstrap} \
    --map ${mapFunction}
''
