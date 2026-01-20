return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- Install language parsers
      local parsers = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      }

      require("nvim-treesitter").install(parsers)

      -- Enable treesitter highlighting globally
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Enable treesitter-based indentation
      vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
  {
    -- Incremental selection using treesitter (standalone plugin)
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup({
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
        },
      })

      -- Also set up C-space as an alternative
      vim.keymap.set({ "n", "x" }, "<C-space>", "<CR>", { remap = true, desc = "Increment selection" })
    end,
  },
}
