{
  config,
  lib,
  pkgs,
  ...
}:

/*
  ====[ tmux ]====
  :: dotfile

  Enables and configures tmux, the terminal multi-plexer.
*/
let
  colours = lib.genAttrs [
    "accent"
    "text"
    "base"
    "mantle"
  ] (c: "#" + config.ext.colours."${c}".hex);
in
with colours;
{
  environment.systemPackages = with pkgs; [
    tmux
  ];
  home-manager.users.jamescraven = {
    xdg.configFile."tmux/tmux.conf".text = /* tmux */ ''
      # ====[ Functionality ]====
      # Change prefix to Ctrl + Space
      unbind C-b
      set-option -g prefix C-Space
      bind-key C-Space send-prefix

      # Change split keybind to intuitive symbols
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Change split navigation to vim keys
      unbind l; unbind Up; unbind Down; unbind Left; unbind right
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Enable mouse
      set -g mouse on

      # ====[ Style ]====
      # :> Bar
      set -g status-style 'bg=${mantle} fg=${text}'
      set -g status-right '%H:%M'

      # :> Window (Tab) Format
      # Active
      set -g window-status-current-style 'fg=${accent} bg=${base}'
      set -g window-status-current-format ' #W (#I) #F '
      # Inactive
      set -g window-status-style 'fg=${text} bg=${mantle}'
      set -g window-status-format ' #W (#[fg=${accent}]#I#[fg=${text}]) #F '

      # :> Pane
      set -g pane-border-style 'fg=${mantle}'
      set -g pane-active-border-style 'fg=${accent}'
    '';
  };
}
