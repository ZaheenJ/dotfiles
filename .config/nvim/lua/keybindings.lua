-- Setting keybinding
local map = vim.api.nvim_set_keymap
local bmap = vim.api.nvim_buf_set_keymap
local opts = { noremap=true, silent=true }
map('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = ' '
vim.g.maplocalleader = " "
map('n', '<C-n>', '<cmd> NvimTreeToggle<CR>', opts)
map('n', '<leader>r', '<cmd> NvimTreeRefresh<CR>', opts)
map('n', '<leader>n', '<cmd> NvimTreeFindFile<CR>', opts)

-- Completion keybinds
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
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-------------------------------------------------------- TESTING ---------------------------------------------------------------
-- bmap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
bmap(bufnr, 'n', 'gD', '<cmd>lua require\'lspsaga.provider\'.preview_definition()<CR>', opts)
bmap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- bmap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
bmap(bufnr, 'n', 'K', '<cmd>lua require(\'lspsaga.hover\').render_hover_doc()<CR>', opts)
bmap(bufnr, 'n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', opts)
bmap(bufnr, 'n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', opts)
bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- bmap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
bmap(bufnr, 'n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>', opts)
bmap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
bmap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
bmap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
bmap(bufnr, 'n', 'gr', '<cmd>lua require(\'lspsaga.rename\').rename()<CR>', opts)
-- bmap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
bmap(bufnr, 'n', '<leader>ca', '<cmd>lua require(\'lspsaga.codeaction\').code_action()<CR>', opts)
bmap(bufnr, 'n', '<leader>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<CR>', opts) -- *****************
-- bmap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
bmap(bufnr, 'n', '<leader>cd', '<cmd>lua require\'lspsaga.diagnostic\'.show_line_diagnostics()<CR>', opts)
bmap(bufnr, 'n', '<leader>cc', '<cmd>lua require\'lspsaga.diagnostic\'.show_cursor_diagnostics()<CR>', opts)
bmap(bufnr, 'n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<CR>', opts)
bmap(bufnr, 'n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<CR>', opts)
-- bmap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- bmap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
bmap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
bmap(bufnr, 'n', 'gh', '<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>', opts)


local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end


map('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
