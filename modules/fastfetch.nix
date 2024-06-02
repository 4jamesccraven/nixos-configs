{ pkgs, lib, config, ... }:

{
  home-manager.users.jamescraven = {
    programs.fastfetch = {
      enable = true;

      settings = {
	padding.top = 2;
        logo = {
	  color = {
            "1" = "38;2;181;191;226";
	    "2" = "38;2;202;158;230";
	  };
	};


        display = {
          color = "38;2;202;158;230";
	  separator = "  ";
	  binaryPrefix = "si";
	  temp = {
	    unit = "C";
	    ndigits = 0;
	  };
	  size = {
            maxPrefix = "TB";
	    ndigits = 2;
	  };
	  bar = {
            charElapsed = "*";
	    charTotal = " ";
	  };
	  percent = {
            type = 1;
	  };
	};


	modules = [
	  "break"
	  "break"

          {
            type = "title";
	  }

          {
            type = "os";
	    key = "├── ";
          }

          {
            type = "packages";
	    key = "├── ";
          }

          {
            type = "theme";
	    key = "├── ";
          }

	  {
	    type = "separator";
	    string = "│                ";
	    outputColor = "38;2;202;158;230";
	  }

          {
            type = "datetime";
	    key = "├── 󱑀";
	    format = "{14}:{17}:{20}";
	  }

	  {
	    type = "uptime";
	    key = "├── 󰔛";
	  }

	  {
	    type = "datetime";
	    key = "├── ";
	    format = "{3}/{11}/{1}";
	  }

	  {
	    type = "separator";
	    string = "│                ";
	  }

	  {
	    type = "cpu";
	    key = "├── ";
	  }

          {
	    type = "memory";
	    key = "├── ";
	  }

          {
	    type = "gpu";
	    key = "├── 󰡷";
	  }

          {
	    type = "disk";
	    key = "├── ";
	  }

	  {
	    type = "separator";
	    string = "│                ";
	  }
	  
	  {
            type = "battery";
	    key = "├── ";
	  }

	  {
            type = "wifi";
	    key = "├── ";
	  }

	  {
            type = "localip";
	    key = "└── ";
	  }
	];
      };

    };
  };
}
