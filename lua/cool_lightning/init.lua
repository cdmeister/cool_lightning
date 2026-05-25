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

-- ── Query management ──────────────────────────────────────────────────────────
-- Custom treesitter queries live in lua/cool_lightning/queries/ (non-standard
-- path) so they don't auto-load and affect other colorschemes. They are added
-- to runtimepath only when cool_lightning is active.

local function get_query_path()
  local files = vim.api.nvim_get_runtime_file("lua/cool_lightning/init.lua", false)
  if files and files[1] then
    -- Go up from lua/cool_lightning/ to plugin root, then into our queries dir
    return vim.fn.fnamemodify(files[1], ":h") .. "/queries"
  end
  return nil
end

local function apply_queries()
  local path = get_query_path()
  if path and vim.fn.isdirectory(path) == 1 then
    vim.opt.runtimepath:append(path)
  end
end

local function remove_queries()
  local path = get_query_path()
  if path then
    vim.opt.runtimepath:remove(path)
  end
  -- Clear custom groups so other themes aren't affected
  vim.api.nvim_set_hl(0, "@keyword.typedef", {})
  vim.api.nvim_set_hl(0, "@keyword.struct",  {})
  vim.api.nvim_set_hl(0, "@keyword.enum",    {})
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

  -- Apply custom treesitter queries
  apply_queries()

  -- ── Macro highlights for C/C++ ────────────────────────────────────────────
  local function set_macro_highlights()
    vim.api.nvim_set_hl(0, "MacroFunction", { fg = c.green })
    vim.api.nvim_set_hl(0, "MacroStruct",   { fg = c.fg })
    vim.api.nvim_set_hl(0, "MacroObject",   { fg = c.blue })
  end

  set_macro_highlights()

  -- Watch for colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(args)
      if args.match:find("cool_lightning") then
        -- Reapply when switching between cool_lightning variants
        apply_queries()
        set_macro_highlights()
      else
        -- Remove when switching to another theme
        remove_queries()
      end
    end,
  })

  -- Split macro coloring based on treesitter context
  vim.api.nvim_create_autocmd("LspTokenUpdate", {
    callback = function(args)
      -- Only run when cool_lightning is active
      if not vim.g.colors_name or not vim.g.colors_name:find("cool_lightning") then
        return
      end

      local ft = vim.bo[args.buf].filetype
      if ft ~= "c" and ft ~= "cpp" then return end

      local token = args.data.token
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
