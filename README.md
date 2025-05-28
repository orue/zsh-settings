## My ZSH Configuration

Run the following commands in your terminal to point to ZSH configuration on .config/zsh:

```sh
echo ZDOTDIR=$HOME/.config/zsh > ~/.zshenv
```

Then, clone this repository into the `.config/zsh` directory:

```sh
git clone https://github.com/orue/zsh-settings.git
```
After cloning, your `.config/zsh` directory should look like this:

```sh
.config/zsh
├── .gitignore
├── .zshrc
├── aliases.zsh
├── aws.zsh
├── exports.zsh
├── functions.zsh
├── git-aliases.zsh
├── nvm.zsh
├── python-venv.zsh
├── README.md
├── starship.toml
├── transient-prompt.zsh
├── user-aliases.zsh
└── variables.zsh
```
