local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local tex_utils = {
  -- math context detection
  in_mathzone = function()
    local foo = vim.fn['vimtex#syntax#in_mathzone']()
    print("HI!! foo=", foo)
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  end,
  in_comment = function()  -- comment detection
    return vim.fn['vimtex#syntax#in_comment']() == 1
  end,
  in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
  end,
}

tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end

return {
  -- Examples of Greek letter snippets, autotriggered for efficiency
  s(
    {trig=";a", snippetType="autosnippet"},
    {t("\\alpha")}
  ),
  s(
    {trig=";b", snippetType="autosnippet"},
    {t("\\beta")}
  ),
  s(
    {trig=";g", snippetType="autosnippet"},
    {t("\\gamma")}
  ),
  s(
    {trig="([^%a])tt", dscr="Expands 'tt' into '\\texttt{}'"},
    fmta(
      "\\texttt{<>}",
      { i(1) }
    )
  ),
  s(
    {trig="([^%a])ff", dscr="Expands 'ff' into '\\frac{}{}'"},
    fmta(
      "\\frac{<>}{<>}",
      { i(1), i(2) },
      {condition = tex_utils.in_mathzone}
    )
  ),
  s(
    {trig="([^%a])mm", dscr="Inline math using '$$'"},
    fmta(
      "$<>$",
      { i(1) }
    ),
    {condition = tex_utils.in_text}
  ),
  s(
    {trig="([^%a])eq", dscr="A LaTeX equation environment"},
    fmta(
      [[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
      { i(1) },
      {condition = tex_utils.in_mathzone}
    )
  ),
  s(
    {trig="([^%a])env", snippetTYpe="autosnippet"},
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      { i(1), i(2), rep(1) }
    )
  ),
  s(
    {trig="([^%a])hr", dscr="The hyperref packages' href{}{} command (for url links)"},
    fmta(
      [[\href{<>}{<>}]],
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),
  s(
    {trig="dd"},
    fmta(
      "\\draw[<>] ",
      {i(1, "params")}
    ),
    {condition = tex_utils.in_tikz}
  )
}
