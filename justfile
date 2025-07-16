alias b := build

[private]
default:
    @just --list --list-heading $'Actions:\n' --no-aliases

# Build the system
[group('System State')]
build fast="no": validate
    @if [ "{{ fast }}" != "-f" ]; then git pull; fi
    @nh os switch .

# Clean unused store paths
[group('System State')]
clean no-optimise="no": validate
    @nh clean all
    @just build -f
    @if [ "{{ no-optimise }}" != "--no-optimise" ]; then nix store optimise; fi

# Synchronise the system with Origin
[group('System State')]
sync: build clean

# Update the system
[group('System State')]
update *inputs: validate && (build "-f")
    @nix flake update {{ inputs }}

# Revert the system to HEAD
[group('VCS')]
revert: _show_last_commit _phony_confirm
    @git reset --hard HEAD

# Push changes to Origin
[group('VCS')]
push message="chore: system update":
    @git add . --all
    @git commit -m '{{ message }}'
    @git push origin HEAD

[private]
_show_last_commit:
    @echo "You are trying to revert to"
    @git log -1 --oneline

[confirm("Really revert to this commit?")]
[private]
_phony_confirm:

[private]
validate:
    @sudo -v
