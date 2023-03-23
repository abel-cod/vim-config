filetype plugin indent on
syntax on
set encoding=utf-8
set nocompatible
set number relativenumber
set tabstop=4 shiftwidth=4
set nohlsearch incsearch
set autoread
set undofile
set hidden
set wrap
set smartcase
set termguicolors
set smartindent
set nobackup
set nowritebackup
set colorcolumn=80
set updatetime=300
set clipboard=unnamedplus,unnamed
" Turning of the terminal sound
set vb
set visualbell
set laststatus=2


" Building my own status bar 
set statusline = 
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ REPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
"set statusline+=\%n
set statusline+=%#Visual#  "Color
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#
set statusline+=%R
"set statusline+=%M
set statusline+=%#Cursor#
set statusline+=%#CursorLine#
set statusline+=\ %t
set statusline+=%=
set statusline+=%#CursorLine#
set statusline+=\ %y:                   "File Type
set statusline+=\[%{&fileformat}\]      "Operating System
set statusline+=%#CursorIM#
set statusline+=\%3l:%-2c:              "Line + Column
set statusline+=%#Cursor#
set statusline+=\%3p%%\ 			    " Percentage
"set statusline+=\ %f

" Here is The end of the status bar setting

" To copy from vim to clipboard press Control+y
vmap <C-y> "+y



call plug#begin()

Plug 'sheerun/vim-polyglot',

" ColorScheme
Plug 'morhetz/gruvbox',

" Auto close any character
Plug 'jiangmiao/auto-pairs',

" Concquer of Completion
" AutoCompeltion and other stuff 
Plug 'neoclide/coc.nvim', {'branch': 'release'},

" Language specific plugin
Plug 'mattn/emmet-vim',
Plug 'lepture/vim-jinja',
Plug 'rust-lang/rust.vim',
Plug 'hdima/python-syntax',
Plug 'vimjas/vim-python-pep8-indent'
" Connecting Git with vim
Plug 'airblade/vim-gitgutter',

" Fuzzy finding over the file
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } },
Plug 'junegunn/fzf.vim',

" Commenting line or block
Plug 'tpope/vim-commentary',

" tmux and vim navigation
Plug 'christoomey/vim-tmux-navigator',


" This plugin allows you run the external commands asynchronously, without
" exiting from vim.
Plug 'tpope/vim-dispatch'
Plug 'aliev/vim-python'



call plug#end()



let mapleader =" "

"ColorScheme
set background=dark
colorscheme gruvbox 



let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0



"fzf specific setting
nnoremap <C-p> :Files<Cr>
" C-c will exit from the fzf
" you can use C-t to open  file in new Tab
" you can also use C-b to open file in virticalsplit
" you can also use C-x to open file in Horizontalsplit
" you can use the command Buffer to open the file that was open by the fzf.
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_layout = { 'down': '40%' }


" Starting from this
let g:rustfmt_autosave = 1
nnoremap gp :slient %!prettier --stdin-filepath %<CR>
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR


