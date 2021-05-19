" Plugin Management
function! PackInit() abort
	" Initializing Packaget Manager (minpac)
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	
	" Powerline status bar
	call minpac#add('itchyny/lightline.vim')

	" Make commenting better
	call minpac#add('preservim/nerdcommenter')

	" Make pairs better
	call minpac#add('Raimondi/delimitMate')
	call minpac#add('machakann/vim-sandwich')
	call minpac#add('luochen1990/rainbow')

	" Theme
	call minpac#add('joshdick/onedark.vim')

	" Better syntax highlighting
	call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
	call minpac#add('gentoo/gentoo-syntax')
	call minpac#add('glepnir/lspsaga.nvim')

	" IDE Features - LSP-based completion, diagnostics(showing errors), etc.
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('hrsh7th/nvim-compe')
	call minpac#add('rafamadriz/friendly-snippets')
	call minpac#add('hrsh7th/vim-vsnip')
	call minpac#add('hrsh7th/vim-vsnip-integ')
	call minpac#add('norcalli/nvim-colorizer.lua')
endfunction
" Only load package manager when needed
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" Nerd commenter settings
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
" Turn on rainbow matching
let g:rainbow_active = 1
" Makes theme appear properly
set termguicolors
" Theming
let g:onedark_color_overrides = {
			\ "black": {"gui": "#000000", "cterm": "235", "cterm16": "0" },
\}
" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
colorscheme onedark
let g:lightline = {
  \ 'colorscheme': 'onedark',
\}
let g:lightline.separator = {'left': '', 'right': '' }
let g:lightline.subseparator = {'left': '', 'right': ''}
" Set default values for vim-sandwich
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
" Set up LSP
lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require'lspconfig'
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
  	capabilities = capabilities,
  }
)
lspconfig.clangd.setup{}
lspconfig.jedi_language_server.setup{}
lspconfig.rust_analyzer.setup{}
EOF


let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'always'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:false
let g:compe.source.treesitter = v:true
let g:compe.source.omni = v:false
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga {
	error_sign = '',
	warn_sign = ''
}
EOF
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>
" nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent><leader>cd <cmd>lua
nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>sa :Lspsaga code_action<CR>
vnoremap <silent><leader>sa :<C-U>Lspsaga range_code_action<CR>

lua << EOF
require'colorizer'.setup(
	{'*';},
	{
		RGB      = true;         -- #RGB hex codes
		RRGGBB   = true;         -- #RRGGBB hex codes
		names    = true;         -- "Name" codes like Blue
		RRGGBBAA = true;         -- #RRGGBBAA hex codes
		rgb_fn   = true;         -- CSS rgb() and rgba() functions
		hsl_fn   = true;         -- CSS hsl() and hsla() functions
		css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
		mode     = 'background'; -- Set the display mode.
	}
)
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  indent = {
    enable = true
  }
}
EOF

" Misc. vim settings
let mapleader = " "
set relativenumber
set number
set signcolumn=yes
set clipboard=unnamedplus
set guicursor=n-i-v-c-sm:ver25,r-cr-o:hor20
set completeopt=menuone,noselect
autocmd BufRead,BufNewFile *.h,*.c set filetype=c
set mouse=a
set noshowmode
set guifont=Iosevka\ Custom:h16,Symbols\ Nerd\ Font:h16
let neovide_transparency = 0.8
highlight Normal ctermbg=none
let delimitMate_expand_cr = 1
let delimitMateAutoClose = 1
let delimitMateExpansion = 1
let delimitMateSmartQuotes = 1
let delimitMateSyntax = 1
inoremap {<CR> {<CR>} <C-o>O
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=indent
set backspace=2
