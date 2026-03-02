{ ... }:

/*
  ====[ Display Manager ]====
  :: In trait `Graphical`
  Enables a graphical login menu/session picker.
*/
{
  services = {
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };
  };
}
