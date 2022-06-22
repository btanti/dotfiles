" Vim-plug initialization
call plug#begin()
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_quickfix_mode=0
"Plug 'KeitaNakamura/tex-conceal.vim'
    "set conceallevel=1
    "let g:tex_conceal='abdmg'
    "hi Conceal ctermbg=none
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()

" Key bindings can be changed, see below

" Leader key
let mapleader=" "

" case-insensitive search
set ignorecase
"" telescope bindings
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
"nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
"nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
"nnoremap <leader>ft <cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>

" vim-test bindings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
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
nnoremap <Leader>gp :Git push -v<CR>
nnoremap <Leader>gt :Git commit -v -q %:p<CR>
nnoremap <Leader>gd :Git diff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
nnoremap <Leader>gps :Dispatch! git push<CR>
nnoremap <Leader>gpl :Dispatch! git pull<CR>
" vim switching windows
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>h <c-w>h
map <Leader>l <c-w>l


" inkscape-figure-manager bindings
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Line numbers on
set number

" Visual candy

" remap exiting terminal mode to normal
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

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
imap jk <Esc>
"let g:vimtex_view_general_viewer = 'zathura'
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


" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
filetype plugin on

" UltiSnips snippet directories
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']          " using Vim
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']  " using Neovim

" Spellchecker settings
setlocal spell
set spelllang=en_us

" ???
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" ???
set completeopt=menu,menuone,noselect

" Toggleterm settings
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>


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

EOF
