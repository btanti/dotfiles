" Vim-plug initialization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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
call plug#begin()
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_quickfix_mode=0
    let g:vimtex_syntax_enabled = 1
    let g:vimtex_syntax_conceal_disable = 1
"Plug 'KeitaNakamura/tex-conceal.vim'
    "set conceallevel=1
    "let g:tex_conceal='abdmg'
    "hi Conceal ctermbg=none
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()

filetype plugin on

" Leader key
let mapleader=" "

" better buffer cycling
nnoremap <s-h> :bprevious<CR>
nnoremap <s-l> :bnext<CR>

" Time before keypress times out
set timeout timeoutlen=300

" case-insensitive search
set ignorecase

" Line numbers on
set number

" for nvim-compe
set completeopt=menu,menuone,noselect

" Spellchecker settings
setlocal spell
set spelllang=en_us

" shifting lines
set shiftround
set shiftwidth=4

" vim-test bindings
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#python#runner = 'pytest'

" trouble bindings
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" fugitive bindings
nnoremap <Leader>ga :Git add -v -- .<CR>
nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>gc :Git commit -v -q<CR>
nnoremap <Leader>gps :Git push -v<CR>
nnoremap <Leader>gpl :Git pull<CR>
nnoremap <Leader>gt :Git commit -v -q %:p<CR>
nnoremap <Leader>gd :Git diff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>

nnoremap zc :PackerCompile<cr>
nnoremap zi :PackerInstall<cr>
nnoremap zs :PackerSync<cr>
nnoremap zS :PackerStatus<cr>
nnoremap zu :PackerUpdate<cr>
" clear search highlighting
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" vim switching windows
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>h <c-w>h
map <Leader>l <c-w>l

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" vim buffer management
nnoremap <leader>b :buffers<cr>:b<space> 

" inkscape-figure-manager bindings
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Toggleterm settings
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" remap exiting terminal mode to normal (useful for ToggleTerm)
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" jupyter notebook autocmd
"au BufReadPost,BufNewFile \(*\).sync.py exe v:count1 . 'ToggleTerm" | dir=getcwd() | TermExec cmd ="jupyter notebook example.sync.ipynb"
au BufReadPost,BufNewFile \(*\).sync.py let file=expand("%") | exe v:count1 . 'ToggleTerm' | let dir_str=getcwd() | exe 'TermExec cmd="conda activate rl-camd"' | exe 'TermExec cmd="jupyter notebook '.substitute(file, '\(.\).sync.py', '\1.sync.ipynb', '').'"'

lua require('plugins')
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \    '-shell-escape',
    \    '-verbose',
    \    '-file-line-error',
    \    '-synctex=1',
    \    '-interaction=nonstopmode',
    \ ],
    \}
" Set below if you would like to use a different pdf viewer
"let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
set hidden
    if has('win32') || (has('unix') && exists('$WSLENV'))
     if executable('mupdf.exe')
       let g:vimtex_view_general_viewer = 'mupdf.exe'
     elseif executable('SumatraPDF.exe')
       let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
     endif
   endif
let g:doge_doc_standard_python = 'google'

" UltiSnips snippet directories
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']          " using Vim
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']  " using Neovim

" vim-gutentags settings
let g:gutentags_project_root = ['Makefile']
set statusline+=%{gutentags#statusline()}
lua <<EOF

vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = 'always',
    border = 'rounded',
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap(
  'n', '<Leader>e', ':lua vim.diagnostic.open_float()<CR>', 
  { noremap = true, silent = true }
)
-- Go to next diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', '<Leader>n', ':lua vim.diagnostic.goto_next()<CR>',
  { noremap = true, silent = true }
)
-- Go to prev diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', '<Leader>p', ':lua vim.diagnostic.goto_prev()<CR>',
  { noremap = true, silent = true }
)

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require 'nvim-treesitter.configs'.setup {
	ignore_install = { "latex" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
		}
-- more stuff here
}
EOF
