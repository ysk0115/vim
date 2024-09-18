"=============================================================================
" vimrc --- Entry file for vim
" Copyright (c) 2016-2022 Shidong Wang & Contributors
" Author: Shidong Wang < wsdjeg@outlook.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

" Use XDG paths if available
if !empty($XDG_CONFIG_HOME) && !empty($XDG_DATA_HOME) && !empty($XDG_STATE_HOME)
    set runtimepath^=$XDG_CONFIG_HOME/vim
    set runtimepath+=$XDG_DATA_HOME/vim
    set runtimepath+=$XDG_CONFIG_HOME/vim/after

    if exists('&packpath')
      set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
      set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after
    endif

    let g:netrw_home = $XDG_DATA_HOME."/vim"
    if !isdirectory($XDG_DATA_HOME."/vim")
      call mkdir($XDG_DATA_HOME."/vim", 'p')
    endif
    call mkdir($XDG_DATA_HOME."/vim/spell", 'p')

    set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
    set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
    set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
    set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')

    if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif
endif

" Note: Skip initialization for vim-tiny or vim-small.
if 1
    let g:_spacevim_if_lua = 0
    if has('lua')
        " add ~/.SpaceVim/lua to lua package path
        if has('win16') || has('win32') || has('win64')
            let s:plugin_dir = fnamemodify(expand('<sfile>'), ':h').'\lua'
            let s:str = s:plugin_dir . '\?.lua;' . s:plugin_dir . '\?\init.lua;'
        else
            let s:plugin_dir = fnamemodify(expand('<sfile>'), ':h').'/lua'
            let s:str = s:plugin_dir . '/?.lua;' . s:plugin_dir . '/?/init.lua;'
        endif
        silent! lua package.path=vim.eval("s:str") .. package.path
        if empty(v:errmsg)
            let g:_spacevim_if_lua = 1
        endif
    endif
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/init.vim'
endif
" vim:set et sw=2

" =========== ▽ webapi-vimを使い、APIを叩く▽ ===========
" 使い方
" https://www.key-p.com/blog/staff/archives/20732

"getの場合
"let res = webapi#http#get('URL')

"postの場合
"let res= webapi#http#post('URL')

"jsonをデコードする
"let content = webapi#json#decode(res.content)

"echoする
"echo content
" =========== △ webapi-vimを使い、APIを叩く△ ===========

"---------------------------------------------------------------------------
" チャットワークにAPIレスポンスを投稿

" command作成 (:API で投稿
command! -nargs=0 API :call s:ChatWorkSay(<f-args>)

" 関数
function! s:ChatWorkSay()

"===== SYNERGYデータベースAPI =====

  " access_token取得
"  let CLIENT_ID = 'adee800e-a7d8-4268-b0c3-f13ea6c2effb'
"  let CLIENT_SECRET ='PnzQLVIAUOQK7I4bEcMsMZqADqhT184O4l95gcaHFWlmsbKmD0z1J5PL5BkM7gYq'
  " クライアントID、クライアントシークレット:（コロン）で繋いで、base64 でエンコードした文字列
"  let AUTH_HEADER = 'YWRlZTgwMGUtYTZkOC00MjY4LWIwYzMtZjEzZWE2YzJlZmZiOlBuelFMVklBVU9RSzdJNGJFY01zTVpxQURxaFQxODRPNGw5NWdjYUhGV2xtc2JLbUQwejFKNVBMNUJrTTdnWXE='
"  let SCOPES = 'db:apidefinition:design db:openapi:read db:record:execute'
"  let DATA = 'grant_type=client_credentials&scope=' . SCOPES . '&audience=https://db.paas.crmstyle.com'

  " トークンをPOSTで取得 
"  let post_url = 'https://auth.paas.crmstyle.com/oauth2/token'
"  let res_token = webapi#http#post(post_url,
"    \ DATA ,
"    \ {'Authorization': 'Basic ' . AUTH_HEADER})

  " レスポンスをJsonデータのみに変換
"  let json_token = webapi#json#decode(res_token.content)
"  let ACCESS_TOKEN = json_token.access_token

" ファイルにACCESS_TOKENを書き込む
"  let access_token_file = 'C:/Users/y-nishiguchi/Desktop/access_token.txt'
"  call writefile([ACCESS_TOKEN], access_token_file)
"  let ACCESS_TOKEN = substitute(readfile(access_token_file)[0], '\n', '', '')

  " ▽Synergy エンドポイント
  " listApiDefinition 
  " https://db.paas.crmstyle.com/apis/apidefinition.database/v1/accounts/zzy/apidefinitions"

  " getDatabaseDefinition 
  " https://db.paas.crmstyle.com/apis/apidefinition.database/v1/accounts/zzy/databasedefinitions"

  " GET
"  let get_url = 'https://db.paas.crmstyle.com/apis/apidefinition.database/v1/accounts/zzy/apidefinitions'
"  let res_synergy= webapi#http#get(get_url,
"    \ {'accept': 'application/json'},
"    \ {'Authorization': 'Bearer ' . ACCESS_TOKEN})

"==================================

"===== Cuenote 即時SMS API =====

  " Quenote管理画面参照
  let ID = '65a648a777c760487a2340a3'
  let KEY ='CBFE879A050B6E3DE2520ABC33D73B42398A3E57D37CE4193DEB041DEEA'

  " トークンをPOSTで取得 
  let post_url = 'https://sms-console.cuenote.jp/v9/delivery'
  let res = webapi#http#post(post_url,
    \ {'accept': 'application/json'},
    \ {'Authorization': 'Basic ' . ID},
    \ {'to': {"number": '09058843150'},
    \       'content': {'message': 'HelloWorld!!', 'shortURI': true,},
    \       'timeLimit': 86400,
    \       'timeRange': {'from': '09:00', 'to': '21:00'}
    \ })

"==================================


"===== チャットワークへPOST (346979903 = roomID) =====
  let chat_url = 'https://api.chatwork.com/v2/rooms/346979903/messages'
  let CW_token = 'cf962dc846d401d2f288109d7d71c25a'


  " GETしたJsonデータをChatWorkにPOST
  let chat = webapi#http#post(chat_url ,
    \ {'body': {'body':res, 'self_unread':1} },
    \ {'X-ChatWorkToken':CW_token})
 
  echo "API_testスレッドに投稿完了"
"=====================================================


endfunction
"---------------------------------------------------------------------------

