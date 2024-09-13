-- TODO: move customizations to your own file and import them here

--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
-- lvim.format_on_save = true

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

--
-- https://github.com/LunarVim/LunarVim/issues/3351#issuecomment-1363423166
-- Show previewer when searching git files with default <leader>f
lvim.builtin.which_key.mappings["f"] = {
  require("lvim.core.telescope.custom-finders").find_project_files,
  "Find File"
}
-- Show previewer when searching buffers with <leader>bf
lvim.builtin.which_key.mappings.b.f = {
  "<cmd>Telescope buffers<cr>",
  "Find"
}
-- Uncomment if "graphical weirdness" is encountered:
-- lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
-- lvim.builtin.telescope.defaults.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
--

----
-- workaround for a bug in nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1167#issuecomment-920824125
-- function _G.javascript_indent()
--   local line = vim.fn.getline(vim.v.lnum)
--   local prev_line = vim.fn.getline(vim.v.lnum - 1)
--   if line:match('^%s*[%*/]%s*') then
--     if prev_line:match('^%s*%*%s*') then
--       return vim.fn.indent(vim.v.lnum - 1)
--     end
--     if prev_line:match('^%s*/%*%*%s*$') then
--       return vim.fn.indent(vim.v.lnum - 1) + 1
--     end
--   end

--   return vim.fn['GetJavascriptIndent']()
-- end

vim.cmd [[autocmd FileType javascript setlocal indentexpr=v:lua.javascript_indent()]]
---- end workaround

vim.opt.termguicolors = true

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 20

-- lvim.colorscheme = "gruvbox-material"
lvim.colorscheme = "lunar"
-- vim.g["gruvbox_material_background"] = "hard"
-- cmd "hi CursorLine term=bold cterm=bold guibg=Grey40"
-- cmd "hi CursorLine cterm=NONE ctermbg=white ctermfg=black"

-- Improve visibility of comments
vim.api.nvim_command([[
  augroup ChangeCommentColour
    autocmd colorscheme * :hi Comment guifg=#788470
  augroup END
]])

require('nvim-autopairs').disable()

-- vim.g.bufferline.icon_pinned = '車';

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>q"] =
"<CMD>NvimTreeClose<CR> <BAR> <CMD>mksession! Session.vim<CR> <BAR> <CMD>q<CR>" --"<CMD>NvimTreeClose<CR> <BAR> <CMD>mksession!<CR> <BAR> <CMD>q<CR>"
lvim.keys.normal_mode["<leader>bP"] = "<CMD>BufferLineTogglePin<CR>"
lvim.keys.normal_mode["<leader>bp"] = "<CMD>BufferLinePick<CR>"
lvim.keys.normal_mode["<leader>b<"] = "<CMD>BufferLineMovePrev<CR>"
lvim.keys.normal_mode["<leader>b>"] = "<CMD>BufferLineMoveNext<CR>"

lvim.keys.normal_mode["<S-h>"] = "<CMD>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-l>"] = "<CMD>BufferLineCycleNext<CR>"

lvim.keys.normal_mode["<leader>O"] = "O<ESC>O"
lvim.keys.normal_mode["<leader>o"] = "o<ESC>o"

-- Save a session quickly
lvim.keys.normal_mode["<leader>S"] = ":mksession! Session.vim<CR>:echo \"Session saved.\"<CR>"

lvim.builtin.which_key.mappings["r"] = {
  name = "Restart",
  -- Sometimes eslint gets tripped up on a configuration change and needs to be restarted
  e = { ":! eslint_d restart <CR><CR>", "Restart Eslint" },
  -- When GHCIDE chokes on an error, it needs to be restarted
  h = { ":LspRestart<CR>", "Restart LSP" }
}

-- Make search window wider
lvim.builtin.telescope.defaults.layout_config = {
  width = function(_, cols, _)
    if cols > 200 then
      return 170
    else
      return cols
    end
  end,
}

--
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.mode = "dashboard";
-- lvim.builtin.notify.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = 'float'
lvim.builtin.terminal.shade_terminals = true
lvim.builtin.terminal.shade_filetypes = {}
lvim.builtin.terminal.shading_factor = -20
lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.terminal.float_opts = {
  width = 300
}


-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "yaml",
  "haskell",
  "svelte",
  "ruby"
}

lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "svelte" },
  }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  -- {
  --   -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "shellcheck",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--severity", "warning" },
  -- },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
  { command = "eslint_d" }
}

-- Additional Plugins
lvim.plugins = {
  --     {"folke/tokyonight.nvim"},
  --     {
  --       "folke/trouble.nvim",
  --       cmd = "TroubleToggle",
  --     },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  { "sainnhe/gruvbox-material" },
  -- { "Yilin-Yang/vim-markbar" },
  { "pangloss/vim-javascript" },
  { "jparise/vim-graphql" },
  { "tpope/vim-surround" },
  { "lambdalisue/suda.vim" },
  { "karb94/neoscroll.nvim" },
  { "evanleck/vim-svelte" },
  { "Equilibris/nx.nvim" },
  { "easymotion/vim-easymotion" },
  { "wakatime/vim-wakatime" },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  { "tpope/vim-rails" },
  { "chentoast/marks.nvim" },
}

-- Setup for plugins
lvim.builtin.treesitter.rainbow.enable = true

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_b = { components.branch, components.diff }
lvim.builtin.lualine.sections.lualine_c = { "%{@%}", components.diagnostics }
-- lvim.builtin.lualine.sections.lualine_c = { "echo substitute(getcwd(), ':t')", components.filename }
lvim.builtin.lualine.sections.lualine_x = { components.filetype }
lvim.builtin.lualine.sections.lualine_y = { components.location }

lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.separator_style = 'slant'

require('neoscroll').setup({
  cursor_scrolls_alone = false,
  easing_function = 'sine'
})

require('nx').setup({
  -- Base command to run all other nx commands, some other values may be:
  -- - `npm nx`
  -- - `yarn nx`
  -- - `pnpm nx`
  nx_cmd_root = 'nx',

  -- Command running capabilities,
  -- see nx.m.command-runners for more details
  command_runner = require('nx.command-runners').terminal_cmd(),
  -- Form rendering capabilities,
  -- see nx.m.form-renderers for more detials
  form_renderer = require('nx.form-renderers').telescope(),

  -- Whether or not to load nx configuration,
  -- see nx.loading-and-reloading for more details
  read_init = true
})

require('marks').setup({
  default_mappings = true,
  signs = true,
  mappings = {}
})

-- vim.api.nvim_command('augroup javascript_folding')
-- vim.api.nvim_command('au!')
-- vim.api.nvim_command('au FileType javascript setlocal foldmethod=syntax')
-- vim.api.nvim_command('au FileType typescript setlocal foldmethod=syntax')
-- vim.api.nvim_command('augroup END')

-- TODO: Customize folding text, and consider other options at https://github.com/pangloss/vim-javascript#concealing-characters
-- vim.g["javascript_conceal_function"]             = "ƒ"
-- vim.g["javascript_conceal_null"]                 = "ø"
-- vim.g["javascript_conceal_this"]                 = "@"
-- vim.g["javascript_conceal_return"]               = "⇚"
-- vim.g["javascript_conceal_undefined"]            = "¿"
-- vim.g["javascript_conceal_NaN"]                  = "ℕ"
-- vim.g["javascript_conceal_prototype"]            = "¶"
-- vim.g["javascript_conceal_static"]               = "•"
-- vim.g["javascript_conceal_super"]                = "Ω"
-- vim.g["javascript_conceal_arrow_function"]       = "⇒"
-- vim.g["javascript_conceal_noarg_arrow_function"] = "🞅"
-- vim.g["javascript_conceal_underscore_arrow_function"] = "🞅"

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

local init_custom_options = function()
  local custom_options = {
    relativenumber = true, -- Set relative numbered lines
    colorcolumn = "120",   -- Indent line at what column? Set something like '99999' to not display it
    scrolloff = 3,         -- Determines the number of context lines you would like to see above and below the cursor
    ignorecase = true,     -- Ignore case in search
    smartcase = true,      -- Case-sensitive search when search term contains uppercase characters. Otherwise, case-sensitive search.  timeoutlen = 200, -- Time to wait for a mapped sequence to complete (in milliseconds)
    foldmethod = "indent",
    foldlevelstart = 20,
    textwidth = 120,
  }

  for k, v in pairs(custom_options) do
    vim.opt[k] = v
  end
end
init_custom_options()

-- TODO: move customizations to your own file and import them here
-- TODO: enable drawing line for indents
