---@type LazyPluginSpec
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local arttoggle = false

    local logo = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }

    if arttoggle then
      require("alpha.term")
      local art = {
        { "tohru", 62, 17 },
      }
      local current = art[1]
      local path = vim.fn.stdpath("config") .. "/assets/"
      dashboard.section.terminal.command = "cat " .. path .. current[1]
      dashboard.section.terminal.width = current[2]
      dashboard.section.terminal.height = current[3]
      dashboard.section.terminal.opts.redraw = true
      dashboard.opts.opts.noautocmd = true

      dashboard.opts.layout = {
        dashboard.section.terminal,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
      }
    else
      dashboard.section.header.val = logo
      dashboard.opts.layout = {
        { type = "padding", val = 4 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }
    end

    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. "Find files", ":Telescope find_files <CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    dashboard.section.header.opts.hl = "Function"
    dashboard.section.buttons.opts.hl = "Identifier"
    dashboard.section.footer.opts.hl = "Function"

    return dashboard
  end,

  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local v = vim.version()
        local dev = v.prerelease == "dev" and ("-dev+" .. v.build) or ""
        local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev

        local stats = require("lazy").stats()
        local plugins = stats.loaded .. "/" .. stats.count
        local ms = math.floor(stats.startuptime + 0.5)

        local time = vim.fn.strftime("%H:%M:%S")
        local date = vim.fn.strftime("%d.%m.%Y")

        local line1 = " " .. plugins .. " plugins loaded in " .. ms .. "ms"
        local line2 = "󰃭 " .. date .. "  " .. time
        local line3 = " " .. version

        local line1_width = vim.fn.strdisplaywidth(line1)
        local pad = function(text)
          return string.rep(" ", math.floor((line1_width - vim.fn.strdisplaywidth(text)) / 2)) .. text
        end

        dashboard.section.footer.val = {
          line1,
          pad(line2),
          pad(line3),
        }

        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Optional: load your custom keymaps file
    -- pcall(require, "config.keymaps")
  end,
}

