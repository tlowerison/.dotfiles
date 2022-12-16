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
```
