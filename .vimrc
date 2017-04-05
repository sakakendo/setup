if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neocomplcache.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/vimshell.vim')
call dein#add('haya14busa/incsearch.vim')
"unite vim
call dein#add('Shougo/unite.vim')
call dein#add('kmnk/vim-unite-giti.git')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-scripts/quickrun.vim')
call dein#add('tpope/vim-fugitive')

"color
call dein#add('altercation/vim-colors-solarized')
"call dein#add('vim-scripts/SingleCompile')

call dein#end()

source ~/.vim/rc/ctrl.vim
"set background=dark
syntax enable
colorscheme elflord

set clipboard=unnamed,autoselect
set wrap
set number
set ruler
set hlsearch
set ignorecase
set smartcase
set incsearch
set noswapfile
set laststatus=2
set showmode
set t_Co=256
"set cursorline

"auto close 
imap { {}<LEFT>
imap < <><LEFT>
"imap ( ()<LEFT> 
nmap <ESC><ESC> :nohlsearch<CR><Esc>
inoremap <silent>jj <Esc>
inoremap <silent>ZZ <Esc> :exit<CR>
"easy build
nmap <F5> :make<CR>
"nmap <F9> :echo 'hello'<CR>
nnoremap <silent><C-e> :NERDTreeToggle<CR>
"split window
nnoremap <silent>ss :split<CR>
nnoremap <silent>sv :vsplit<CR>
nnoremap <silent>sh :<C-w>h<CR>
nnoremap <silent>sj :<C-w>j<CR>
nnoremap <silent>sk :<C-w>k<CR>
nnoremap <silent>sl :<C-w>l<CR>
nnoremap <silent>sw :<C-w>w<CR>
nnoremap j gj
nnoremap k gk
"neo complete
let g:acp_enableAtStartup=0
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#source#dictionary#dictionaries={
	\'default':'',
	\'vimshell':$HOME.'/.vimshell_hist',
	\'scheme':$HOME.'/.gosh_completitons'
	\}
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns={}
endif
let g:neocomplete#keyword_patterns['default']='\h\w*'
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>": "") . "\<CR>"
endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>":"\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
if !exists('g:neocomplete#sources#omni#imput_patterns')
	let g:neocomplete#sources#omni#input_patterns={}
endif
let g:neocomplete#sources#omni#input_patterns.perl='\h\w->\h\w*\|\h\w*::'






set whichwrap=b,s,h,l,<,>,[,],~

" tab indent{
set tabstop=4
set shiftwidth=4
set autoindent
"set expandtab
set noexpandtab
set cindent
set showcmd

"lightline.vim
let g:lightline={
	\'colorscheme' : 'solarized',
	\}

"save cursol position
if has ("autocmd")
	autocmd BufReadPost *
	\ if line("'\"" ) > 0 && line("'\"" )<= line("$" )|
	\	exe "normal! g'\"" |
	\endif
endif

"gtags
map <C-h> :global -a<CR>
"map <C-h> :Gtags -f %<CR>
"map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>
"ctags
"set tags=.,/usr/include,~/Archives/linux

"status
set statusline+=%{fugitive#statusline()}

"tab
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


