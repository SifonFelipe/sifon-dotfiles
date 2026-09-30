-- Fisa
-- Port del theme de Zed a Neovim
-- Todos los colores son RGB (#RRGGBB).
-- Los colores con alpha del theme original fueron premezclados.

vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "sifon-dark"

local c = {
    -- Backgrounds
    bg = "#181a1c",
    bg_dark = "#0f1112",
    element = "#141618",
    hover = "#1d1f22",
    active = "#292b2e",
    border = "#232527",

    -- Alpha colors pre-blended over #181a1c
    -- #00000026 over #181a1c
    active_line = "#141617",

    -- #2095f033 over #181a1c
    selection = "#1a3347",

    -- #ffffff1a over #181a1c
    search = "#2f3132",

    -- #ffffff26 over #181a1c
    scrollbar_hover = "#3a3c3d",

    -- #ffffff1a over #181a1c
    scrollbar = "#2f3132",

    -- Foregrounds
    fg = "#f8f8f8",
    fg_soft = "#bfbdb6",
    muted = "#8a8986",
    line_nr = "#5c6166",

    -- Syntax
    pink = "#f92672",
    pink_bright = "#ff2f82",

    green = "#a6e22e",
    green_bright = "#98e024",

    yellow = "#e6db74",
    yellow_bright = "#ffda3f",

    cyan = "#66d9ef",
    cyan_bright = "#58d1eb",

    purple = "#ae81ff",

    orange = "#fd971f",

    blue = "#6d85ff",
}

local hl = vim.api.nvim_set_hl

-- ============================================================
-- EDITOR
-- ============================================================

hl(0, "Normal", {
    fg = c.fg,
    bg = c.bg,
})

hl(0, "NormalNC", {
    fg = c.fg,
    bg = c.bg,
})

hl(0, "NormalFloat", {
    fg = c.fg,
    bg = c.bg_dark,
})

hl(0, "FloatBorder", {
    fg = c.border,
    bg = c.bg_dark,
})

hl(0, "FloatTitle", {
    fg = c.cyan,
    bg = c.bg_dark,
})

hl(0, "CursorLine", {
    bg = c.active_line,
})

hl(0, "CursorColumn", {
    bg = c.active_line,
})

hl(0, "ColorColumn", {
    bg = c.active,
})

hl(0, "LineNr", {
    fg = c.line_nr,
    bg = c.bg,
})

hl(0, "CursorLineNr", {
    fg = c.fg,
    bg = c.active_line,
    bold = true,
})

hl(0, "SignColumn", {
    bg = c.bg,
})

hl(0, "EndOfBuffer", {
    fg = c.bg,
    bg = c.bg,
})

hl(0, "WinSeparator", {
    fg = c.border,
    bg = c.bg,
})

hl(0, "VertSplit", {
    fg = c.border,
    bg = c.bg,
})

hl(0, "Visual", {
    bg = c.selection,
})

hl(0, "Search", {
    fg = c.fg,
    bg = c.search,
})

hl(0, "IncSearch", {
    fg = c.bg,
    bg = c.yellow_bright,
})

hl(0, "CurSearch", {
    fg = c.bg,
    bg = c.yellow_bright,
})

hl(0, "MatchParen", {
    fg = c.pink,
    bg = c.active,
    bold = true,
})

hl(0, "Whitespace", {
    fg = c.border,
})

hl(0, "NonText", {
    fg = c.border,
})

hl(0, "Directory", {
    fg = c.cyan,
})

-- ============================================================
-- STATUSLINE / TABS
-- ============================================================

hl(0, "StatusLine", {
    fg = c.fg_soft,
    bg = c.border,
})

hl(0, "StatusLineNC", {
    fg = c.muted,
    bg = c.border,
})

hl(0, "TabLine", {
    fg = c.muted,
    bg = c.border,
})

hl(0, "TabLineSel", {
    fg = c.fg,
    bg = c.bg,
})

hl(0, "TabLineFill", {
    bg = c.border,
})

-- ============================================================
-- CLASSIC SYNTAX
-- ============================================================

hl(0, "Comment", {
    fg = c.line_nr,
})

hl(0, "Constant", {
    fg = c.purple,
})

hl(0, "String", {
    fg = c.yellow,
})

hl(0, "Character", {
    fg = c.yellow,
})

hl(0, "Number", {
    fg = c.purple,
})

hl(0, "Boolean", {
    fg = c.purple,
})

hl(0, "Float", {
    fg = c.purple,
})

hl(0, "Identifier", {
    fg = c.fg,
})

hl(0, "Function", {
    fg = c.green,
})

hl(0, "Statement", {
    fg = c.pink,
})

hl(0, "Conditional", {
    fg = c.pink,
})

hl(0, "Repeat", {
    fg = c.pink,
})

hl(0, "Label", {
    fg = c.pink,
})

hl(0, "Operator", {
    fg = c.pink,
})

hl(0, "Keyword", {
    fg = c.pink,
})

hl(0, "Exception", {
    fg = c.pink,
})

hl(0, "PreProc", {
    fg = c.pink,
})

hl(0, "Include", {
    fg = c.pink,
})

hl(0, "Define", {
    fg = c.pink,
})

hl(0, "Macro", {
    fg = c.pink,
})

hl(0, "PreCondit", {
    fg = c.pink,
})

hl(0, "Type", {
    fg = c.cyan,
})

hl(0, "StorageClass", {
    fg = c.cyan,
})

hl(0, "Structure", {
    fg = c.cyan,
})

hl(0, "Typedef", {
    fg = c.cyan,
})

hl(0, "Special", {
    fg = c.purple,
})

hl(0, "SpecialChar", {
    fg = c.purple,
})

hl(0, "Tag", {
    fg = c.pink,
})

hl(0, "Delimiter", {
    fg = c.fg,
})

hl(0, "SpecialComment", {
    fg = c.line_nr,
})

hl(0, "Debug", {
    fg = c.orange,
})

hl(0, "Underlined", {
    fg = c.cyan,
    underline = true,
})

hl(0, "Error", {
    fg = c.pink,
})

hl(0, "Todo", {
    fg = c.yellow,
    bold = true,
})

-- ============================================================
-- TREESITTER
-- ============================================================

hl(0, "@comment", {
    fg = c.line_nr,
})

hl(0, "@comment.documentation", {
    fg = c.line_nr,
})

-- Keywords

hl(0, "@keyword", {
    fg = c.pink,
})

hl(0, "@keyword.function", {
    fg = c.pink,
})

hl(0, "@keyword.return", {
    fg = c.pink,
})

hl(0, "@keyword.import", {
    fg = c.pink,
})

hl(0, "@keyword.export", {
    fg = c.pink,
})

hl(0, "@keyword.operator", {
    fg = c.pink,
})

hl(0, "@conditional", {
    fg = c.pink,
})

hl(0, "@repeat", {
    fg = c.pink,
})

hl(0, "@exception", {
    fg = c.pink,
})

hl(0, "@include", {
    fg = c.pink,
})

hl(0, "@operator", {
    fg = c.pink,
})

-- Functions

hl(0, "@function", {
    fg = c.green,
})

hl(0, "@function.call", {
    fg = c.green,
})

hl(0, "@function.builtin", {
    fg = c.green,
})

hl(0, "@method", {
    fg = c.green,
})

hl(0, "@method.call", {
    fg = c.green,
})

hl(0, "@constructor", {
    fg = c.pink,
})

-- Types

hl(0, "@type", {
    fg = c.cyan,
})

hl(0, "@type.builtin", {
    fg = c.cyan,
})

hl(0, "@type.definition", {
    fg = c.cyan,
})

hl(0, "@namespace", {
    fg = c.cyan,
})

-- Variables

hl(0, "@variable", {
    fg = c.fg,
})

hl(0, "@variable.builtin", {
    fg = c.green,
})

hl(0, "@variable.parameter", {
    fg = c.fg,
})

hl(0, "@parameter", {
    fg = c.fg,
})

hl(0, "@property", {
    fg = c.pink,
})

hl(0, "@field", {
    fg = c.pink,
})

hl(0, "@attribute", {
    fg = c.green,
})

-- Strings

hl(0, "@string", {
    fg = c.yellow,
})

hl(0, "@string.escape", {
    fg = c.purple,
})

hl(0, "@string.regex", {
    fg = c.yellow,
})

hl(0, "@string.special", {
    fg = c.yellow,
})

hl(0, "@character", {
    fg = c.yellow,
})

-- Constants

hl(0, "@constant", {
    fg = c.purple,
})

hl(0, "@constant.builtin", {
    fg = c.purple,
})

hl(0, "@constant.macro", {
    fg = c.purple,
})

hl(0, "@number", {
    fg = c.purple,
})

hl(0, "@boolean", {
    fg = c.purple,
})

hl(0, "@float", {
    fg = c.purple,
})

-- Punctuation

hl(0, "@punctuation.delimiter", {
    fg = c.fg,
})

hl(0, "@punctuation.bracket", {
    fg = c.fg,
})

hl(0, "@punctuation.special", {
    fg = c.yellow,
})

-- Tags

hl(0, "@tag", {
    fg = c.pink,
})

hl(0, "@tag.attribute", {
    fg = c.green,
})

hl(0, "@tag.delimiter", {
    fg = c.fg,
})

-- ============================================================
-- DIAGNOSTICS
-- ============================================================

hl(0, "DiagnosticError", {
    fg = c.pink,
})

hl(0, "DiagnosticWarn", {
    fg = c.orange,
})

hl(0, "DiagnosticInfo", {
    fg = c.cyan,
})

hl(0, "DiagnosticHint", {
    fg = c.muted,
})

hl(0, "DiagnosticUnderlineError", {
    undercurl = true,
    sp = c.pink,
})

hl(0, "DiagnosticUnderlineWarn", {
    undercurl = true,
    sp = c.orange,
})

hl(0, "DiagnosticUnderlineInfo", {
    undercurl = true,
    sp = c.cyan,
})

hl(0, "DiagnosticUnderlineHint", {
    undercurl = true,
    sp = c.muted,
})

-- ============================================================
-- COMPLETION
-- ============================================================

hl(0, "Pmenu", {
    fg = c.fg,
    bg = c.bg_dark,
})

hl(0, "PmenuSel", {
    fg = c.fg,
    bg = c.active,
})

hl(0, "PmenuSbar", {
    bg = c.element,
})

hl(0, "PmenuThumb", {
    bg = c.line_nr,
})

-- ============================================================
-- GIT / DIFF
-- ============================================================

hl(0, "Added", {
    fg = c.green,
})

hl(0, "Changed", {
    fg = c.yellow,
})

hl(0, "Removed", {
    fg = c.pink,
})

hl(0, "DiffAdd", {
    fg = c.green,
})

hl(0, "DiffChange", {
    fg = c.yellow,
})

hl(0, "DiffDelete", {
    fg = c.pink,
})

hl(0, "DiffText", {
    fg = c.cyan,
    bg = c.active,
})

-- ============================================================
-- FOLDING
-- ============================================================

hl(0, "Folded", {
    fg = c.muted,
    bg = c.element,
})

hl(0, "FoldColumn", {
    fg = c.line_nr,
    bg = c.bg,
})
