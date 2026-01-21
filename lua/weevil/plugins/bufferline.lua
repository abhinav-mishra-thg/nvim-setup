return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        separator_style = "slant",
        close_command = function(bufnum)
          require("bufferline").cycle(-1)
          vim.api.nvim_buf_delete(bufnum, { force = false })
        end,
        right_mouse_command = "bdelete! %d",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
            text_align = "left",
          },
        },
        custom_filter = function(buf_number)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= "NvimTree" then
            return true
          end
        end,
        always_show_bufferline = true,
      },
    })
  end,
}
