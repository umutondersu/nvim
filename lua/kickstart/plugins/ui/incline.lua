local Kicons = require 'kickstart.icons'
return {
  'b0o/incline.nvim',
  event = { "BufReadPost", "BufNewFile" },
  dependencies = 'echasnovski/mini.icons',
  opts = {
    window = {
      padding = 0,
      margin = { horizontal = 1, vertical = 2 },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      local seperator = { '| ' }
      if filename == '' then
        filename = '[No Name]'
      end

      local ft_icon, ft_hl = require 'mini.icons'.get('file', filename)
      ft_icon = (ft_icon) .. ' '
      -- Get the color from the highlight group
      local hl_def = vim.api.nvim_get_hl(0, { name = ft_hl or '' })
      local ft_color = hl_def.fg and string.format('#%06x', hl_def.fg) or nil

      local function git_diff()
        local Gicons = Kicons.git
        local icons = {
          removed = Gicons.removed,
          changed = Gicons.modified,
          added = Gicons.added
        }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            -- Get the color from the Diff highlight group but force transparent background
            local diff_hl = vim.api.nvim_get_hl(0, { name = 'Diff' .. name })
            local fg_color = diff_hl.fg and string.format('#%06x', diff_hl.fg) or nil
            table.insert(labels, { icon .. signs[name] .. ' ', guifg = fg_color })
          end
        end
        if #labels > 0 then
          table.insert(labels, seperator)
        end
        return labels
      end

      local function diagnostic_labels()
        local Dicons = Kicons.diagnostics
        local icons = {
          error = Dicons.Error,
          warn = Dicons.Warn,
          info = Dicons.Info,
          hint = Dicons.Hint
        }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, seperator)
        end
        return label
      end

      local function breadcrumbs()
        local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':~:.')
        local path_parts = {}
        if filename == '[No Name]' or filepath == filename then
          return {}
        end

        for part in string.gmatch(filepath, '[^/]+') do
          table.insert(path_parts, part)
        end
        -- Remove the filename
        table.remove(path_parts)

        -- Reverse the table
        for i = 1, math.floor(#path_parts / 2) do
          path_parts[i], path_parts[#path_parts - i + 1] = path_parts[#path_parts - i + 1], path_parts[i]
        end

        if #path_parts > 0 then
          return { ' < ' .. table.concat(path_parts, ' < '), group = '@comment' }
        end
      end

      local function pinned_icon()
        if vim.b[props.buf].pinned == 1 then
          return { ' 󰤱', group = '@comment.note' }
        end
        return {}
      end

      local modified = vim.bo[props.buf].modified
      local function modified_icon()
        if modified then
          return { ' ●', group = '@comment.warning' }
        end
        return {}
      end


      return {
        { diagnostic_labels() },
        { git_diff() },
        { ft_icon,            guifg = ft_color },
        { filename,           gui = 'bold',    group = modified and '@comment.warning' or nil },
        { modified_icon() },
        { pinned_icon() },
        { breadcrumbs() },
        guibg = 'background'
      }
    end,
  }
}
