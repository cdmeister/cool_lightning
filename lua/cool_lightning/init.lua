-- lua/cool_lightning/init.lua
-- Cool Lightning — main entry point

local M = {}

-- Default config
M.config = {
  -- Available styles:
  -- Dark:  "midnight" | "dusk" | "twilight" | "ember"
  -- Light: "dawn"
  style = "midnight",
}

-- All custom highlight groups defined by cool_lightning
-- These get cleared when switching to another theme
local custom_groups = {
  -- Macro splits
  "MacroFunction",
  "MacroStruct",
  "MacroObject",
  "FunctionPtrTypedef",
  -- Keyword type splits (from queries/)
  "@keyword.typedef",
  "@keyword.struct",
  "@keyword.enum",
  -- Function pointer typedefs (from queries/)
  "@type.function_ptr",
}

local function clear_custom_groups()
  for _, group in ipairs(custom_groups) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})

  local palette = require("cool_lightning.palette")
  local highlights = require("cool_lightning.highlights")
  local c = palette.get(M.config.style)

  -- Set background type so Neovim knows light vs dark
  if M.config.style == "dawn" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end

  -- Apply all highlight groups
  highlights.setup(c)

  -- ── Macro highlights for C/C++ ────────────────────────────────────────────
  local function set_macro_highlights()
    vim.api.nvim_set_hl(0, "MacroFunction",     { fg = c.green })
    vim.api.nvim_set_hl(0, "MacroStruct",       { fg = c.fg })
    vim.api.nvim_set_hl(0, "MacroObject",       { fg = c.blue })
    vim.api.nvim_set_hl(0, "FunctionPtrTypedef", { fg = c.func_ptr, italic = true })
  end

  set_macro_highlights()

  -- Watch for colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(args)
      if args.match:find("cool_lightning") then
        -- Reapply when switching between cool_lightning variants
        local new_c = palette.get(M.config.style)
        highlights.setup(new_c)
        set_macro_highlights()
      else
        -- Clear all custom groups when switching to another theme
        clear_custom_groups()
      end
    end,
  })

  -- Split macro coloring based on treesitter context
  -- Only fires when cool_lightning is active
  vim.api.nvim_create_autocmd("LspTokenUpdate", {
    callback = function(args)
      if not vim.g.colors_name or not vim.g.colors_name:find("cool_lightning") then
        return
      end

      local ft = vim.bo[args.buf].filetype
      if ft ~= "c" and ft ~= "cpp" then return end

      local token = args.data.token

      -- Function pointer typedef detection
      if token.type == "type" then
        local node = vim.treesitter.get_node({
          bufnr = args.buf,
          pos = { token.line, token.start_col },
        })
        local parent = node and node:parent()
        local grandparent = parent and parent:parent()
        local great = grandparent and grandparent:parent()
        local great_great = great and great:parent()
        if parent and parent:type() == "pointer_declarator"
          and grandparent and grandparent:type() == "parenthesized_declarator"
          and great and great:type() == "function_declarator"
          and great_great and great_great:type() == "type_definition" then
          vim.lsp.semantic_tokens.highlight_token(
            token, args.buf, args.data.client_id, "FunctionPtrTypedef")
          return
        end
      end

      -- Macro splitting
      if token.type ~= "macro" then return end

      local node = vim.treesitter.get_node({
        bufnr = args.buf,
        pos = { token.line, token.start_col },
      })

      local parent = node and node:parent()
      local is_call = parent and (
        parent:type() == "call_expression" or
        parent:type() == "function_declarator"
      )
      local is_struct = parent and (
        parent:type() == "field_expression" or
        parent:type() == "pointer_expression" or
        parent:type() == "field_declarator"
      )

      local hl = is_call and "MacroFunction"
              or is_struct and "MacroStruct"
              or "MacroObject"
      vim.lsp.semantic_tokens.highlight_token(
        token, args.buf, args.data.client_id, hl)
    end,
  })

  -- Terminal colors
  vim.g.terminal_color_0  = c.bg
  vim.g.terminal_color_1  = c.red
  vim.g.terminal_color_2  = c.green
  vim.g.terminal_color_3  = c.modifier
  vim.g.terminal_color_4  = c.blue
  vim.g.terminal_color_5  = c.purple
  vim.g.terminal_color_6  = c.cyan
  vim.g.terminal_color_7  = c.fg
  vim.g.terminal_color_8  = c.fg_muted
  vim.g.terminal_color_9  = c.red
  vim.g.terminal_color_10 = c.green
  vim.g.terminal_color_11 = c.modifier
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.purple
  vim.g.terminal_color_14 = c.cyan
  vim.g.terminal_color_15 = c.gypsum
end

return M
