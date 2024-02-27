local luasnip = require("luasnip")

luasnip.config.set_config({enable_autosnippets = true})

require("luasnip.loaders.from_lua").lazy_load({paths = {"~/.config/nvim/LuaSnip/"}})
require("luasnip.loaders.from_vscode").lazy_load()
