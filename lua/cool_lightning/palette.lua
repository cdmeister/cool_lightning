-- lua/cool_lightning/palette.lua
-- Cool Lightning — color palette with style variants

-- ─── Semantic color guide ────────────────────────────────────────────────────
-- gypsum          #e8e4dc   variables, primitives (dark variants)
-- keyword         #8b6fe8   keywords/control flow (violet)
-- red             #ff3a7e   errors, diagnostics
-- orange          #ffaf5f   type builtins, warnings
-- modifier        #f5d070   static/const/volatile/extern (warm gold)
-- string          #9ece6a   strings
-- green           #a8d96a   functions
-- green_dim       #80c060   methods
-- blue            #0db9d7   macros, enum members, named constants, operators
-- param           #c792ea   function parameters
-- purple          #b282fe   numbers, pure constants
-- teal            #4db8a0   struct/class types
-- teal_type       #9ddec9   typedef handles
-- type_stdlib     #ff8fa3   stdlib typedefs coral-pink
-- comment         #a8a8d0   comments
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

-- Shared syntax colors (same across all dark variants)
local syntax = {
  fg         = "#c4c4b5",
  fg_dim     = "#8890b0",
  fg_muted   = "#565f89",
  gypsum     = "#e8e4dc",
  keyword    = "#8b6fe8",
  red        = "#ff3a7e",
  orange     = "#ffaf5f",
  modifier   = "#f5d070",
  string     = "#6dd4f0",
  green      = "#8adc58",
  green_dim  = "#6ec048",
  blue       = "#0db9d7",
  blue_dim   = "#0a9ab5",
  cyan       = "#7dcfff",
  param      = "#c792ea",
  purple     = "#b282fe",
  purple_dim = "#9d7cd8",
  teal       = "#4db8a0",
  teal_type  = "#9ddec9",
  type_stdlib = "#ff8fa3",
  comment    = "#a8a8d0",
  border_hl  = "#27a1b9",
  error      = "#ff3a7e",
  warn       = "#ffaf5f",
  info       = "#0db9d7",
  hint       = "#b282fe",
}

local variants = {
  -- ── Dark variants ─────────────────────────────────────────────────────────

  -- midnight: deep purple-black (original Cool Lightning)
  midnight = vim.tbl_extend("force", syntax, {
    bg         = "#000000",
    bg_dark    = "#000000",
    bg_float   = "#0e0e22",
    bg_sel     = "#2d3566",
    bg_subtle  = "#0f0f1e",
    bg_subtle2 = "#141428",
    border     = "#2a2a4a",
  }),

  -- dusk: warm dark purple
  dusk = vim.tbl_extend("force", syntax, {
    bg         = "#16101e",
    bg_dark    = "#100a18",
    bg_float   = "#1e1830",
    bg_sel     = "#2d2550",
    bg_subtle  = "#1e1830",
    bg_subtle2 = "#261e3a",
    border     = "#332a4a",
  }),

  -- twilight: soft blue-dark
  twilight = vim.tbl_extend("force", syntax, {
    bg         = "#1a1b26",
    bg_dark    = "#16161e",
    bg_float   = "#1e2030",
    bg_sel     = "#2d3566",
    bg_subtle  = "#1e2035",
    bg_subtle2 = "#222436",
    border     = "#2a2a4a",
  }),

  -- ember: deeper blue-dark, slightly lighter than twilight
  ember = vim.tbl_extend("force", syntax, {
    bg         = "#222436",
    bg_dark    = "#1e2030",
    bg_float   = "#2a2b3d",
    bg_sel     = "#3b4166",
    bg_subtle  = "#272843",
    bg_subtle2 = "#2e2f50",
    border     = "#383a5c",
  }),

  -- ── Light variant ─────────────────────────────────────────────────────────

  -- dawn: warm white, light background
  -- Syntax colors are adjusted for contrast on light bg
  dawn = {
    -- Backgrounds
    bg         = "#f5f5f0",
    bg_dark    = "#ebebе6",
    bg_float   = "#eeeee8",
    bg_sel     = "#d0d8f0",
    bg_subtle  = "#e8e8e2",
    bg_subtle2 = "#e0e0da",
    border     = "#c8c8d0",
    border_hl  = "#0a8faa",

    -- Foregrounds
    fg         = "#2a2a35",   -- dark blue-black for readability
    fg_dim     = "#5a5a75",
    fg_muted   = "#8888a0",
    gypsum     = "#3a3a4a",   -- darker on light bg

    -- Syntax — saturated/darkened for light bg contrast
    keyword    = "#6050d0",   -- darker violet
    red        = "#d0004a",   -- deeper red
    orange     = "#b06000",   -- darker orange
    modifier   = "#8a6800",   -- darker gold
    string     = "#3a8a20",   -- darker green
    green      = "#2a8a30",   -- darker function green
    green_dim  = "#3a7a20",
    blue       = "#0088aa",   -- darker cyan-blue
    blue_dim   = "#006888",
    cyan       = "#0070a0",
    param      = "#8040b0",   -- darker purple-pink
    purple     = "#7040c0",   -- darker purple
    purple_dim = "#604090",
    teal       = "#207860",   -- darker teal
    teal_type  = "#308878",   -- darker mint
    type_stdlib = "#c04060",  -- darker coral
    comment    = "#6080a0",   -- muted blue-gray

    -- Diagnostics
    error      = "#d0004a",
    warn       = "#b06000",
    info       = "#0088aa",
    hint       = "#7040c0",
  },
}

function M.get(style)
  return variants[style] or variants.midnight
end

return M
