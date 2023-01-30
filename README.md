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
```
