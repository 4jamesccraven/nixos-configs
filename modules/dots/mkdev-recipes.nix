/*
  ====[ Mkdev/recipes ]====
  :: dotfile

  My mkdev recipes.
*/
[
  {
    name = "hm";
    description = "A single home-manager module.";
    languages = [
      {
        name = "Nix";
        colour = [
          126
          126
          255
        ];
      }
    ];
    contents = [
      {
        name = "{{name}}.nix";
        content = ''
          { ... }:

          /*
            ====[ {{name}} ]====
            :: dotfile

            Enables and configures {{name}}.
          */
          {
            home-manager.users.{{user}} = {
              programs.{{name}}.enable = true;


            };
          }

        '';
      }
    ];
  }
  {
    name = "trait";
    description = "A trait for my NixOS system.";
    languages = [
      {
        name = "Nix";
        colour = [
          126
          126
          255
        ];
      }
    ];
    contents = [
      {
        name = "{{name}}.nix";
        content = ''
          { ... }:

          /*
            ====[ {{name}} ]====
            :: trait

            The {{name}} trait.

            Enables:
              :> User Level
              example => description

              :> System Level
              example => description

              :> Config Level
              example => description
          */
          {

          }

        '';
      }
    ];
  }
  {
    name = "shellscript";
    description = "A shell script";
    languages = [
      {
        name = "Shell";
        colour = [
          137
          224
          81
        ];
      }
    ];
    contents = [
      {
        name = "{{name}}";
        content = "#!/usr/bin/env bash\n\n";
      }
    ];
  }
]
