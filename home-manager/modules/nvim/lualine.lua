-- -------------------------
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
-- MIT license, see LICENSE for more details.
-- -------------------------


-- -------------------------
-- Custom Kanagawa themed colors
-- Reformatted sections
-- -------------------------

require('lualine')

-- stylua: ignore
    local colors = {
      bg = '#24273A',       -- Base
      fg = '#CAD3F5',       -- Text
      blue = '#8AADF4',     -- Blue
      darkblue = '#5B6078', -- Subtext
      yellow = '#EED49F',   -- Yellow
      pink = '#F5BDE6',     -- Pink
      transparentbg = nil,
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
    }

    -- Word count component
    local function word_count()
      if vim.bo.filetype ~= "markdown" and vim.bo.filetype ~= "text" then
        return ""
      end
      local wc = vim.fn.wordcount()
      return wc.words
    end

    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.transparentbg } },
          inactive = { c = { fg = colors.fg, bg = colors.transparentbg} },
        },
				globalstatus = true,
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- left
    ins_left {
      function()
        return '▊'
      end,
      color = { fg = colors.yellow},
      padding = { left = 0, right = 1 },
    }

    ins_left {
      'mode',
      color = function()
        local mode_color = {
          n = colors.pink,
          i = colors.yellow,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
        }
        return { fg = mode_color[vim.fn.mode()] or colors.pink }
      end,
      padding = { right = 1 }
    }

    ins_left { 'location' }

    ins_left {
      word_count,
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.yellow, gui = 'bold' },
    }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = {  error = ' ', warn = ' ', info = '󰋽' },
      diagnostics_color = {
        error = { fg = colors.pink },
        warn = { fg = colors.yellow },
        info = { fg = colors.blue },
      },
    }

    -- right
    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = true,
      color = { fg = colors.yellow, gui = 'bold' },
    }

    ins_right { 'filetype' }

    ins_right {
      'progress',
      color = { fg = colors.fg, gui = 'bold' }
    }

    ins_right {
      'branch',
      icon = '',
      color = { fg = colors.pink, gui = 'bold' },
    }

    ins_right {
      function()
        return os.date("%H:%M")
      end,
      color = { fg = colors.blue, gui = 'bold' }
    }

    ins_right {
      function()
        return '▊'
      end,
      color = { fg = colors.yellow},
      padding = { left = 1 },
    }

    require('lualine').setup(config)
