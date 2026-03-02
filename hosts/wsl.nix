{ ... }:

/*
  ====[ WSL ]====
  :: host

  Dummy host target for building on WSL.

  Derives:
  - WSL
*/
{
  imports = [
    ../modules/traits/wsl.nix
  ];
}
