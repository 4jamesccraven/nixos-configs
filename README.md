<h1 align="center">
     <img src="./assets/nixos-logo.png" style="height: 1em; vertical-align: middle; margin-right: 0.5em;">
     NixOS Configuration Files
     <img src="./assets/nixos-logo.png" style="height: 1em; vertical-align: middle; margin-right: 0.5em;">
</h1>

<div align="center">
Written and configured with:

![Nix](https://img.shields.io/badge/NIX-5277C3.svg?style=for-the-badge&logo=NixOS&logoColor=white)
![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Rust](https://img.shields.io/badge/rust-%23000000.svg?style=for-the-badge&logo=rust&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

</div>

Multi-host configuration files for my NixOS machines.

### What is Nix/NixOS?
NixOS is an atomic, declarative, immutable GNU/Linux distribution that offers both rolling and
stable releases ([More Info](https://en.wikipedia.org/wiki/NixOS)). I tried NixOS in June 2024
and have been daily driving it since around that time.

Host Devices
------------
| Hostname | Device Type     | Primary Purpose | Namesake                                                                                 |
|----------|-----------------|-----------------|------------------------------------------------------------------------------------------|
| vaal     | Laptop          | School          | [Vaal River, South Africa](https://en.wikipedia.org/wiki/Vaal_River)                     |
| RioTinto | Desktop         | Gaming          | [Rio Tinto, Spain](https://en.wikipedia.org/wiki/Rio_Tinto_(river))                      |
| tokoro   | Server          | File Backups    | [Tokoro River, Japan](https://en.wikipedia.org/wiki/Tokoro_River)                        |
| wsl      | Virtual Machine | WSL Config      | [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) |

##### Note on Names
We have a long-standing tradition at my house to name all devices after a
river. After a few decades of this, basic names like "Nile" are long gone.
These particular names are based primarily on cultures that I find intriguing
or have a connection with.

Screenshots
-----------
![screenshot_1](./assets/screenshot_1.png)
![screenshot_2](./assets/screenshot_2.png)
<div align="center"><i>Screenshots taken on vaal (note: this is slightly outdated).</i></div>

System Management
-----------------
All of the process I have in place for managing my system are largely self
contained to a [justfile](https://github.com/casey/just). I have `just` aliased
to `j`, so I can rebuild my system by running `j b` from my flake's directory.
The general "usage loop" is as follows:

| Recipe  | Purpose                                           |
|---------|---------------------------------------------------|
| Build   | Rebuild the system                                |
| Clean   | Cleans unused packages from /nix/store using `nh` |
| Push    | Push changes upstream                             |
| Sync    | Syncs upstream, builds, then cleans               |
| Update  | Updates flake inputs and tries to build system    |

I try to update my flake every two weeks or so, starting with RioTinto (I use
it most, so it must work above all else). Then, I splitscreen ssh into my
laptop and server and `just sync` them. All-in-all, an update for all machines
takes around 1-2hrs. I have only ever had to hold off on accepting an update
once, and it was just due to the folks at Home Manager needing a bit longer to
update their Neovim derivations to match upstream. My experience is otherwise
very stable.

Related Projects
----------------
A few of my other projects are dependencies of my flake. Most aren't really intended
for public use, but mkdev is!
- [Mkdev](https://github.com/4jamesccraven/mkdev): Command-line templating
  engine primarily intended to speed up creating new projects (a la Cargo).
- [Warframe Bot](https://github.com/4jamesccraven/warframe-bot): A discord bot
  that posts [warframe](https://www.warframe.com/) news

Directory Structure
-------------------
- Assets - Static assets for certain applications
- Hosts - Entry points for the configs
- Overlay - Scripts etc. that I packaged
- Utils - Custom nix code for various things
- Modules - Everything else
   - Dots - Specific applications, mostly cli
   - Desktop Environments - Hyprland & Gnome configuration
