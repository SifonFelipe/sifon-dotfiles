-- Sifon Phosphor
-- Minimal phosphor-terminal colorscheme matching Alacritty + tmux.
-- Use with: :colorscheme sifon-phosphor

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "sifon-phosphor"

local p = {
  -- black-green terminal surfaces
  bg0 = "#080b0a",
  bg1 = "#0d120f",
  bg2 = "#121a15",
  bg3 = "#1a261e",
  bg4 = "#26382d",
  selection = "#173522",
  search = "#244a32",

  -- phosphor text
  fg = "#b7c9b7",
  fg_bright = "#e2f0e2",
  fg_dim = "#6f8174",
  comment = "#53605a",
  punctuation = "#8da091",

  -- restrained accents
  red = "#ff4d4d",
  orange = "#d79a5b",
  yellow = "#d7d75f",
  green = "#39ff88",
  teal = "#69ff9f",
  cyan = "#5fffff",
  blue = "#62a0ff",
  purple = "#d75fff",
  pink = "#ff5fa2",

  add = "#39ff88",
  change = "#d7d75f",
  delete = "#ff4d4d",
  hint = "#5fffff",
}

vim.g.sifon_phosphor_palette = p

local set = function(group, value)
  vim.api.nvim_set_hl(0, group, value)
end

local link = function(group, target)
  set(group, { link = target })
end

-- Editor -------------------------------------------------------------------
set("Normal", { fg = p.fg, bg = p.bg0 })
set("NormalNC", { fg = p.fg_dim, bg = p.bg0 })
set("NormalFloat", { fg = p.fg, bg = p.bg1 })
set("FloatBorder", { fg = p.bg4, bg = p.bg1 })
set("FloatTitle", { fg = p.cyan, bg = p.bg1, bold = true })
set("MsgArea", { fg = p.fg, bg = p.bg0 })
set("MsgSeparator", { fg = p.bg4, bg = p.bg0 })

set("Cursor", { fg = p.bg0, bg = p.fg_bright })
set("CursorLine", { bg = p.bg1 })
set("CursorColumn", { bg = p.bg1 })
set("ColorColumn", { bg = p.bg2 })
set("LineNr", { fg = "#33463a", bg = p.bg0 })
set("CursorLineNr", { fg = p.cyan, bg = p.bg1, bold = true })
set("SignColumn", { fg = p.fg_dim, bg = p.bg0 })
set("FoldColumn", { fg = p.fg_dim, bg = p.bg0 })
set("Folded", { fg = p.fg_dim, bg = p.bg1, italic = true })
set("EndOfBuffer", { fg = p.bg0, bg = p.bg0 })
set("NonText", { fg = p.bg4 })
set("Whitespace", { fg = p.bg3 })
set("SpecialKey", { fg = p.bg4 })

set("Visual", { bg = p.selection })
set("VisualNOS", { bg = p.selection })
set("Search", { fg = p.fg_bright, bg = p.search, bold = true })
set("IncSearch", { fg = p.bg0, bg = p.orange, bold = true })
set("CurSearch", { fg = p.bg0, bg = p.yellow, bold = true })
set("Substitute", { fg = p.bg0, bg = p.red, bold = true })
set("MatchParen", { fg = p.yellow, bg = p.bg3, bold = true })
set("QuickFixLine", { bg = p.selection, bold = true })

set("WinSeparator", { fg = p.bg3, bg = p.bg0 })
link("VertSplit", "WinSeparator")
set("Directory", { fg = p.cyan, bold = true })
set("Title", { fg = p.blue, bold = true })
set("Question", { fg = p.cyan })
set("MoreMsg", { fg = p.teal })
set("ModeMsg", { fg = p.fg_dim })
set("ErrorMsg", { fg = p.red, bold = true })
set("WarningMsg", { fg = p.yellow })
set("Conceal", { fg = p.fg_dim })

-- Statusline, tabs, and menus ----------------------------------------------
set("StatusLine", { fg = p.fg, bg = p.bg3 })
set("StatusLineNC", { fg = p.fg_dim, bg = p.bg1 })
set("WinBar", { fg = p.fg, bg = p.bg0, bold = true })
set("WinBarNC", { fg = p.fg_dim, bg = p.bg0 })
set("TabLine", { fg = p.fg_dim, bg = p.bg1 })
set("TabLineFill", { bg = p.bg1 })
set("TabLineSel", { fg = p.fg_bright, bg = p.bg3, bold = true })

set("Pmenu", { fg = p.fg, bg = p.bg2 })
set("PmenuSel", { fg = p.fg_bright, bg = p.selection, bold = true })
set("PmenuKind", { fg = p.purple, bg = p.bg2 })
set("PmenuKindSel", { fg = p.purple, bg = p.selection })
set("PmenuExtra", { fg = p.fg_dim, bg = p.bg2 })
set("PmenuExtraSel", { fg = p.fg_dim, bg = p.selection })
set("PmenuSbar", { bg = p.bg2 })
set("PmenuThumb", { bg = p.bg4 })
set("WildMenu", { fg = p.bg0, bg = p.cyan, bold = true })

-- Diagnostics and spelling -------------------------------------------------
set("DiagnosticError", { fg = p.red })
set("DiagnosticWarn", { fg = p.yellow })
set("DiagnosticInfo", { fg = p.blue })
set("DiagnosticHint", { fg = p.hint })
set("DiagnosticOk", { fg = p.green })
set("DiagnosticVirtualTextError", { fg = p.red, bg = "#1d1011" })
set("DiagnosticVirtualTextWarn", { fg = p.yellow, bg = "#1c1d10" })
set("DiagnosticVirtualTextInfo", { fg = p.blue, bg = "#101820" })
set("DiagnosticVirtualTextHint", { fg = p.hint, bg = "#0e1c19" })
set("DiagnosticUnderlineError", { sp = p.red, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = p.yellow, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = p.blue, undercurl = true })
set("DiagnosticUnderlineHint", { sp = p.hint, undercurl = true })
link("DiagnosticSignError", "DiagnosticError")
link("DiagnosticSignWarn", "DiagnosticWarn")
link("DiagnosticSignInfo", "DiagnosticInfo")
link("DiagnosticSignHint", "DiagnosticHint")
link("LspReferenceText", "Visual")
link("LspReferenceRead", "Visual")
set("LspReferenceWrite", { bg = p.selection, underline = true })
set("LspSignatureActiveParameter", { fg = p.yellow, bold = true })

set("SpellBad", { sp = p.red, undercurl = true })
set("SpellCap", { sp = p.blue, undercurl = true })
set("SpellLocal", { sp = p.teal, undercurl = true })
set("SpellRare", { sp = p.purple, undercurl = true })

-- Diff and Git -------------------------------------------------------------
set("DiffAdd", { fg = p.add, bg = "#0d1d13" })
set("DiffChange", { fg = p.change, bg = "#1b1b0d" })
set("DiffDelete", { fg = p.delete, bg = "#1d1011" })
set("DiffText", { fg = p.fg_bright, bg = "#293016", bold = true })
set("Added", { fg = p.add })
set("Changed", { fg = p.change })
set("Removed", { fg = p.delete })
set("GitSignsAdd", { fg = p.add })
set("GitSignsChange", { fg = p.change })
set("GitSignsDelete", { fg = p.delete })
set("GitConflictCurrent", { bg = "#172019" })
set("GitConflictIncoming", { bg = "#102419" })
set("GitConflictAncestor", { bg = "#24210f" })

-- Classic syntax -----------------------------------------------------------
set("Comment", { fg = p.comment, italic = true })
set("Constant", { fg = p.orange })
set("String", { fg = "#8fcf9d" })
set("Character", { fg = "#8fcf9d" })
set("Number", { fg = p.yellow })
set("Boolean", { fg = p.orange, bold = true })
set("Float", { fg = p.yellow })
set("Identifier", { fg = p.fg })
set("Function", { fg = p.cyan })
set("Statement", { fg = p.green })
set("Conditional", { fg = p.green })
set("Repeat", { fg = p.green })
set("Label", { fg = p.purple })
set("Operator", { fg = p.cyan })
set("Keyword", { fg = p.green })
set("Exception", { fg = p.red })
set("PreProc", { fg = p.purple })
set("Include", { fg = p.purple })
set("Define", { fg = p.purple })
set("Macro", { fg = p.purple })
set("Type", { fg = p.teal })
set("StorageClass", { fg = p.green })
set("Structure", { fg = p.teal })
set("Typedef", { fg = p.teal })
set("Special", { fg = p.orange })
set("SpecialChar", { fg = p.orange })
set("Delimiter", { fg = p.punctuation })
set("Underlined", { fg = p.cyan, underline = true })
set("Todo", { fg = p.bg0, bg = p.yellow, bold = true })
set("Ignore", { fg = p.fg_dim })

-- Treesitter ---------------------------------------------------------------
link("@comment", "Comment")
set("@comment.documentation", { fg = "#617466", italic = true })
set("@comment.error", { fg = p.red, bold = true })
set("@comment.warning", { fg = p.yellow, bold = true })
set("@comment.todo", { fg = p.bg0, bg = p.yellow, bold = true })
set("@comment.note", { fg = p.bg0, bg = p.cyan, bold = true })

set("@variable", { fg = p.fg })
set("@variable.builtin", { fg = p.orange, italic = true })
set("@variable.parameter", { fg = p.teal })
set("@variable.parameter.builtin", { fg = p.orange, italic = true })
set("@variable.member", { fg = p.fg })
set("@constant", { fg = p.orange })
set("@constant.builtin", { fg = p.orange, bold = true })
set("@module", { fg = p.cyan })
set("@module.builtin", { fg = p.cyan, italic = true })
set("@label", { fg = p.purple })

link("@string", "String")
set("@string.documentation", { fg = "#739b7d", italic = true })
set("@string.escape", { fg = p.cyan, bold = true })
set("@string.regexp", { fg = p.orange })
set("@string.special", { fg = p.orange })
set("@character", { fg = "#8fcf9d" })
set("@character.special", { fg = p.orange })
link("@boolean", "Boolean")
link("@number", "Number")
link("@number.float", "Float")

set("@type", { fg = p.teal })
set("@type.builtin", { fg = p.teal, italic = true })
set("@type.definition", { fg = p.teal })
set("@attribute", { fg = p.purple })
set("@property", { fg = p.fg })

set("@function", { fg = p.cyan })
set("@function.builtin", { fg = p.cyan })
set("@function.call", { fg = p.cyan })
set("@function.macro", { fg = p.purple })
set("@function.method", { fg = p.cyan })
set("@function.method.call", { fg = p.cyan })
set("@constructor", { fg = p.teal })

set("@keyword", { fg = p.green })
set("@keyword.coroutine", { fg = p.green, italic = true })
set("@keyword.function", { fg = p.green })
set("@keyword.operator", { fg = p.green })
set("@keyword.import", { fg = p.purple })
set("@keyword.type", { fg = p.green })
set("@keyword.modifier", { fg = p.green })
set("@keyword.repeat", { fg = p.green })
set("@keyword.return", { fg = p.green, italic = true })
set("@keyword.debug", { fg = p.red })
set("@keyword.exception", { fg = p.red })
set("@keyword.conditional", { fg = p.green })
set("@keyword.directive", { fg = p.purple })

set("@operator", { fg = p.cyan })
set("@punctuation.delimiter", { fg = p.punctuation })
set("@punctuation.bracket", { fg = p.punctuation })
set("@punctuation.special", { fg = p.orange })

set("@tag", { fg = p.cyan })
set("@tag.builtin", { fg = p.blue })
set("@tag.attribute", { fg = p.yellow })
set("@tag.delimiter", { fg = p.fg_dim })

set("@markup.heading", { fg = p.blue, bold = true })
set("@markup.heading.1", { fg = p.pink, bold = true })
set("@markup.heading.2", { fg = p.orange, bold = true })
set("@markup.heading.3", { fg = p.yellow, bold = true })
set("@markup.strong", { fg = p.orange, bold = true })
set("@markup.italic", { fg = p.purple, italic = true })
set("@markup.strikethrough", { fg = p.fg_dim, strikethrough = true })
set("@markup.link", { fg = p.blue })
set("@markup.link.label", { fg = p.purple })
set("@markup.link.url", { fg = p.cyan, underline = true })
set("@markup.raw", { fg = p.green })
set("@markup.quote", { fg = p.teal, italic = true })
set("@markup.list", { fg = p.pink })

-- LSP semantic tokens ------------------------------------------------------
link("@lsp.type.class", "@type")
link("@lsp.type.decorator", "@attribute")
link("@lsp.type.enum", "@type")
link("@lsp.type.enumMember", "@constant")
link("@lsp.type.function", "@function")
link("@lsp.type.interface", "@type")
link("@lsp.type.macro", "@function.macro")
link("@lsp.type.method", "@function.method")
link("@lsp.type.namespace", "@module")
link("@lsp.type.parameter", "@variable.parameter")
link("@lsp.type.property", "@property")
link("@lsp.type.string", "@string")
link("@lsp.type.type", "@type")
link("@lsp.type.typeParameter", "@type")
link("@lsp.type.variable", "@variable")
set("@lsp.typemod.variable.readonly", { fg = p.orange })
set("@lsp.typemod.function.defaultLibrary", { fg = p.cyan })
set("@lsp.typemod.variable.defaultLibrary", { fg = p.orange, italic = true })

-- Python and Django --------------------------------------------------------
set("pythonBuiltin", { fg = p.cyan })
set("pythonDecorator", { fg = p.purple })
set("pythonDecoratorName", { fg = p.purple })
set("pythonExceptions", { fg = p.red })
set("pythonSelf", { fg = p.orange, italic = true })
set("djangoTagBlock", { fg = p.green })
set("djangoVarBlock", { fg = p.cyan })
set("djangoStatement", { fg = p.green })
set("djangoFilter", { fg = p.blue })
set("djangoArgument", { fg = p.yellow })
set("djangoComment", { fg = p.comment, italic = true })
set("djangoComBlock", { fg = p.comment, italic = true })
set("djangoTagError", { fg = p.red, bold = true })
set("djangoVarError", { fg = p.red, bold = true })

-- Completion ---------------------------------------------------------------
set("BlinkCmpMenu", { fg = p.fg, bg = p.bg2 })
set("BlinkCmpMenuBorder", { fg = p.bg4, bg = p.bg2 })
set("BlinkCmpMenuSelection", { fg = p.fg_bright, bg = p.selection, bold = true })
set("BlinkCmpLabel", { fg = p.fg })
set("BlinkCmpLabelDeprecated", { fg = p.fg_dim, strikethrough = true })
set("BlinkCmpLabelMatch", { fg = p.cyan, bold = true })
set("BlinkCmpLabelDetail", { fg = p.fg_dim })
set("BlinkCmpLabelDescription", { fg = p.fg_dim })
set("BlinkCmpSource", { fg = p.purple })
set("BlinkCmpDoc", { fg = p.fg, bg = p.bg1 })
set("BlinkCmpDocBorder", { fg = p.bg4, bg = p.bg1 })
set("BlinkCmpSignatureHelp", { fg = p.fg, bg = p.bg1 })
set("BlinkCmpSignatureHelpBorder", { fg = p.bg4, bg = p.bg1 })

local kind_colors = {
  Text = p.fg,
  Method = p.blue,
  Function = p.blue,
  Constructor = p.teal,
  Field = p.yellow,
  Variable = p.fg,
  Class = p.teal,
  Interface = p.teal,
  Module = p.cyan,
  Property = p.yellow,
  Unit = p.orange,
  Value = p.orange,
  Enum = p.teal,
  Keyword = p.pink,
  Snippet = p.purple,
  Color = p.pink,
  File = p.cyan,
  Reference = p.purple,
  Folder = p.cyan,
  EnumMember = p.orange,
  Constant = p.orange,
  Struct = p.teal,
  Event = p.pink,
  Operator = p.cyan,
  TypeParameter = p.teal,
}
for kind, color in pairs(kind_colors) do
  set("BlinkCmpKind" .. kind, { fg = color })
  set("CmpItemKind" .. kind, { fg = color })
end
set("CmpItemAbbrMatch", { fg = p.cyan, bold = true })
set("CmpItemAbbrMatchFuzzy", { fg = p.cyan, bold = true })

-- FzfLua -------------------------------------------------------------------
set("FzfLuaNormal", { fg = p.fg, bg = p.bg1 })
set("FzfLuaBorder", { fg = p.bg4, bg = p.bg1 })
set("FzfLuaTitle", { fg = p.cyan, bg = p.bg1, bold = true })
set("FzfLuaPreviewNormal", { fg = p.fg, bg = p.bg0 })
set("FzfLuaPreviewBorder", { fg = p.bg4, bg = p.bg0 })
set("FzfLuaPreviewTitle", { fg = p.teal, bg = p.bg0, bold = true })
set("FzfLuaCursor", { fg = p.bg0, bg = p.fg_bright })
set("FzfLuaCursorLine", { bg = p.selection })
set("FzfLuaCursorLineNr", { fg = p.cyan, bg = p.selection, bold = true })
set("FzfLuaSearch", { fg = p.orange, bold = true })
set("FzfLuaScrollBorderEmpty", { fg = p.bg4 })
set("FzfLuaScrollBorderFull", { fg = p.cyan })
set("FzfLuaHeaderBind", { fg = p.purple })
set("FzfLuaHeaderText", { fg = p.fg_dim })
set("FzfLuaPathColNr", { fg = p.yellow })
set("FzfLuaPathLineNr", { fg = p.green })
set("FzfLuaBufName", { fg = p.blue })
set("FzfLuaBufFlagCur", { fg = p.green })
set("FzfLuaBufFlagAlt", { fg = p.yellow })

-- Neo-tree and utility plugins --------------------------------------------
set("NeoTreeNormal", { fg = p.fg, bg = p.bg1 })
set("NeoTreeNormalNC", { fg = p.fg_dim, bg = p.bg1 })
set("NeoTreeEndOfBuffer", { fg = p.bg1, bg = p.bg1 })
set("NeoTreeWinSeparator", { fg = p.bg3, bg = p.bg1 })
set("NeoTreeDirectoryIcon", { fg = p.cyan })
set("NeoTreeDirectoryName", { fg = p.cyan })
set("NeoTreeRootName", { fg = p.purple, bold = true })
set("NeoTreeFileNameOpened", { fg = p.fg_bright, bold = true })
set("NeoTreeIndentMarker", { fg = p.bg4 })
set("NeoTreeGitAdded", { fg = p.add })
set("NeoTreeGitModified", { fg = p.change })
set("NeoTreeGitDeleted", { fg = p.delete })
set("NeoTreeGitUntracked", { fg = p.teal })
set("NeoTreeCursorLine", { bg = p.selection })

set("TreesitterContext", { bg = p.bg1 })
set("TreesitterContextLineNumber", { fg = p.cyan, bg = p.bg1 })
set("FlashLabel", { fg = p.bg0, bg = p.pink, bold = true })
set("FlashMatch", { fg = p.cyan, underline = true })
set("FlashCurrent", { fg = p.orange, bold = true })
set("FlashBackdrop", { fg = p.comment })
set("WhichKey", { fg = p.cyan })
set("WhichKeyGroup", { fg = p.purple })
set("WhichKeyDesc", { fg = p.fg })
set("WhichKeySeparator", { fg = p.fg_dim })
set("WhichKeyFloat", { bg = p.bg1 })
set("LazyNormal", { fg = p.fg, bg = p.bg0 })
set("LazyButton", { fg = p.fg, bg = p.bg2 })
set("LazyButtonActive", { fg = p.bg0, bg = p.cyan, bold = true })
set("MasonNormal", { fg = p.fg, bg = p.bg0 })

-- TODO comments ------------------------------------------------------------
local todo_groups = {
  TODO = p.cyan,
  FIX = p.red,
  HACK = p.orange,
  WARN = p.yellow,
  PERF = p.purple,
  NOTE = p.blue,
  TEST = p.teal,
  IMPORTANT = p.red,
  CHECK = p.green,
  REVIEW = p.yellow,
  QUESTION = p.purple,
  IDEA = p.cyan,
}
for name, color in pairs(todo_groups) do
  set("TodoFg" .. name, { fg = color, bold = true })
  set("TodoBg" .. name, { fg = p.bg0, bg = color, bold = true })
  set("TodoSign" .. name, { fg = color })
end

-- Markdown rendering -------------------------------------------------------
set("RenderMarkdownH1Bg", { bg = p.bg2 })
set("RenderMarkdownH2Bg", { bg = p.bg1 })
set("RenderMarkdownH3Bg", { bg = "#101713" })
set("RenderMarkdownCode", { bg = p.bg1 })
set("RenderMarkdownCodeInline", { fg = p.green, bg = p.bg1 })
set("RenderMarkdownBullet", { fg = p.pink })
set("RenderMarkdownQuote", { fg = p.teal })
set("RenderMarkdownLink", { fg = p.cyan })

-- Terminal palette ---------------------------------------------------------
vim.g.terminal_color_0 = p.bg0
vim.g.terminal_color_1 = p.red
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_3 = p.yellow
vim.g.terminal_color_4 = p.blue
vim.g.terminal_color_5 = p.purple
vim.g.terminal_color_6 = p.cyan
vim.g.terminal_color_7 = p.fg
vim.g.terminal_color_8 = p.fg_dim
vim.g.terminal_color_9 = "#ff6b6b"
vim.g.terminal_color_10 = "#69ff9f"
vim.g.terminal_color_11 = "#ffff87"
vim.g.terminal_color_12 = "#87afff"
vim.g.terminal_color_13 = "#ff87ff"
vim.g.terminal_color_14 = "#87ffff"
vim.g.terminal_color_15 = p.fg_bright

