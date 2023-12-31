# Installation Guide for Fedora Workstation
---

## Initial Setup and System Update

1. Update DNF configuration found in `/etc/dnf/dnf.conf` and add the following `max_parallel_downloads=10` and `fastestmirror=True`.

1. Update your system `sudo dnf update && sudo dnf upgrade`

1. Firmware update using the following sequence of commands:
    ```
    sudo fwupdmgr refresh --force
    sudo fwupdmgr get-updates
    sudo fwupdmgr update  
    ```

1. Enable RPM Fusion Repository (refer to website)

1. Enable Flathub Repository (refer to website)

1. Install multimedia codecs from RPM Fusion or by installing VLC and MPV

---

## Adjust settings and extensions 

1. Tweak the following settings:
    - Privacy Settings
    - Screen Lock (Automatic Suspend to No)
    - Power Profile Settings
    - Night Light
    - Nautilus Sort Folder before Files
    - Automatically Delete Trash Content (Under Privacy)
    - Alt+Tab avoid grouping (go to keyboard shortcut and search for `switch windows` then change to `Alt+Tab`)

1. Adjust Gnome Terminal Padding: edit or create `~/.config/gtk-3.0/gtk.css` and add the following lines
    - Should not be used with Custom Accent Color Extension
    ``
    VteTerminal,
     TerminalScreen,
     vte-terminal {
         padding: 15px 15px 15px 15px;
         -VteTerminal-inner-border: 15px 15px 15px 15px;
    }
    ``
---

## Link Github and clone dotfile repositories

1. Generate SSH Keys and Add to Github (follow Github instructions in their website)

1. Clone dotfiles repository and store under home directory

1. Install Stow. CD to the dotfiles repository and run `stow .` to create a symlink to config files.
    - if there are changes to dotfiles, rerun stow: CD to dotfile repository and run `stow -R`

---

## Install Packages and Applications

1. Install `GNOME Tweaks` `GNOME Extensions App` from DNF

1. Install `Gnome Extensions Manager` `Gradience` `Flatseal` `dconf-editor` from Flathub

1. Install TLP (laptop battery optimization) using this `sudo dnf install tlp tlp-rdw`

1. Install packages: `sudo dnf install zsh fzf bat ripgrep lsd fd-find btop neovim vim vlc openssl`

1. Install Helix, Marksman LSP, Glow MD Viewer (follow instructions from website)
    - Helix: download using COPR
    - Marksman: download binaries and store at ~/.local/bin and make it executable
    - Glow: download binaries and save at ~/.local/bin and make it executable 

1. Install MS Fonts (follow instructions on web to install on Fedora)

1. Install other fonts (nerd fonts, fira code, jet brains)
    - download .ttf file from websites and copy to `~/.local/share/fonts`
    - refresh font cache `fc-cache -v`

---

