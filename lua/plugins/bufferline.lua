return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      mode = "tabs",
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
    })
    return opts
  end,
}
