return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      -- Optional: override colors
      on_colors = function(colors)
        -- you can tweak colors here if needed
      end
    })
    vim.cmd.colorscheme("catppuccin")
  end
}

