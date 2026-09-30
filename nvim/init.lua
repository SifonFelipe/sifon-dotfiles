-- Single-file Neovim configuration, focused on Python and Django.

local opt, map = vim.opt, vim.keymap.set
local autocmd, augroup = vim.api.nvim_create_autocmd, vim.api.nvim_create_augroup

vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.loaded_netrw, vim.g.loaded_netrwPlugin = 1, 1
vim.g.netrw_liststyle, vim.g.netrw_banner = 3, 0

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.mouse = "a"
opt.shell = "/bin/bash"
opt.fillchars:append({ vert = " " })
opt.expandtab = true
opt.shiftwidth, opt.tabstop, opt.softtabstop = 4, 4, 4
opt.smartindent, opt.autoindent = true, true
opt.incsearch, opt.hlsearch = true, true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmode = "list:longest"
opt.updatetime, opt.timeoutlen = 250, 300
opt.textwidth, opt.signcolumn = 100, "yes"
opt.splitright, opt.splitbelow = true, true

vim.filetype.add({ pattern = {
  [".*/templates/.*%.html"] = "htmldjango",
  [".*/templates/.*%.htm"] = "htmldjango",
} })

autocmd("FileType", {
  pattern = { "html", "htmldjango", "yaml", "json", "javascript", "typescript", "css" },
  callback = function()
    vim.bo.shiftwidth, vim.bo.tabstop, vim.bo.softtabstop = 2, 2, 2
  end,
})
autocmd("BufWritePre", {
  group = augroup("TrimPythonWhitespace", { clear = true }),
  pattern = "*.py",
  command = "%s/\\s\\+$//e",
})

vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null", {})
vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})
map("n", "//", "<cmd>noh<cr>", { desc = "Clear search highlight" })
map("n", "tt", "<cmd>tabnew<cr>", { desc = "New tab" })
map({ "n", "i" }, "<M-Right>", "<cmd>tabn<cr>", { desc = "Next tab" })
map({ "n", "i" }, "<M-Left>", "<cmd>tabp<cr>", { desc = "Previous tab" })
-- <leader>e belongs to FzfLua file search. Keep diagnostics on a different prefix.
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostic details" })
vim.cmd("cnoreabbrev chat CopilotChat")

autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    map("n", "<leader>b", "Oimport ipdb; ipdb.set_trace()<esc>", { buffer = args.buf, desc = "Add IPDB breakpoint" })
  end,
})

local python_markers = {
  "pyproject.toml", "pyrightconfig.json", "setup.py", "setup.cfg",
  "requirements.txt", "Pipfile", "manage.py", "ruff.toml", ".ruff.toml", ".git",
}
local function project_root(bufnr)
  return vim.fs.root(vim.api.nvim_buf_get_name(bufnr or 0), python_markers) or vim.fn.getcwd()
end
local function project_python(root)
  if vim.env.VIRTUAL_ENV then
    for _, rel in ipairs({ "bin/python", "Scripts/python.exe" }) do
      local python = vim.fs.joinpath(vim.env.VIRTUAL_ENV, rel)
      if vim.fn.executable(python) == 1 then return python end
    end
  end
  for _, rel in ipairs({ ".venv/bin/python", "venv/bin/python", "env/bin/python", ".venv/Scripts/python.exe", "venv/Scripts/python.exe" }) do
    local python = vim.fs.joinpath(root, rel)
    if vim.fn.executable(python) == 1 then return python end
  end
  return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or vim.fn.exepath("python")
end
local function extra_paths(root)
  local paths = {}
  local src = vim.fs.joinpath(root, "src")
  if vim.fn.isdirectory(src) == 1 then table.insert(paths, src) end
  table.insert(paths, root)
  return paths
end

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true, header = "" },
})

-- Render diagnostics in the statusline, never in the interactive message area.
-- Neovim handles clipping, including wide characters and narrow windows.
local function line_diagnostic()
  if vim.bo.buftype ~= "" then return "" end
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  if #diagnostics == 0 then return "" end

  local diagnostic = diagnostics[1]
  for _, candidate in ipairs(diagnostics) do
    if candidate.severity < diagnostic.severity then diagnostic = candidate end
  end
  local labels = { "Error", "Warning", "Info", "Hint" }
  local message = diagnostic.message:gsub("%s+", " ")
  local source = diagnostic.source and (" [" .. diagnostic.source .. "]") or ""
  -- Escape statusline directives supplied as part of a diagnostic's text.
  return ((labels[diagnostic.severity] or "Diagnostic") .. ": " .. message .. source)
    :gsub("%c", " "):gsub("%%", "%%%%")
end

-- Also remove the old message callbacks when using :ReloadConfig.
augroup("CursorLineDiagnostic", { clear = true })
autocmd("LspAttach", {
  group = augroup("LspKeymaps", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local function bmap(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end
    bmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    bmap("n", "gr", vim.lsp.buf.references, "Find references")
    bmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    bmap("n", "K", vim.lsp.buf.hover, "Show hover documentation")
    bmap("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")
    bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    bmap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    bmap("n", "<leader>ld", vim.diagnostic.open_float, "Show diagnostic details")
    bmap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
    bmap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
    if client and client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.documentSymbolProvider = false
    end
  end,
})

vim.api.nvim_create_user_command("PythonInstallDjangoStubs", function()
  local root, python = project_root(0), project_python(project_root(0))
  local system_python = vim.fn.exepath("python3")
  local selected_env = vim.env.VIRTUAL_ENV ~= nil
    or (python ~= "" and python ~= system_python and not python:match("/usr/bin/python"))
  if not selected_env then
    vim.notify("Select a project environment with <leader>vs first.", vim.log.levels.WARN)
    return
  end
  local uv = vim.fn.exepath("uv")
  local command = uv ~= ""
    and { uv, "pip", "install", "--python", python, "django-stubs", "django-stubs-ext" }
    or { python, "-m", "pip", "install", "django-stubs", "django-stubs-ext" }
  vim.notify("Installing django-stubs in the selected project environment...", vim.log.levels.INFO)
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stderr = function(_, data)
      if data and #data > 0 then vim.schedule(function() vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR) end) end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("Django stubs installed. Restart the Python LSP with :LspRestart.", vim.log.levels.INFO)
        else
          vim.notify("Django stubs installation failed with exit code " .. code .. ".", vim.log.levels.ERROR)
        end
      end)
    end,
  })
end, { desc = "Install Django type stubs in the project virtualenv" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
opt.rtp:prepend(lazypath)

local plugins = {
  { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = { ensure_installed = { "lua_ls", "basedpyright", "ruff" }, automatic_enable = false },
  },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", dependencies = { "williamboman/mason.nvim" }, opts = { ensure_installed = { "debugpy" } } },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local default_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]

      vim.lsp.config("lua_ls", { settings = { Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      } } })
      vim.lsp.config("basedpyright", {
        root_markers = python_markers,
        before_init = function(_, config)
          local root = config.root_dir or vim.fn.getcwd()
          config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
            python = { pythonPath = project_python(root) },
            basedpyright = { analysis = { extraPaths = extra_paths(root), stubPath = vim.fs.joinpath(root, "typings") } },
          })
        end,
        settings = { basedpyright = {
          disableOrganizeImports = true,
          analysis = {
          typeCheckingMode = "basic",
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          exclude = { "**/.venv", "**/venv", "**/env", "**/.env", "**/node_modules", "**/migrations", "**/staticfiles", "**/static", "**/media", "**/__pycache__" },
          diagnosticSeverityOverrides = {
            reportAttributeAccessIssue = "warning",
            reportGeneralTypeIssues = "warning",
            reportArgumentType = "warning",
            reportCallIssue = "warning",
          },
        },
      },
    },
      })
      vim.lsp.config("ruff", {
        cmd = { "ruff", "server" },
        root_markers = python_markers,
        handlers = {
          ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
            if result and result.diagnostics then
              result.diagnostics = vim.tbl_filter(function(diagnostic)
                local code = tostring(diagnostic.code or "")
                local message = diagnostic.message or ""
                return code ~= "I001"
                  and code ~= "unsorted-imports"
                  and not message:match("^Import block is un%-sorted or un%-formatted")
              end, result.diagnostics)
            end
            return default_publish_diagnostics(err, result, ctx, config)
          end,
        },
        init_options = { settings = {
          logLevel = "error",
          lineLength = 100,
          configurationPreference = "editorFirst",
          lint = {
            enable = true,
            run = "onSave",
            preview = true,
            select = { "E", "F", "W", "B", "UP", "DJ" },
            ignore = { "I001" },
          },
          organizeImports = false,
          fixAll = false,
        } },
      })
      vim.lsp.enable({ "lua_ls", "basedpyright", "ruff" })
    end,
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" }, ["<Tab>"] = { "select_next", "fallback" }, ["<S-Tab>"] = { "select_prev", "fallback" }, ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" } },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 }, menu = { draw = { treesitter = { "lsp" } } } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = { { "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format buffer" } },
    opts = {
      -- Formatting is manual with <leader>cf; saving never rewrites code.
      formatters_by_ft = { python = { "ruff_format" } },
      notify_on_error = true,
      notify_no_formatters = false,
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python virtualenv" } },
    opts = {
      options = {
        picker = "fzf-lua",
        require_lsp_activation = false,
        enable_default_searches = true,
        notify_user_on_venv_activation = true,
      },
      search = {
        project = {
          command = "$FD '/bin/python$' '$CWD' --full-path --color never -HI -a -L -E /proc -E .git/ -E site-packages/",
        },
        file = {
          command = "$FD '/bin/python$' '$FILE_DIR' --full-path --color never -HI -a -L -E /proc -E .git/ -E site-packages/",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mfussenegger/nvim-dap-python" },
    keys = {
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Debug step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Debug step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle debug REPL" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate debugging" },
      { "<leader>dt", function() require("dap-python").test_method() end, desc = "Debug Python test" },
    },
    config = function()
      local python = project_python(project_root(0))
      require("dap-python").setup(python ~= "" and python or "python")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "bash", "c", "css", "html", "javascript", "json", "lua", "markdown", "python", "query", "regex", "toml", "typescript", "vim", "vimdoc", "yaml" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      pcall(vim.treesitter.language.register, "html", "htmldjango")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", event = { "BufReadPre", "BufNewFile" }, opts = { enable = true, max_lines = 3, trim_scope = "outer" } },
  { "windwp/nvim-ts-autotag", event = { "BufReadPre", "BufNewFile" }, ft = { "html", "htmldjango", "javascript", "typescript", "javascriptreact", "typescriptreact" }, opts = {} },
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", lazy = false, dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" }, opts = { filesystem = { hijack_netrw_behavior = "open_current", bind_to_cwd = false, follow_current_file = { enabled = true } }, window = { position = "left", width = 30, mappings = { ["l"] = "open", ["h"] = "navigate_up", ["<cr>"] = "open" } } }, keys = { { "<F3>", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" } } },
  { "nvim-tree/nvim-web-devicons", lazy = true, opts = { color_icons = true, default = true, strict = true } },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>FzfLua files<cr>", desc = "Find files", nowait = true },
      { ",f", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Search current buffer" },
      { ",r", "<cmd>FzfLua live_grep<cr>", desc = "Search project" },
      { ",b", "<cmd>FzfLua buffers<cr>", desc = "Open buffers" },
      { ",h", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { ",g", "<cmd>FzfLua btags<cr>", desc = "Buffer tags" },
      { ",G", "<cmd>FzfLua tags<cr>", desc = "Project tags" },
      { "<leader>lg", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>lG", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace symbols" },
    },
    opts = {
      files = { cmd = "fd --type f --hidden --exclude .git --exclude node_modules --exclude .venv --exclude .cache" },
      grep = { rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git'" },
    },
  },
  { "folke/flash.nvim", event = "VeryLazy", opts = {}, keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" }, { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" } } },
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
  { "brenoprata10/nvim-highlight-colors", event = { "BufReadPre", "BufNewFile" }, opts = { render = "background", enable_named_colors = true, enable_tailing = true } },
  { "MeanderingProgrammer/render-markdown.nvim", ft = "markdown", dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, opts = {} },
  { "rktjmp/lush.nvim", cmd = { "Lushify", "LushImport" } },
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" }, keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" }, { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" } }, opts = {} },
  { "akinsho/git-conflict.nvim", version = "*", config = true, keys = { { "<leader>co", "<cmd>GitConflictChooseOurs<cr>" }, { "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>" }, { "<leader>cb", "<cmd>GitConflictChooseBoth<cr>" }, { "<leader>c0", "<cmd>GitConflictChooseNone<cr>" }, { "]x", "<cmd>GitConflictNextConflict<cr>" }, { "[x", "<cmd>GitConflictPrevConflict<cr>" } } },
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoFzfLua", "TodoQuickFix", "TodoLocList", "TodoTrouble" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<F2>", "<cmd>TodoFzfLua<cr>", desc = "Search TODO comments" } },
    opts = {
      keywords = {
        NOTE = { icon = "i", color = "hint", alt = { "INFO", "REMEMBER" } },
        IMPORTANT = { icon = "!", color = "error", alt = { "CRITICAL", "ATTENTION" } },
        CHECK = { icon = "v", color = "info", alt = { "VERIFY", "CHECKME" } },
        REVIEW = { icon = "R", color = "warning", alt = { "REVIEWME", "INSPECT" } },
        QUESTION = { icon = "?", color = "warning", alt = { "DOUBT", "QUESTIONME" } },
        IDEA = { icon = "*", color = "hint", alt = { "THOUGHT", "SUGGESTION" } },
        WARN = { icon = "!", color = "warning", alt = { "WARNING", "CAUTION" } },
        DEV = { icon = "@", color = "hint", alt = { "DEVELOP", "DEBUG", "TEST" } },
      },
    },
  },
  { "folke/trouble.nvim", cmd = "Trouble", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {}, keys = { { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" }, { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" }, { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" } } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = { options = { theme = "auto", globalstatus = true }, sections = { lualine_c = { "filename", line_diagnostic } } } },
  { "ludovicchabant/vim-gutentags", lazy = false, init = function() vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. "/gutentags"; vim.g.gutentags_add_default_project_roots = true; vim.g.gutentags_project_root = { ".git", "manage.py", "pyproject.toml", "package.json" }; vim.g.gutentags_ctags_exclude = { "*.min.js", "node_modules", ".venv", "venv", ".cache", "dist", "build" }; opt.tags = { "./tags;", "tags;" } end },
  { "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter", opts = { suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<M-l>", next = "<M-]>", prev = "<M-[>", dismiss = "<C-]>" } }, panel = { enabled = false } } },
  { "mluders/comfy-line-numbers.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  { "ellisonleao/gruvbox.nvim", config = function() require("gruvbox").setup({ terminal_colors = true, undercurl = true, underline = true, bold = true, italic = { strings = true, emphasis = true, comments = true, folds = true } }) end },
}

require("lazy").setup(plugins, {
  change_detection = { notify = false },
  checker = { enabled = false },
  performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

local theme_file = vim.fn.stdpath("config") .. "/.current_theme"
local saved = io.open(theme_file, "r")
local theme = saved and saved:read("*l") or "gruvbox"
if saved then saved:close() end
autocmd("ColorScheme", {
  group = augroup("PersistTheme", { clear = true }),
  callback = function(args)
    if args.match == "default" then return end
    local current = io.open(theme_file, "w")
    if current then current:write(args.match); current:close() end
  end,
})
if not pcall(vim.cmd.colorscheme, theme) then vim.cmd.colorscheme("gruvbox") end

