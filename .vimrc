
syntax on
filetype plugin indent on

set encoding=utf-8
set nocompatible
set number relativenumber
set tabstop=4 shiftwidth=4
set nohlsearch incsearch
set autoread
set undofile
set wrap
set hidden
set smartcase
set termguicolors
set smartindent
set nobackup
set nowritebackup
set colorcolumn=80
set updatetime=300
set guioptions-=T
set foldmethod=marker
set ruler
set ttyfast
set lazyredraw
set synmaxcol=500
set laststatus=2
set showcmd
set mouse=a
set shortmess+=c
set clipboard=unnamedplus,unnamed



let mapleader =" "

call plug#begin()

Plug 'dstein64/vim-startuptime',

" ColorScheme
Plug 'morhetz/gruvbox',
Plug 'chriskempson/base16-vim',

"""""   """""
Plug 'jszakmeister/vim-togglecursor',
Plug 'jmcantrell/vim-virtualenv',
Plug 'ryanoasis/vim-devicons',
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'nlknguyen/copy-cut-paste.vim'


" Additional plug 
Plug 'yggdroot/indentline',
Plug 'tpope/vim-surround',
Plug 'prettier/vim-prettier', {'do': 'npm install --frozen-lockfile --production'}

Plug 'tpope/vim-commentary',
Plug 'christoomey/vim-tmux-navigator',
Plug 'itchyny/lightline.vim',
Plug 'jiangmiao/auto-pairs',

Plug 'yaegassy/coc-htmldjango', {'do': 'npm install --frozen-lockfile'}

" Syntax checking 
Plug 'dense-analysis/ale',
Plug 'sheerun/vim-polyglot',

" Plug 'pappasam/coc-jedi', {'do': 'npm install --frozen-lockfile && npm run build', 'branch': 'main'}

" Language specific plugin
Plug 'mattn/emmet-vim',
Plug 'othree/html5.vim',
Plug 'lepture/vim-jinja',
Plug 'rust-lang/rust.vim',
Plug 'hdima/python-syntax',
Plug 'tell-k/vim-autopep8',
Plug 'tomlion/vim-solidity',
Plug 'leafgarland/typescript-vim',
Plug 'pangloss/vim-javascript',
Plug 'aliev/vim-python'
Plug 'suan/vim-instant-markdown',
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}


" Connecting Git with vim
Plug 'airblade/vim-gitgutter',
Plug 'tpope/vim-fugitive',

" File Tree
Plug 'preservim/nerdtree',
Plug 'mcchrish/nnn.vim',


"Concur of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'roxma/nvim-yarp', {'do': 'pip install -r requirements.txt'}
Plug 'roxma/vim-hug-neovim-rpc',



"Fuzzie finding 
Plug 'junegunn/fzf', {'do': { ->fzf#install() }}
Plug 'junegunn/fzf.vim',

call plug#end()

"ColorScheme
set background=dark
" source ~/vim-config/base16-vim/colors/base16-gruvbox-dark-hard.vim
" colorscheme base16-atelier-dune
colorscheme base16-gruvbox-dark-hard
hi Normal ctermbg=None

" let g:gruvbox_contrast_light='medium'
" let g:gruvbox_contrast_dark='medium'
" let g:gruvbox_termcolors=16
" set guicursor+=i:block-cursor

let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0


" let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let g:bargreybars_auto = 0

"""""""  Nerd Tree config   """""""
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>


"fzf specific setting
nnoremap <C-p> :Files<Cr>
" C-c will exit from the fzf
" you can use C-t to open  file in new Tab
" you can also use C-b to open file in virticalsplit
" you can also use C-x to open file in Horizontalsplit
" you can use the command Buffer to open the file that was open by the fzf.
" Starting from this


" let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']
let g:fzf_preview_window = ['right,70%', 'ctrl-/']

let g:fzf_buffers_jump = 1

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let g:fzf_tags_command = 'ctags -R'

let g:fzf_commands_expect = 'alt-enter, ctrl-x'

let g:rustfmt_autosave = 1

nnoremap gp :slient %!prettier --stdin-filepath %<CR>

""" CCp custome keymaps """
let g:copy_cut_past_no_mapping = 1

nmap uy <Plug>CCP_CopyLine
vmap uy <Plug>CCP_CopyText
nmap uo <Plug>CCP_CutLine
vmap uo <Plug>CCP_CutText
nmap up <Plug>CCP_PastText


noremap <silent><expr> <TAB>
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
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



"""""" ALE SETTINGS  """"""

" ale native automatic completion support.
let g:ale_completion_enabled = 1

"Disable whitespace warnings
let g:ale_warn_about_trailing_whitespace = 0

" disableing virual text for the current buffer
let g:ale_virtualtext_cursor = 'current'

"Disable virtualtext completely
let g:ale_virtualtext_cursor = 'disable'

"setting some backrground colors automatically for warnings and error in teh
"sign gutter.
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" If ale is running in combination with another lsp client, it may be good to 
" disable ale lsp functionality entirely.
let g:ale_disable_lsp = 1

" Automatically fix file when they are saved.
let g:ale_fix_on_save = 1
" Customise sign
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

"confiure the sign gutter open at all times
let g:ale_sign_column_always = 1


" Highlight can be disable completely by setting
let g:ale_set_highlights = 0

" highlight colorscheme
highlight ALEWarning ctermbg=DarkMagenta

"Displaying error information in the status bar. with vim airline
" leg g:airline#extensions#ale#enabled = 1

"Changing the border for floating preview windwos
let g:ale_floating_window_border = repeat([''], 8)

let g:ale_virtualtext_cursor = 'none'

let g:asyncomplete_auto_popup = 1


let g:nnn#set_default_mappings = 0

nnoremap <silent> <leader>nn :NnnPicker<CR>

nnoremap <leader>n :NnnPicker %:p:h<CR>



