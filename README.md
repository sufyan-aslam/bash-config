# 🖥️ Custom Bash Prompt

A clean, professional, and highly functional Bash prompt with a **Google‑inspired color scheme**, real‑time Git status, command timer, and intuitive icons.

![Version](https://img.shields.io/badge/version-1.0.0-blue) ![Bash](https://img.shields.io/badge/shell-bash-green) ![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 📖 Table of Contents

- [✨ Features](#-features)
- [📸 Preview](#-preview)
- [🚀 Installation](#-installation)
- [🔧 Customization](#-customization)
- [❓ Troubleshooting](#-troubleshooting)
- [🔄 Updating](#-updating)
- [🗑️ Uninstall](#-uninstall)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [🙏 Acknowledgments](#-acknowledgments)

---

## ✨ Features

| Feature | Description |
| :--- | :--- |
| 🎨 **Color Palette** | Orange username, Blue directory, Green/Yellow Git status, Red error badges. |
| 🕒 **Timestamp with Seconds** | Shows exact command execution time (`HH:MM:SS`). |
| ⏱️ **Command Timer** | Displays execution time when commands take **> 2 seconds**. |
| 🔄 **Smart Git Status** | Shows branch name with change counts (`+2 ~1`) and color‑coded status: **Green** = clean, **Yellow** = changes. |
| ❌ **Error Badge** | Instantly alerts when a command fails, showing the exit code (`✘ 127`). |
| 📁 **Intuitive Icons** | Uses standard Unicode/emoji (`📁` for folder, `⎇` for branch) – no special fonts required. |
| 🧹 **Two‑Line Layout** | Clean separation between info and input, with a second line for typing. |

---

## 📸 Preview

### Clean Git Repository (Fast Command)
text
[🟧 your-username ]  :  [🔵 📁 ~/projects/my-app ]  :  [🟢 ⎇ :main: ]
 14:32:45  ➜ 


### Dirty Repository (2 Added, 1 Modified) + Command Took 5s
text
[🟧 your-username ]  :  [🔵 📁 ~/projects/my-app ]  :  [🟡 ⎇ :fix/bug: +2 ~1 ]  [🟧 5s ]
 14:32:45  ➜ 


### Command Failed (Error 127)
text
[🟧 your-username ]  :  [🔵 📁 ~/projects/my-app ]  :  [🟢 ⎇ :main: ]  [🔴 ✘ 127 ]
 14:32:45  ➜ 


### Outside a Git Repository
text
[🟧 your-username ]  :  [🔵 📁 ~/Downloads ]  : 
 14:32:45  ➜ 


---

## 🚀 Installation

### Prerequisites

- **Bash 3.2+** – macOS comes with Bash 3.2, Linux has 4+. The prompt works on both.
- **Git** – To clone the repository.
- **Modern terminal** – iTerm2, GNOME Terminal, Windows Terminal, VS Code, or Warp.
- **No Nerd Font required** – All icons are standard Unicode/emoji.

### Step 1: Clone the Repository

bash
git clone https://github.com/sufyan-aslam/bash-config.git ~/bash-config


*(Or clone it to `~/dotfiles` if you prefer that name.)*

### Step 2: Back Up Your Existing Profile

bash
# Back up .bash_profile (macOS)
mv ~/.bash_profile ~/.bash_profile.backup

# Back up .bashrc (Linux)
mv ~/.bashrc ~/.bashrc.backup


### Step 3: Create a Symlink

**For macOS (uses `.bash_profile`):**
bash
ln -s ~/bash-config/.bash_profile ~/.bash_profile


**For Linux (uses `.bashrc`):**
bash
ln -s ~/bash-config/.bash_profile ~/.bashrc


**If you want both to work:**
bash
echo 'if [ -f ~/.bashrc ]; then source ~/.bashrc; fi' >> ~/.bash_profile
ln -s ~/bash-config/.bash_profile ~/.bashrc


### Step 4: Reload the Configuration

bash
source ~/.bash_profile


Or if you used `.bashrc`:

bash
source ~/.bashrc


### Step 5: Verify It Works

Your terminal should now display:

text
[🟧 your-username ]  :  [🔵 📁 ~/bash-config ]  :  [🟢 ⎇ :main: ]
 14:32:45  ➜ 


### Step 6: (Optional) Add Other Dotfiles

bash
cp ~/.gitconfig ~/bash-config/
cp ~/.vimrc ~/bash-config/
cp ~/.zshrc ~/bash-config/
# ... add any other config files

cd ~/bash-config
git add .
git commit -m "chore: add additional dotfiles"
git push


---

## 🔧 Customization

### Changing Colors

Open `~/.bash_profile` and edit the variables at the top:

| Variable | Purpose | Default |
| :--- | :--- | :--- |
| `BG_USER` | Username background | Orange `#F9AB00` |
| `BG_PATH` | Directory background | Blue `#4285F4` |
| `BG_GIT_CLEAN` | Clean Git background | Green `#34A853` |
| `BG_GIT_DIRTY` | Dirty Git background | Yellow `#FBBC05` |
| `BG_TIMER` | Timer background | Orange `#F9AB00` |
| `BG_ERROR` | Error background | Red `#EA4335` |

To change a color, replace the hex value:

bash
BG_USER=$'\e[48;2;255;107;0m'   # Bright Orange
BG_PATH=$'\e[48;2;0;122;255m'   # Bright Blue


### Changing Icons

Edit these variables:

bash
FOLDER_ICON='📁'   # Change to any emoji or Unicode symbol
BRANCH_ICON='⎇'    # Change to any emoji or Unicode symbol


**Popular icon alternatives:**

| Folder Icons | Branch Icons |
| :--- | :--- |
| `⤷` `↳` `▸` `▶` `~` `📂` | `├` `└` `⑂` `🔀` `⚡` |

### Changing Timestamp Format

Find this line in the script:

bash
local timestamp_text="\[${FG_TIMESTAMP}\]$(date +%H:%M:%S)\[${CLEAR}\]"


Change the format:

| Format | Output |
| :--- | :--- |
| `%H:%M:%S` | `14:32:45` |
| `%H:%M` | `14:32` |
| `%I:%M %p` | `02:32 PM` |
| `%Y-%m-%d %H:%M` | `2026-08-09 14:32` |

### Adjusting Timer Threshold

Find this line:

bash
if [[ $elapsed -ge 2 ]]; then


Change `2` to any number of seconds (e.g., `5` for 5 seconds).

---

## ❓ Troubleshooting

### Prompt Shows Raw Codes Like `\e[48;2;...`
Your terminal does not support **24‑bit True Color**.

**Fix:** Use the **256‑color fallback**. Replace the background definitions with:

bash
BG_USER=$'\e[48;5;214m'
BG_PATH=$'\e[48;5;27m'
BG_GIT_CLEAN=$'\e[48;5;40m'
BG_GIT_DIRTY=$'\e[48;5;220m'
BG_TIMER=$'\e[48;5;214m'
BG_ERROR=$'\e[48;5;196m'


### Icons Show as Empty Boxes
Your terminal doesn't support that emoji/Unicode character.

**Fix:** Replace `📁` with `⤷` or `~` in the script.

### Git Branch Not Showing
You are not inside a Git repository.

**Fix:** Navigate to a Git repo and the branch will appear automatically.

### Timer or Error Badges Not Showing

- Timer only appears when a command takes **more than 2 seconds**.
- Error badge only appears when a command fails (exit code ≠ 0).

### `bash: __set_prompt: command not found`
Your config file was not sourced correctly.

**Fix:** Run `source ~/.bash_profile` or restart your terminal.

### Terminal Is Slow in Large Git Repos
The prompt runs `git status` on every key press.

**Fix 1:** Enable Git untracked cache:

bash
git config --global core.untrackedCache true


**Fix 2:** Modify the script to use `--untracked-files=no`:

bash
local status=$(git status --porcelain --untracked-files=no 2>/dev/null)


### Colors Are Wrong or Mismatched
Your terminal may not support 24‑bit color.

**Fix:** Use the **256‑color fallback** from above, or switch to a terminal that supports True Color (iTerm2, GNOME Terminal, Windows Terminal, VS Code, Warp).

### Prompt Has Broken Line Wrapping
Color escape sequences must be wrapped with `\[` and `\]` – which the script already does. If you edited the script, ensure all color variables are wrapped correctly.

---

## 🔄 Updating

To pull the latest changes from the repository:

bash
cd ~/bash-config
git pull
source ~/.bash_profile


---

## 🗑️ Uninstall

To completely remove the prompt and restore your original settings:

bash
# Remove the symlink
rm ~/.bash_profile

# Restore your backup
mv ~/.bash_profile.backup ~/.bash_profile

# Or if you used .bashrc:
rm ~/.bashrc
mv ~/.bashrc.backup ~/.bashrc

# Reload
source ~/.bash_profile


---

## 🤝 Contributing

Found a bug or have a suggestion?

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/amazing-idea`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push: `git push origin feature/amazing-idea`
5. Open a Pull Request.

---

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Inspired by [Powerlevel10k](https://github.com/romkatv/powerlevel10k) and Google's Material Design.
- Icons sourced from Unicode and emoji standards.
- Built with ❤️ for developers who spend their lives in the terminal.

**Made with ❤️ by [sufyan-aslam](https://github.com/sufyan-aslam)**
EOFREADME
