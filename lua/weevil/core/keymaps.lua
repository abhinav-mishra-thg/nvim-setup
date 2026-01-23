-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffer management
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Go to next buffer" }) -- go to next buffer
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" }) -- go to previous buffer
keymap.set("n", "<leader>bx", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  if #buffers > 1 then
    vim.cmd("bprevious")
  end
  vim.api.nvim_buf_delete(bufnr, { force = false })
end, { desc = "Close current buffer" })
keymap.set("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "Close all buffers but current" }) -- close all buffers except current
keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" }) -- go to previous buffer with Shift+h
keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" }) -- go to next buffer with Shift+l
keymap.set("n", "<S-k>", "<cmd>bfirst<CR>", { desc = "Go to first buffer" }) -- go to first buffer with Shift+k
keymap.set("n", "<S-j>", "<cmd>blast<CR>", { desc = "Go to last buffer" }) -- go to last buffer with Shift+j

-- markdown rendering (render-markdown.nvim)
keymap.set("n", "<leader>mv", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown rendering" })
