"---------------------------------------------------------------------------
" ファイル操作に関する設定:

" 自動保存
let g:auto_save = 1

" クリップボードにコピーする設定
set clipboard=unnamed
"---------------------------------------------------------------------------
" ウインドウに関する設定:

" ウインドウの幅
set columns=150
" ウインドウの高さ
set lines=36
"---------------------------------------------------------------------------
" インデントガイド:

" インデント位置
set ts=4 sw=4 et
" インデントガイドスタート位置
let g:indent_guides_start_level = 2
" インデントガイドの幅
let g:indent_guides_guide_size = 1
"---------------------------------------------------------------------------
" その他、見栄えに関する設定:

" カレント行のナンバリングカラー
hi CursorLineNr term=bold guifg=NONE
" diffの分割を垂直
set diffopt+=vertical
" タイトルの非表示
set notitle
" ツールバーの表示
set guioptions+=m
" Vimを半透明化
autocmd VimEnter * VimTweakSetAlpha 245
"---------------------------------------------------------------------------
" ディレクトリツリーに関する設定:

" ブックマークを表示
let g:NERDTreeShowBookmarks = 1
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" ディレクトリツリーの横幅
let NERDTreeWinSize = 32
" ディレクトリツリーのアイコン幅を調整
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ' '
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
"---------------------------------------------------------------------------
" エンコードに関する設定:2021/06/16
" 解説:
" Vimの内部文字コード(encoding)
" ファイル書き込み時の文字コード(fileencoding)
" 読み込み時の文字コード(fileencodings)

scriptencoding utf-8
set encoding=UTF-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp,utf-8set,
"---------------------------------------------------------------------------
" キーマッピング

" F12でカレントディレクトリをエクスプローラで開く
nmap <F12> :silent ! start %:h<CR>
