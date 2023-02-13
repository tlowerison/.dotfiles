# bacon

## Setup
```sh
cargo install bacon
bacon_prefs_path="$(bacon --prefs)" && rm "$bacon_prefs_path" && ln -s "$HOME/.dotfiles/config/bacon/prefs.toml" "$bacon_prefs_path"
```
