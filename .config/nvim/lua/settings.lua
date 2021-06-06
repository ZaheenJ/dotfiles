-- Used for settings
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd
local g = vim.g

-- Set cursor to always be a vertical line(|) in all modes except replace mode, where it is a underscore (_)
o.guicursor = "n-i-v-c-sm:ver25,r-cr-o:hor20"

-- Set clipboard to system clipboard
o.clipboard = "unnamedplus"

-- Set UTF8 file encoding
o.encoding = "UTF-8"

-- Enable number column with numbers relative to current line
o.number = true
o.relativenumber = true

-- Enable mouse support
o.mouse = "a"

-- Disable bottom line showing current mode (which will be shown in statusbar)
o.showmode = false

-- Disable line wrapping
o.wrap = false

-- Set 24-bit color
o.termguicolors = true

-- Set auto indentation settings to clike
o.cindent = true

-- Turn backup off so we can lower update time for faster completions
o.backup = false
o.writebackup = false
o.updatetime = 200

-- Setup code folding
o.foldmethod = "indent"
-- o.foldexpr = "nvim_treesitter#foldexpr()"

-- Spell checking
o.spelllang = "en,es"

-- Window title will be file currently edited
o.title = true

-- Set all .h files to be read as c files instead of c++
-- autocmd BufRead,BufNewFile *.h,*.c set filetype=c
-- cmd('autocmd! BufRead,BufNewFile * if &ft == "h" | set ft=c | endif')

-- Visualize indentation
g.indent_blankline_char = "│"

-- Needed for nvim-compe
o.completeopt = "menuone,noselect"

-- Smarter searching
o.ignorecase = true
o.smartcase = true

-- Signs will appear in number column
o.signcolumn="number"

-- Set fonts for GUI vim
o.guifont="Iosevka\\ Custom:h16,Symbols\\ Nerd\\ Font:h16"

-- Set transparency for neovide
g.neovide_transparency=0.6

-- Settings for symbol outline
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}
