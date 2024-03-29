--------------------------------------------------
-- global variables
--------------------------------------------------
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nog>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.coc_disable_startup_warning = 1

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------
-- local variables
--------------------------------------------------
local api = vim.api
local opt = vim.opt
local Plug = vim.fn["plug#"]

--------------------------------------------------
-- plugins
--------------------------------------------------
require("core.plugins")

--------------------------------------------------
-- define editor settings
--------------------------------------------------
-- tabs & indentation
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.tabstop = 4

-- window splitting
opt.splitbelow = true
opt.splitright = true

opt.ignorecase = true
opt.mouse = "a"
opt.number = true
opt.smartcase = true
opt.ttyfast = true
opt.termguicolors = true
opt.wildchar = 0
opt.wildmenu = true
opt.wildmode = "longest:full,full"

--------------------------------------------------
-- set up packages
--------------------------------------------------
-- lsp
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" }
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = nil

require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- vs code-like snippets
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-o>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
})

require("luasnip.loaders.from_vscode").load({
  include = { "python" },
})

-- lualine
require("lualine").setup()

-- twilight
require("twilight").setup()

-- tmux integration
require("tmux").setup()

-- bufferline
require("bufferline").setup({
  options = {
    close_icon = "x",
  },
})

-- dashboard
require("dashboard").setup()

-- directory tree
require("nvim-tree").setup()
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

-- telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader><space>", telescope.buffers, opts)
vim.keymap.set("n", "<leader>?", telescope.oldfiles, opts)
vim.keymap.set("n", "<leader>ff", telescope.find_files, opts)
vim.keymap.set("n", "<leader>fg", telescope.live_grep, opts)
vim.keymap.set("n", "<leader>fb", telescope.buffers, opts)
vim.keymap.set("n", "<leader>fd", telescope.diagnostics, opts)
vim.keymap.set("n", "<leader>fh", telescope.help_tags, opts)
vim.keymap.set("n", "<leader>fs", telescope.current_buffer_fuzzy_find, opts)
   
-- toggleterm
require("toggleterm").setup()

-- trouble
require("trouble").setup()

-- true zen
require("true-zen").setup()

--------------------------------------------------
-- key mappings
--------------------------------------------------
-- coc autocompletion
vim.keymap.set(
  "n",
  "<Tab>",
  function()
    if vim.fn["coc#pum#visible"]() == 1 then
      vim.fn["coc#pum#confirm"]()
    else
      return "<CR>"
    end
  end,
  opts
)

-- barbar
keymap("n", "<leader>pt", ":BufferPrevious<CR>", opts)
keymap("n", "<leader>nt", ":BufferNext<CR>", opts)

-- twilight
keymap("n", "<leader>tw", ":Twilight<CR>", opts)

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- true-zen
keymap("n", "<leader>za", ":TZAtaraxis<CR>", opts)
keymap("n", "<leader>zf", ":TZFocus<CR>", opts)
keymap("n", "<leader>zm", ":TZMinimalist<CR>", opts)
keymap("n", "<leader>zn", ":TZNarrow<CR>", opts)

-- toggleterm
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)

-- nvim-tree
keymap("n", "<leader>tr", ":NvimTreeToggle<CR>", opts)

-- plug
keymap("n", "<leader>pi", ":PlugInstall<CR>", opts)
keymap("n", "<leader>pu", ":PlugUpdate<CR>", opts)

-- movement
keymap("n", "$", "$l", opts)

-- markdown preview
keymap("n", "<leader>mdp", ":MarkdownPreview<CR>", opts)
keymap("n", "<leader>mds", ":MarkdownPreviewStop<CR>", opts)

--------------------------------------------------
-- set theme
--------------------------------------------------
vim.cmd([[colorscheme aura-soft-dark]])
