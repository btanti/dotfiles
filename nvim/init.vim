call plug#begin()
"Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
call plug#end()

filetype plugin on

" Leader key
let mapleader=" "

" Time before keypress times out
set timeout timeoutlen=300
" history of ex commands increased
set history=200
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

let test#python#runner = 'pytest'
nnoremap <s-h> :bprevious<CR>
nnoremap <s-l> :bnext<CR>
nnoremap <c-h> :previous<CR>
nnoremap <c-l> :next<CR>

" clear search highlighting
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" expand to cwd
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>


" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" vim buffer management
nnoremap <leader>b :buffers<cr>:b<space> 

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

" more lsp stuf
let g:lsp_settings = {
    \  "sumneko-lua-language-server": {
    \       "workspace_config": {
    \           "Lua": {
    \               "diagnostics": {
    \                   "globals": ["hs", "vim", "it", "describe", "before_each", "after_each"],
    \                   "disable": ["lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space"]
    \               }
    \           }
    \       }
    \   }
    \}

" jupyter notebook autocmd
"au BufReadPost,BufNewFile \(*\).sync.py exe v:count1 . 'ToggleTerm" | dir=getcwd() | TermExec cmd ="jupyter notebook example.sync.ipynb"
au BufReadPost,BufNewFile \(*\).sync.py let file=expand("%") | exe v:count1 . 'ToggleTerm' | let dir_str=getcwd() | exe 'TermExec cmd="conda activate rl-camd"' | exe 'TermExec cmd="jupyter notebook '.substitute(file, '\(.\).sync.py', '\1.sync.ipynb', '').'"'

lua require('plugins')
runtime macros/sandwich/keymap/surround.vim
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

" vim-doge settings"
let g:doge_doc_standard_python = 'google'

" UltiSnips snippet directories
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']          " using Vim
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']  " using Neovim

" vim-gutentags settings
let g:gutentags_project_root = ['Makefile']
set statusline+=%{gutentags#statusline()}

" startify settings
let g:startify_bookmarks = [ {'h': '~/Documents/notes/optimization/convex/hw/'}, {'r': '~/research/'}, {'i': "~/.config/inkscape/extensions/"}]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]

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
