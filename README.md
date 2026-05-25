# cool_lightning.nvim

A dark Neovim colorscheme inspired by Monokai Soda and Tokyo Night Night, tuned for embedded C / firmware development.

## Styles

| Style | Background | Feel |
|---|---|---|
| `midnight` | `#000000` | Pure black (default) |
| `dusk` | `#16101e` | Warm dark purple |
| `twilight` | `#1a1b26` | Cool blue-dark |
| `ember` | `#222436` | Softer blue-dark, lighter |
| `dawn` | `#f5f5f0` | Warm white, light background |

Cycle through variants in Neovim:
```vim
:colo cool_lightning<Tab>
```

## Philosophy

Colors are assigned by **semantic category**, not just syntax role:

| Category | Color (dark) | Examples |
|---|---|---|
| Named constants | `#0db9d7` cyan-blue | `#define` macros, enum members |
| Storage modifiers | `#f5d070` warm gold | `static`, `const`, `volatile`, `extern` |
| Variables / primitives | `#e8e4dc` gypsum | local vars, globals, `void`/`int`/`char` |
| Stdlib typedefs | `#ff8fa3` coral-pink | `uint32_t`, `int32_t` |
| Typedef handles | `#9ddec9` soft mint | `Button_TypeDef`, `osThreadId_t` |
| Struct types | `#4db8a0` teal | `GPIO_InitTypeDef`, `RCC_OscInitTypeDef` |
| Functions | `#8adc58` green | function names, calls |
| Keywords | `#8b6fe8` violet | `if`, `else`, `for`, `return`, `while` |
| Parameters | `#c792ea` soft purple | function arguments |
| Strings | `#6dd4f0` light cyan | string literals |
| Comments | `#a8a8d0` blue-purple gray | `//` and `/* */` |
| Errors | `#ff3a7e` hot pink | diagnostics, diff delete |

**Warm tones** (gold, coral, gypsum) = type annotations and storage — the *grammar* of your code.
**Cool tones** (blue, teal, mint, cyan) = named values and types — the *vocabulary* of your code.

## Features

- 5 style variants (4 dark + 1 light)
- Full treesitter highlight support
- LSP semantic token support
- Smart C/C++ macro splitting via `LspTokenUpdate` — distinguishes function-like, struct-access, and value macros
- Terminal colors
- Plugin support: Telescope, nvim-cmp, gitsigns, which-key, nvim-tree, indent-blankline, nvim-notify

## Requirements

- Neovim >= 0.9
- `termguicolors` enabled

## Installation

### lazy.nvim

```lua
{
  "cdmeister/cool_lightning",
  lazy = false,
  priority = 1000,
  config = function()
    require("cool_lightning").setup({
      style = "midnight",  -- "midnight" | "dusk" | "twilight" | "ember" | "dawn"
    })
    vim.cmd.colorscheme("cool_lightning")
  end,
}
```

Or use a specific variant directly:

```lua
{
  "cdmeister/cool_lightning",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("cool_lightning_midnight")
  end,
}
```

### Manual

Copy the `colors/` and `lua/` directories into `~/.config/nvim/`, then:

```lua
require("cool_lightning").setup({ style = "midnight" })
vim.cmd.colorscheme("cool_lightning")
```

## C/C++ Macro Highlighting

Cool Lightning uses `LspTokenUpdate` to split macros into three semantic categories based on treesitter context:

- **MacroFunction** — function-like macros (`NVIC_SetPriority`) → green
- **MacroStruct** — struct/register macros (`SysTick->CTRL`) → plain fg
- **MacroObject** — value/constant macros (`GPIO_MODE_INPUT`) → blue

Requires clangd with a valid `compile_commands.json` or `compile_flags.txt` at your project root. For embedded ARM projects add `--query-driver` so clangd can resolve ARM toolchain headers:

```lua
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--query-driver=/path/to/arm-none-eabi-gcc",
  },
})
```

## Palette

```lua
-- Syntax (shared across all dark variants)
keyword    = "#8b6fe8"   -- violet keywords
red        = "#ff3a7e"   -- errors
orange     = "#ffaf5f"   -- type builtins warnings
modifier   = "#f5d070"   -- static/const/volatile/extern
string     = "#6dd4f0"   -- strings
green      = "#8adc58"   -- functions
green_dim  = "#6ec048"   -- methods
blue       = "#0db9d7"   -- macros, constants, operators
param      = "#c792ea"   -- parameters
purple     = "#b282fe"   -- numbers
teal       = "#4db8a0"   -- struct types
teal_type  = "#9ddec9"   -- typedef handles
type_stdlib = "#ff8fa3"  -- stdlib typedefs (uint32_t)
gypsum     = "#e8e4dc"   -- variables and primitives
comment    = "#a8a8d0"   -- comments
```

## Customization

Edit `lua/cool_lightning/palette.lua` to tweak colors. Swap comments are left in `highlights.lua` for common tweaks:

- `@type.builtin` — swap gypsum for coral-pink to unify all type annotations
- `@lsp.type.enumMember` — swap blue for purple to distinguish enum members from macros
- `@lsp.type.type` — swap `teal_type` for `teal` to unify struct-backed types
- `@lsp.typemod.type.defaultLibrary` — swap coral-pink for `teal_type` for stdlib typedefs

## License

MIT
