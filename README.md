<h1 align="center">
   ❄️ NixOS Configuration Files ❄️
</h1>

Multi-host configuration files for my NixOS machine. It also contains my Neovim config since
I didn't start using it until I started using Nix.

### What is Nix/NixOS?
NixOS is an atomic, declarative, immutable GNU/Linux distribution that offers both rolling and
stable releases ([More Info](https://en.wikipedia.org/wiki/NixOS)). I tried NixOS in June 2024
and have been daily driving it since around that time. 

Hosts
-----
| Hostname | Device Type | Purpose      |
|----------|-------------|--------------|
| vaal     | Laptop      | School       |
| RioTinto | Desktop     | Gaming       |
| tokoro   | Server      | File Backups |
| wsl      | N/A         | WSL Config   |

Directory Structure
-------------------
-  Assets - static assets for certain applications
-  Hosts - entry points for the configs
-  Custom Derivations - Scripts etc. that I packaged
-  Modules - Everything else
   - Dots - specific applications, mostly cli
   - Desktop Environments - Self-explanatory
 
Installing
----------
Please don't. Copy as much as you like, but it is not intended to be deployed on anything but my machines.
