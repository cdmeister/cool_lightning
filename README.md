# cool_lightning.nvim

A dark Neovim colorscheme inspired by Monokai Soda and Tokyo Night Night, tuned for embedded C / firmware development.

## Styles

| Style | Background | Feel |
|---|---|---|
| `midnight` | `#0d000d` | Deep purple-black (default) |
| `dusk` | `#16101e` | Warm dark purple |
| `twilight` | `#1a1b26` | Cool blue-dark |
| `ember` | `#222436` | Softer blue-dark, lighter |
| `dawn` | `#f5f5f0` | Warm white, light background |

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
| Functions | `#a8d96a` green | function names, calls |
| Keywords | `#8b6fe8` violet | `if`, `else`, `for`, `return`, `while` |
| Parameters | `#c792ea` soft purple | function arguments |
| Strings | `#9ece6a` TN green | string literals |
| Comments | `#9dbdd4` cool blue-gray | `//` and `/* */` |
| Errors | `#ff3a7e` hot pink | diagnostics, diff delete |

**Warm tones** (gold, coral, gypsum) = type annotations and storage — the *grammar* of your code.
**Cool tones** (blue, teal, mint) = named values and types — the *vocabulary* of your code.

## Features

- 5 style variants (4 dark + 1 light)
- Full treesitter highlight support
- LSP semantic token support
- Smart C/C++ macro splitting via `LspTokenUpdate`
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

### Manual

Copy the `colors/` and `lua/` directories into `~/.config/nvim/`, then:

```lua
require("cool_lightning").setup({ style = "midnight" })
vim.cmd.colorscheme("cool_lightning")
```

## C/C++ Macro Highlighting

Cool Lightning uses `LspTokenUpdate` to split macros into three semantic categories:

- **MacroFunction** — function-like macros (`NVIC_SetPriority`) → green
- **MacroStruct** — struct/register macros (`SysTick->CTRL`) → plain fg
- **MacroObject** — value/constant macros (`GPIO_MODE_INPUT`) → blue

Requires clangd with a valid `compile_commands.json`. For embedded ARM projects add `--query-driver`:

```lua
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--query-driver=/path/to/arm-none-eabi-gcc",
  },
})
```

## Customization

Edit `lua/cool_lightning/palette.lua` to tweak colors. Swap comments are left in `highlights.lua`:

- `@type.builtin` — swap gypsum for coral-pink to unify all type annotations
- `@lsp.type.enumMember` — swap blue for purple to distinguish enum members from macros
- `@lsp.type.type` — swap `teal_type` for `teal` to unify struct-backed types
- `@lsp.typemod.type.defaultLibrary` — swap coral-pink for `teal_type` for stdlib typedefs

## License

MIT
