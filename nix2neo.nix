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
in
pkgs.writers.writePython3Bin "nix2neo"
  {
    doCheck = false;
  }
  ''
    import json
    import os

    # Read config data
    with open('${jsonFile}', 'r', encoding='utf8') as f:
        config = json.load(f)

    # Read lazy bootstrap file
    with open('${lazyBootstrap}', 'r', encoding='utf8') as f:
        lazy = f.read()

    # Other programs for config
    with open('dependencies.txt', 'x', encoding='utf8') as f:
        f.write('\n'.join(config['dependencies']))

    # Init.lua
    with open('init.lua', 'x', encoding='utf8') as f:
        f.write(config['init'])

    # make config structure
    os.makedirs('./lua/config', exist_ok=True)
    os.makedirs('./lua/plugins', exist_ok=True)

    # Write lazy bootstrao file
    with open('./lua/config/lazy.lua', 'x', encoding='utf8') as f:
        f.write(lazy)

    # For each file
    for plugin in config['plugins']:
        # Get name for file
        filename = './lua/plugins/' + plugin['name'] + '.lua'
        # Get owner/repo style string
        package = plugin['packageName']
        # Check yo see if there is config with the plugin
        has_config = 'config' in plugin

        # Construct file contents
        contents = 'return {\n' \
                   + '    "' + package + '"\n' \
                   + '    ' + 'config = function()\n'

        if has_config:
            config = plugin['config']
            config = '\n'.join(list(map(lambda l: (' ' * 8) + l, config.splitlines())))
            contents = contents \
                   + config \
                   + '\n    ' + 'end\n' \

        contents = contents \
                   + '}'

        # Write out to file
        with open(filename, 'x', encoding='utf8') as f:
            f.write(contents)
  ''
