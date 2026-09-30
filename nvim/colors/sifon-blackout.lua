-- Sifon Blackout
-- Deep-black Neovim colorscheme with vivid but controlled syntax colors.
-- Use with: :colorscheme sifon-blackout

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "sifon-blackout"

local p = {
  -- near-black surfaces
  bg0 = "#070809",
  bg1 = "#0d0f12",
  bg2 = "#13161a",
  bg3 = "#1b1f24",
  bg4 = "#282d34",
  selection = "#242936",
  search = "#3c3420",

  -- neutral text
  fg = "#c9d1d9",
  fg_bright = "#f0f3f6",
  fg_dim = "#7d8590",
  comment = "#626b76",
  punctuation = "#9aa4af",

  -- vivid accents
  red = "#ff5d62",
  orange = "#f5a65b",
  yellow = "#e5c07b",
  green = "#7ee787",
  teal = "#56d4c3",
  cyan = "#56d9ff",
  blue = "#6ea8fe",
  purple = "#bd93f9",
  pink = "#ff79c6",

  add = "#7ee787",
  change = "#e5c07b",
  delete = "#ff5d62",
  hint = "#56d9ff",
}

vim.g.sifon_blackout_palette = p

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
set("LineNr", { fg = "#343a42", bg = p.bg0 })
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
set("DiagnosticVirtualTextError", { fg = p.red, bg = "#221214" })
set("DiagnosticVirtualTextWarn", { fg = p.yellow, bg = "#211e12" })
set("DiagnosticVirtualTextInfo", { fg = p.blue, bg = "#111923" })
set("DiagnosticVirtualTextHint", { fg = p.hint, bg = "#101d1d" })
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
set("DiffAdd", { fg = p.add, bg = "#102016" })
set("DiffChange", { fg = p.change, bg = "#211e10" })
set("DiffDelete", { fg = p.delete, bg = "#221214" })
set("DiffText", { fg = p.fg_bright, bg = "#332d16", bold = true })
set("Added", { fg = p.add })
set("Changed", { fg = p.change })
set("Removed", { fg = p.delete })
set("GitSignsAdd", { fg = p.add })
set("GitSignsChange", { fg = p.change })
set("GitSignsDelete", { fg = p.delete })
set("GitConflictCurrent", { bg = "#1b1f24" })
set("GitConflictIncoming", { bg = "#12231a" })
set("GitConflictAncestor", { bg = "#282315" })

-- Classic syntax -----------------------------------------------------------
set("Comment", { fg = p.comment, italic = true })
set("Constant", { fg = p.orange })
set("String", { fg = p.green })
set("Character", { fg = p.green })
set("Number", { fg = p.yellow })
set("Boolean", { fg = p.orange, bold = true })
set("Float", { fg = p.yellow })
set("Identifier", { fg = p.fg })
set("Function", { fg = p.blue })
set("Statement", { fg = p.pink })
set("Conditional", { fg = p.pink })
set("Repeat", { fg = p.pink })
set("Label", { fg = p.purple })
set("Operator", { fg = p.cyan })
set("Keyword", { fg = p.pink })
set("Exception", { fg = p.red })
set("PreProc", { fg = p.purple })
set("Include", { fg = p.purple })
set("Define", { fg = p.purple })
set("Macro", { fg = p.purple })
set("Type", { fg = p.teal })
set("StorageClass", { fg = p.pink })
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
set("@comment.documentation", { fg = "#75808c", italic = true })
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
set("@string.documentation", { fg = "#82ad8b", italic = true })
set("@string.escape", { fg = p.cyan, bold = true })
set("@string.regexp", { fg = p.orange })
set("@string.special", { fg = p.orange })
set("@character", { fg = p.green })
set("@character.special", { fg = p.orange })
link("@boolean", "Boolean")
link("@number", "Number")
link("@number.float", "Float")

set("@type", { fg = p.teal })
set("@type.builtin", { fg = p.teal, italic = true })
set("@type.definition", { fg = p.teal })
set("@attribute", { fg = p.purple })
set("@property", { fg = p.fg })

set("@function", { fg = p.blue })
set("@function.builtin", { fg = p.cyan })
set("@function.call", { fg = p.blue })
set("@function.macro", { fg = p.purple })
set("@function.method", { fg = p.blue })
set("@function.method.call", { fg = p.blue })
set("@constructor", { fg = p.teal })

set("@keyword", { fg = p.pink })
set("@keyword.coroutine", { fg = p.pink, italic = true })
set("@keyword.function", { fg = p.pink })
set("@keyword.operator", { fg = p.pink })
set("@keyword.import", { fg = p.purple })
set("@keyword.type", { fg = p.pink })
set("@keyword.modifier", { fg = p.pink })
set("@keyword.repeat", { fg = p.pink })
set("@keyword.return", { fg = p.pink, italic = true })
set("@keyword.debug", { fg = p.red })
set("@keyword.exception", { fg = p.red })
set("@keyword.conditional", { fg = p.pink })
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
set("djangoTagBlock", { fg = p.pink })
set("djangoVarBlock", { fg = p.cyan })
set("djangoStatement", { fg = p.pink })
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
set("FlashLabel", { fg = p.bg0, bg = p.yellow, bold = true })
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
set("RenderMarkdownH3Bg", { bg = "#101216" })
set("RenderMarkdownCode", { bg = p.bg1 })
set("RenderMarkdownCodeInline", { fg = p.green, bg = p.bg1 })
set("RenderMarkdownBullet", { fg = p.purple })
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
vim.g.terminal_color_9 = "#ff7b80"
vim.g.terminal_color_10 = "#98f5a3"
vim.g.terminal_color_11 = "#f2d58a"
vim.g.terminal_color_12 = "#8bb8ff"
vim.g.terminal_color_13 = "#d6a4ff"
vim.g.terminal_color_14 = "#7ee7ff"
vim.g.terminal_color_15 = p.fg_bright

