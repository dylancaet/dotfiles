-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<leader>nh', ':noh<CR>', opts)

-- file
vim.keymap.set('n', '<leader>fs', '<cmd>wa<CR>', opts) -- save
vim.keymap.set('n', '<leader>fr', function() 
    require("fff").scan_files()
end, opts) -- save
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts) -- quit
vim.keymap.set('n', '<leader>e', ':Neotree float reveal toggle<CR>', opts) -- quit

-- directory
vim.keymap.set('n', '<leader>dc', '<cmd>CdProject<CR>', opts)
vim.keymap.set('n', '<leader>ds', '<cmd>CdProjectManualAdd<CR>', opts)
vim.keymap.set('n', '<leader>dd', '<cmd>CdProjectDelete<CR>', opts)

-- annotations
vim.keymap.set("n", "<Leader>nf", "<cmd>lua require('neogen').generate()<CR>", opts)

-- quickfix
vim.keymap.set("n", "<Leader>qd", "<cmd>TodoQuickFix<CR>", opts)

-- notifications
vim.keymap.set("n", "<Leader>nn", "<cmd>lua require('snacks.notifier').show_history()<CR>", opts)

-- lsp
vim.keymap.set({ "n", "x" }, "gra", function()
	require("tiny-code-action").code_action()
end, opts)
vim.keymap.set("n", "<leader>lh", "<cmd>InlayHintsToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle inlay hints", }))

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)
vim.keymap.set('n', 'D', '"_D', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', ']b', ':bnext<CR>', opts)
vim.keymap.set('n', '[b', ':bprevious<CR>', opts)
-- vim.keymap.set('n', '<C-i>', '<C-i>', opts) -- to restore jump forward
vim.keymap.set('n', '<leader>c', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', opts) -- pick buffer
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", vim.tbl_extend("force", opts, { desc = "Close other buffers" }))
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", vim.tbl_extend("force", opts, { desc = "Close buffers to the left" }))
vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", vim.tbl_extend("force", opts, { desc = "Close buffers to the right" }))

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Press jk fast to exit insert mode
vim.keymap.set('i', 'jk', '<ESC>', opts)
vim.keymap.set('i', 'kj', '<ESC>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set({ "n", "v" }, "<C-ScrollWheelUp>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
vim.keymap.set({ "n", "v" }, "<C-ScrollWheelDown>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
