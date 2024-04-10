# Installation Guide for Fedora Workstation
---

## Initial Setup and System Update

1. Update DNF configuration found in `/etc/dnf/dnf.conf` and add the following `max_parallel_downloads=10` `fastestmirror=True` `defaultyes=True`.

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

1. Install `Gnome Extensions Manager` `Gradience` `Flatseal` `dconf-editor` `bottles` `libreoffice` `okular` `calibre` `blankets` from Flathub

1. Install TLP (laptop battery optimization) using this `sudo dnf install tlp tlp-rdw`

1. Install packages: `sudo dnf install zsh fzf bat ripgrep lsd fd-find btop neovim vim vlc openssl tldr imv zathura zathura-plugins-all \
neofetch firewall-config atool ffmpegthumbnailer chafa poppler-utils w3m perl-Image-ExifTool ImageMagick unrar p7zip-plugins odt2txt transmission-common \
nmtui trash-cli ncdu seahorse`

1. Install Helix, Marksman LSP, Glow MD Viewer (follow instructions from website)
    - Helix: install from dnf `sudo dnf install helix`
    - Marksman: download binaries and store at ~/.local/bin and make it executable. Rename the binaries to `marksman`
    - Glow: download binaries and save at ~/.local/bin and make it executable 

1. Install MS Fonts (follow instructions on web to install on Fedora)

1. Install other fonts (nerd fonts, fira code, jet brains)
    - download .ttf file from websites and copy to `~/.local/share/fonts`
    - refresh font cache `fc-cache -v`

1. Nice to have packages: `sudo dnf install lolcat cmatrix cowsay figlet asciiquarium sl fortune-mod toilet oneko cava` and pipes.sh

---

## When to install flatpak, dnf, or other repo
  - use flatpak if:
    * User applications
    * GUI apps
    * Maintainers in flathub can be trusted (actual developers)
    * Needs proprietary drivers (firefox)
    * Proprietary apps (discord, spotify)
    * Application does NOT need to access system resources (sandboxed nature)
  - Use DNF if:
    * System applications
    * CLI apps
    * Packages in DNF are already curated by the maintainers
    * Apps having permission problems with flatpak
    * Apps need to access system resources
    * Apps that sometimes need sudo permission (text editors)
  - Other Repos:
    * Packages not available on flatpak and DNF
    * Maintainers can be trusted

---

## Change Calibre Library Folder Location
1. Open Calibre app.
1. Under Library tab, select `Switch/Create Library`
1. Choose the new folder and check `Move the current library to new location`
1. Install NoDRM `https://github.com/noDRM/DeDRM_tools/releases` and KFX Input Plugin

---

## Update MIME Type for Default Apps
1. Run the bash script: `~/.local/bin/mimeDeault.sh`
    - Make the bash script executable: `chmod +x mimeDefault.sh`
    - You can change the default app by changing the .desktop file variable 
    - You can find the .desktop file at `/usr/share/applications`
    - To check for file type of selected file: `xdg-mime query filetype [FileName]`
    - To check for default app: `xdg-mime query default [file/type]`
    - To change default app: `xdg-mime default [.desktop] [file/type]`

---

## Make LibreOffice compatible with MS Office
1. Change how LibreOffice looks:
    - Change User Interface to Tabbed
    - Change system icons to Sukapura SVG+Dark (MainMenu>Options>View)
1. Add Microsoft Fonts (see above)
1. Change the default fonts to MS Fonts like Calibri (MainMenu>Options>LibreOfficeWriter>BasicFonts)
1. Improve file compatibility
    - MainMenu>Options>Load/Save>MicrosoftOffice: Check all items
    - MainMenu>Options>LibreOfficeWriter>Compatibility: Check the following:
        * Reorganize Form Menu for Microsoft compatibility
        * Word-Compatible Trailing Blanks > Use as Default
    
---

## Custom Gnome-Terminal Profile
1. Follow the instructions at <https://github.com/Gogh-Co/Gogh> 
1. After downloading themes, set the desired profile and change the font and transparency of the terminal. 

---

## Install language servers
1. Recommended language servers to install
    |Language    |LSP                  |RPM Repo Package Name    |
    |------------|---------------------|-------------------------|
    |Markdown    |Marksman             |(See above)              |
    |Bash        |bash-language-server |bash-language-server     |
    |C/CPP       |clangd               |clang-tools-extra & clang|

---

## Change default terminal from gnome-terminal to kitty
1. Change the binary of gnome terminal to kitty (symlink)
    > sudo mv /usr/bin/gnome-terminal /usr/bin/gnome-terminal.bak
    > sudo ln -s /usr/bin/kitty /usr/bin/gnome-terminal
1. Changee the /usr/share/applications/gnome-terminal.desktop
    * Create a backup first `mv gnome-terminal.desktop gnome-terminal.desktop.bak`
    * Edit the .desktop entry of gnome-terminal (need sudo)
    * Delete `Actions=new-window;preferences;` line under `[Desktop Entry]` 
    * Delete everything under `[Desktop Action new-window]` and `[Desktop Action preferences]`

---

## Theming Gnome Shell
1. Download GTK Themes from gnome-look.org
1. Extract and store in `~/.themes` or `~/.icons`
1. Open Gnome Tweaks and change the desired themes and icons
1. Open User Themes Extension settings and set the desired themes
1. Copy and replace the GTK-4.0 folder files from the themes folder to `~/.config/gtk-4.0`
1. For blur effects, edit the Blur-My-Shell settings (panel, application, overview)
1. For gaps, use Tiling Assistant Extension to add gaps, maximize windows, and Tiling State

---

## Neofetch Themes
1. Download prebuilt themes from the following repositories:
    * https://github.com/chick2d/neofetch-themes
    * https://github.com/m3tozz/NeoCat?tab=readme-ov-file
1. Replace the `~/.config/neofetch/config.conf` with your desired configuration
1. Dot Art Generator: `https://emojicombos.com/dot-art-generator`

---

## Radiogogo setup (TUI FM radio streaming)
1. install Golang `sudo dnf install golang`
1. Follow installation guide at https://github.com/matteo-pacini/RadioGoGo
1. Add Go binary path to $PATH (set as alias on .zshrc to add path when launching radiogogo)
