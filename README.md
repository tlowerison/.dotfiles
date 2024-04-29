# .dotfiles

## Setup

```sh
cd
git clone https://github.com/tlowerison/.dotfiles.git
mkdir ~/.config
ln -s ~/.dotfiles/nvim/.config/nvim ~/.config/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
cargo install ripgrep
rustup component add rust-analyzer
rm "$HOME/.cargo/bin/rust-analyzer"
ln -s "$(rustup which --toolchain stable rust-analyzer)" "$HOME/.cargo/bin/rust-analyzer"
brew install gnu-sed

# plug package manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.vim/plugged

# LaTeX
# Install MacTex or other latex library
# Make sure latexmk is installed on the command line (may need to install independently of latex distribution)
brew tap zegervdv/zathura
brew install zathura
brew install zathura-pdf-poppler
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
brew install hashicorp/tap/terraform-ls
brew install tflint

sudo npm i -g bash-language-server
# install shellcheck, https://github.com/koalaman/shellcheck#installing

# null-ls integrations
cargo install --git https://github.com/avencera/rustywind
cargo install selene
cargo install shellharden
cargo install stylua
sudo npm i -g typescript
pip install ruff
# install jq, see https://stedolan.github.io/jq/download
# install opa, see https://github.com/open-policy-agent/opa/releases

brew install tmux # install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm # Install tpm (tmux plugin manager)
ln -s "$HOME/.dotfiles/config/tmux/config.conf" "$HOME/.tmux.conf"

# install sshfs for mac from https://osxfuse.github.io

# install bacon
cargo install bacon
bacon_prefs_path="$(bacon --prefs)" && rm "$bacon_prefs_path" && ln -s "$HOME/.dotfiles/config/bacon/prefs.toml" "$bacon_prefs_path"

# install prettierd, a prettier daemon
npm install -g @fsouza/prettierd

# install eslint language server
npm i -g eslint_d

# install gopls language server
go install golang.org/x/tools/gopls@latest

# install ra-multiplex, a rust-analyzer multiplexer which allows multiple clients to talk to the same ra language server
cargo install --git https://github.com/pr2502/ra-multiplex

# install vtsls, a faster typescript language server: https://github.com/yioneko/vtsls
npm install -g @vtsls/language-server

# On MacOS, need to create config file otherwise ra-multiplex immediately fails
mkdir ~/Library/Application\ Support/ra-multiplex && touch ~/Library/Application\ Support/ra-multiplex/config.toml
```
