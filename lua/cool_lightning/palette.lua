-- lua/cool_lightning/palette.lua
-- Cool Lightning — color palette
-- Inspired by Monokai Soda x Tokyo Night Night

-- ─── Semantic color guide ────────────────────────────────────────────────────
-- bg              #0d000d   editor background (deep purple-black)
-- fg              #c4c4b5   normal text (warm)
-- gypsum          #e8e4dc   variables, primitives (void/int/char)
-- keyword         #8b6fe8   keywords/control flow (violet)
-- red             #ff3a7e   errors, diagnostics
-- orange          #ffaf5f   type builtins warnings
-- modifier        #f5d070   static/const/volatile/extern (warm gold)
-- string          #9ece6a   strings (TN night green)
-- green           #a8d96a   functions
-- green_dim       #80c060   methods
-- blue            #0db9d7   macros, enum members, named constants, operators
-- param           #c792ea   function parameters
-- purple          #b282fe   numbers, pure constants
-- teal            #4db8a0   struct/class types (RCC_OscInitTypeDef)
-- teal_type       #9ddec9   typedef handles (Button_TypeDef, osThreadId_t)
-- type_stdlib     #ff8fa3   stdlib typedefs (uint32_t, int32_t) coral-pink
-- comment         #9dbdd4   comments
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

M.colors = {
  -- Backgrounds
  bg         = "#0d000d",
  bg_dark    = "#080008",
  bg_float   = "#111128",
  bg_sel     = "#2d3566",
  bg_subtle  = "#16162a",
  bg_subtle2 = "#1e1e36",

  -- Foregrounds
  fg         = "#c4c4b5",
  fg_dim     = "#8890b0",
  fg_muted   = "#565f89",
  gypsum     = "#e8e4dc",   -- variables and primitives

  -- Syntax
  keyword    = "#8b6fe8",   -- violet: if/else/for/return/while
  red        = "#ff3a7e",   -- errors only
  orange     = "#ffaf5f",   -- type builtins, warnings
  modifier   = "#f5d070",   -- static/const/volatile/extern (warm gold)
  string     = "#9ece6a",   -- TN green: strings
  green      = "#a8d96a",   -- functions
  green_dim  = "#80c060",   -- methods
  blue       = "#0db9d7",   -- macros, enum members, named constants, operators
  blue_dim   = "#0a9ab5",
  cyan       = "#7dcfff",
  param      = "#c792ea",   -- function parameters
  purple     = "#b282fe",   -- numbers, pure constants
  purple_dim = "#9d7cd8",
  teal       = "#4db8a0",   -- struct/class types (RCC_OscInitTypeDef)
  teal_type  = "#9ddec9",   -- typedef handles (Button_TypeDef, osThreadId_t)
  type_stdlib = "#ff8fa3",  -- stdlib typedefs (uint32_t, int32_t) coral-pink
  comment    = "#9dbdd4",

  -- UI
  border     = "#2a2a4a",
  border_hl  = "#27a1b9",

  -- Diagnostics
  error      = "#ff3a7e",
  warn       = "#ffaf5f",
  info       = "#0db9d7",
  hint       = "#b282fe",
}

return M
