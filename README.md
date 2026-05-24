# cool_lightning.nvim

A dark Neovim colorscheme inspired by Monokai Soda and Tokyo Night Night, tuned for embedded C / firmware development.

## Philosophy

Colors are assigned by **semantic category**, not just syntax role:

| Category | Color | Examples |
|---|---|---|
| Named constants | `#0db9d7` cyan-blue | `#define` macros, enum members |
| Storage modifiers | `#f5d070` warm gold | `static`, `const`, `volatile`, `extern` |
| Variables / primitives | `#e8e4dc` gypsum | local vars, globals, `void`/`int`/`char` |
| Stdlib typedefs | `#ff8fa3` coral-pink | `uint32_t`, `int32_t` |
| Typedef handles | `#9ddec9` soft mint | `Button_TypeDef`, `osThreadId_t` |
| Struct types | `#4db8a0` teal | `GPIO_InitTypeDef`, `RCC_OscInitTypeDef` |
| Functions | `#a8d96a` green | function names, calls |
| Keywords | `#8b6fe8` violet | `if`, `else`, `for`, `return`, `while` |
| Parameters | `#c792ea` soft purple | function arguments |
| Strings | `#9ece6a` TN green | string literals |
| Comments | `#9dbdd4` cool blue-gray | `//` and `/* */` |
| Errors | `#ff3a7e` hot pink | diagnostics, diff delete |

**Warm tones** (gold, coral, gypsum) = type annotations and storage — the *grammar* of your code.
**Cool tones** (blue, teal, mint) = named values and types — the *vocabulary* of your code.

## Features

- Full treesitter highlight support
- LSP semantic token support
- Smart C/C++ macro splitting via `LspTokenUpdate` — function-like, struct-access, and value macros get distinct colors
- Terminal colors
- Plugin support: Telescope, nvim-cmp, gitsigns, which-key, nvim-tree, indent-blankline, nvim-notify

## Requirements

- Neovim >= 0.9
- `termguicolors` enabled

## Installation

### lazy.nvim (local)

```lua
{
  dir = "~/cool_lightning.nvim",
  name = "cool_lightning",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("cool_lightning")
  end,
}
```

### lazy.nvim (GitHub)

```lua
{
  "yourusername/cool_lightning.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("cool_lightning")
  end,
}
```

### Manual

Copy the `colors/` and `lua/` directories into your Neovim config directory (`~/.config/nvim/`), then add to your `init.lua`:

```lua
vim.cmd.colorscheme("cool_lightning")
```

## C/C++ Macro Highlighting

Cool Lightning uses `LspTokenUpdate` to split macros into three semantic categories based on treesitter context. This requires clangd with a valid `compile_commands.json` or `compile_flags.txt` at your project root.

For embedded ARM projects, add `--query-driver` to your clangd configuration to resolve ARM toolchain headers:

```lua
-- In your lspconfig setup
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--query-driver=/path/to/arm-none-eabi-gcc",
    -- ... other flags
  },
})
```

## Palette

```lua
bg         = "#0d000d"   -- deep purple-black
fg         = "#c4c4b5"   -- warm off-white
gypsum     = "#e8e4dc"   -- variables and primitives
keyword    = "#8b6fe8"   -- violet
red        = "#ff3a7e"   -- errors
orange     = "#ffaf5f"   -- type builtins
modifier   = "#f5d070"   -- storage modifiers
string     = "#9ece6a"   -- strings
green      = "#a8d96a"   -- functions
blue       = "#0db9d7"   -- macros, constants
param      = "#c792ea"   -- parameters
purple     = "#b282fe"   -- numbers
teal       = "#4db8a0"   -- struct types
teal_type  = "#9ddec9"   -- typedef handles
type_stdlib = "#ff8fa3"  -- stdlib typedefs
comment    = "#9dbdd4"   -- comments
```

## Customization

Colors are defined in `lua/cool_lightning/palette.lua`. Edit the `M.colors` table and run `:colorscheme cool_lightning` to reload.

Swap comments are left throughout `highlights.lua` for common tweaks:

- `@type.builtin` — swap gypsum for coral-pink to unify all type annotations
- `@lsp.type.enumMember` — swap blue for purple to distinguish enum members from macros
- `@lsp.type.type` — swap `teal_type` for `teal` to unify all struct-backed types
- `@lsp.typemod.type.defaultLibrary` — swap coral-pink for `teal_type` for stdlib typedefs

## License

MIT
