"
" neovimの設定ファイル
"

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅"
set shiftwidth=4
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 対話括弧のハイライト表示を3秒にする
set matchtime=3

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start


"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
" set nolist
set list
" どの文字でタブや改行を表示するかを設定
" set listchars=tab:>-,extends:<,trail:-,eol:<
set listchars=tab:￫\ ,eol:⏎,space:･,extends:>,precedes:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" その代わり80文字目にラインを入れる
" set colorcolumn=80
" カーソル行に下線を引く
set cursorline

"---------------------------------------------------------------------------
" バッファの設定
"
" 新しいウィンドウを下に開く
set splitbelow
" 新しいウィンドウを右に開く
set splitright

"---------------------------------------------------------------------------
" 画面表示の設定:
"
" マウスの設定
set mouse=a				" 向こうにしたい場合には set mouse=-a
set clipboard=unnamedplus   " Yankした時にClipboardに入れる



"---------------------------------------------------------------------------
" 日本語入力関連
" <esc>をした段階で日本語Offにする/Kaoriya限定
" set imdisable 
" GoogleIBMの場合には、設定から「キー設定」。
"   [入力文字なし/Escape/キャンセル後 IME を無効化]を設定


"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif


"---------------------------------------------------------------------------
" Dein
" 
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
set runtimepath+=$HOME/.config/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = expand('$HOME/.config/dein')
let s:toml_dir = expand('$HOME/.config/nvim')

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_dir . '/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })
  " call dein#add('Shougo/deol.nvim')

  "call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  "call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#load_toml(s:toml_dir . '/dein.toml')
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
" syntax enable


" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
"

"---------------------------------------------------------------------------
" テーマに関する設定
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
" colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)
" colorscheme atom-dark
set background=dark
colorscheme jellybeans
" colorscheme hybrid
syntax enable




"============================================================================
" 個人の設定
"
"----------------------------------------------------------------------------
" 操作系
"----------------------------------------------------------------------------
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>


" 新規のバッファを作成して右側に移動
nnoremap <silent> <C-w>N <C-w>n<C-w>L


"----------------------------------------------------------------------------
" 動作の設定
"----------------------------------------------------------------------------
" カーソル位置の単語をmacの辞書で調べる
nnoremap ,? :!open dict://<cword><CR>


" 起動の設定
" 引数なしで起動した場合、NERDTreeを開く
autocmd vimenter * if !argc() 
		\ | Startify
		\ | NERDTree 
		\ | wincmd w
		\ | endif


"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"Quickfixが残っている場合に閉じる
augroup QfAutoCommands
  autocmd!
		" Auto-close quickfix window
		autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END


" 性能チェック
function! ProfileCursorMove() abort
  let profile_file = expand('~/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
    autocmd!
    autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction
