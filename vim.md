# セットアップでやること

- [インストール](#インストール)
- [設定ファイル](#設定ファイル)
- [プラグインマネージャの用意](#プラグインマネージャの用意)
- [ファイラプラグインの用意](#ファイラプラグインの用意)
- [NERDTreeの設定](#ファイラプラグインの用意)

# インストール

主に4種類あって、

- GUIのVim
- CLIのVim
- NeoVim
- IDEのプラグインとしてのVim

GUIはGVim、MacVimという名前です。Vim本体とは別に開発されています。日本語環境も揃うKaoriya版を入れるのが安定。

- Windows: [Vim — KaoriYa](https://www.kaoriya.net/software/vim/)
- Mac: [splhack/macvim-kaoriya: MacVim-KaoriYa](https://github.com/splhack/macvim-kaoriya)
	- →[リリースページ](https://github.com/splhack/macvim-kaoriya/releases/tag/20171020)からダウンロード

Macには最初からCLIのVimが入っています。Windowsにはないが[WSL](https://msdn.microsoft.com/en-us/commandline/wsl/faq)やGit Bash等には最初から入ってる感じがします。

NeoVimはVimを現代風に書き直そうみたいな運動から出てきたもの(要出展)です。割と最近良い感じのようなので、そちらでも構いません。GUIはまた別途ある。今回は話しません。

例えばJetBrain系のIDE（Android Studioとか）には[IdeaVim](https://plugins.jetbrains.com/plugin/164-ideavim)というのがあります。MSVSにも何かあったな、何だっけ。

## 起動と終了

GUIは、Windowsなら `gvim.exe` 、Macなら `MacVim.app` を起動します。

CLIで試す場合は `gvim` ではなく `vim` で起動します。（パスはうまいこと設定しておいてください。）

```console
$ vim
```

起動後、 `:q` と入力すると終了します。何か文句言われたら `Esc` 連打の後に `:qa!` してください。

# 設定ファイル

以下のファイルが最初に読み込まれます。ここにいろいろ設定を書き込みます。

- Windows: `%HOME%/_vimrc`, `%HOME%/_gvimrc`
- Mac: `~/.vimrc`, `~/.gvimrc`

それぞれ "vimrc" は最初に、 "gvimrc" はGUI（アプリ単独）で起動した場合その次に読み込まれます。

## 設定ファイルの書き方

コマンドモードでできることを、 `:` を飛ばして書けば動きます。

例えば起動後に `:set number` する代わりに以下を書けます。

```vim
set number
```

## 設定ファイルを共有するには

[Gitでバージョン管理したい](https://github.com/ginpei/dotfiles/blob/master/.vimrc)とかDropboxで複数環境から共有したいとか、そういう場合はそっちに本体を置いて、上記のファイルからは `source` で外部ファイル読み込むと良いかと。

```
source ~/dotfiles/.vimrc
```

# プラグインマネージャの用意

今後拡張していくことになると思いますが、まずは管理ツールを入れるとこの先がスムーズでしょう。

[dein.vim](https://github.com/Shougo/dein.vim) を使うのがおすすめです。というかもうその前提で行きます。

インストールはREADMEに書かれている通り。注意点二つ。

- "{specify the installation directory}" の部分を何か（例えば `~/.vim/bundles` ）に置き換えるのを忘れない
- インストールスクリプト実行後、 `.vimrc` 記載コードが出力されるので、コピーしておく

例示される設定では、三つのプラグインが読み込まれるようになっています。不要なら削除してしまっても構いません。

## 自動インストール

簡単にインストールは済ませたいので、末尾の方にある "If you want to install" あたりをコメント解除してください。行頭の二重引用符 `"` を削除します。また削除も自動でやってもらうよう一行追加します。

"If you want to install" のあたり、以下のようになるはずです。

```vim
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")
```

これで `dein#add()` を書いたり消したりするだけでよくなりました。（次項参照。）　これらを設定しない場合は、変更時に自分でインストール、削除を行う処理を呼ぶ必要があります。

## プラグインの追加と削除

前項の自動化を前提とします。

1. プラグインのGitHubリポジトリを見つける
2. `dein#add('xxx/xxx')` を追加
3. Vimを再起動

次項で紹介するNERDTreeを例に。

まず、GitHubのリポジトリは以下にあります。

- https://github.com/scrooloose/nerdtree

なので、ユーザー名とリポジトリ名を取って `scrooloose/nerdtree` が識別子になります。

これを関数で呼び出すので、以下を `.vimrc` に追加することになります。

```vim
call dein#add('scrooloose/nerdtree')
```

追加する場所は空気読んでください。 "Add or remove your plugins here" のコメントがあるはずなので、その下に並べてください。

たぶんこんなん。

```vim
  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/nerdtree')
```

記述後にはVimを再起動します。すると自動的にインストールが終わり、新しいプラグインが追加されているはずです。

（他に `source` するという手もあります。今回は説明しません。）

# ファイラの用意

前項の例でインストールしたNERDTreeの使い方を紹介します。ファイル操作までできるようになればだいぶ自由度高まると思うので。

ExplorerやFinderのように、ディレクトリをたどりながら視覚的にファイルを探せます。

- [scrooloose/nerdtree: A tree explorer plugin for vim.](https://github.com/scrooloose/nerdtree)

```vim
call dein#add('scrooloose/nerdtree')
nnoremap <C-t> :NERDTreeToggle<CR>
```

これで `<C-t>` でファイルがツリー表示されるペインを開閉できるようになりました。

そのペインではノーマルモードの操作に加え、以下を利用できます。

- `Return` ... 該当ファイルを開く。該当ディレクトリを開閉
- `t` ... 該当ファイルを別タブで開く
- `i` ... 該当ファイルを別ウィンドウ（同タブ内）で開く
- `m` ... メニューを表示（ファイルコピー等）
- `p` ... 親ディレクトリへ
- `u` ... ルートディレクトリの親をルートディレクトリに
- `I` ... 隠しファイルを表示、非表示
- `B` ... ブックマーク一覧を表示、非表示
- `:Bookmark` ... ブックマークへ追加
- `D` ... ブックマークから削除

他にもたくさんあるのでヘルプを参照。ヘルプの参照の仕方は別稿。

## ウィンドウ、タブ

複数のファイルを編集する場合は（Vim内部の）ウィンドウやタブを使うと便利です。

説明は[別稿](./vim-basics.md#ウィンドウとタブ)に分けますのでお楽しみに。

# インストールのトラブルシュート

## Vimが見つからない（Windows）

```console
> vim
'vim' is not recognized as an internal or external command,
operable program or batch file.
```

パスが通っていません。

- [windows パスを通す - Google Search](https://www.google.co.jp/search?q=windows+%E3%83%91%E3%82%B9%E3%82%92%E9%80%9A%E3%81%99)

# 実践編

- [モード](#モード)
- [キー表現](#キー表現)
- [ノーマルモード](#ノーマルモード)
- [挿入モード](#挿入モード)
- [ビジュアルモード](#ビジュアルモード)
- [コマンドモード](#コマンドモード)
- [ウィンドウとタブ](#ウィンドウとタブ)
- [マップ](#マップ)

# モード

Vimはいくつかの「モード」を切り替えて使用します。

- ノーマルモード ... 移動
- 挿入モード ... 編集
- ビジュアルモード ... 選択
- コマンドモード ... 操作

（他にもあります。）

# キー表現

諸々見ていく前に、見方を示します。

## 一般

- `x` ... Xキーのみ
- `X` ... Shift + X
- `<C-x>` ... Ctrl + X
- `<C-S-x>` ... Ctrl + Shift + X
- `abc` ... Aキーの後にBキー、続いてCキー
- `:echo Hello` ... `:` キーでコマンドモード以降の後に `echo Hello` を入力
- `:echo Hello<CR>` ... `:` キーでコマンドモード以降の後に `echo Hello` を入力、続けてReturnキーを押す

CtrlキーとShiftキーを使います。Macのcommandキーは使いません。（でもMacVimなら `⌘+V` とかで文字列のコピペができます。）

Alt/optionキーも使えるようですが、あんまり使わない気がします。環境依存だから？　（未調査）

## 特殊キー

- `<CR>` ... Return (Carriage Return)
- `<Tab>` ... Tab
- `<Esc>` ... Esc
- `<Space>` ... スペース
- `<Left>` ... 左矢印キー（←）
- `/` ... スラッシュ
- `!` ... ! (Shift + 1)

`:help keycodes` にもっとたくさん載ってます。

## エスケープ

`\` でエスケープします。

- `\\` ... バックスラッシュ一文字
- `\<Home>` ... "&lt;Home&gt;" という文字列（Homeキーではない）

```vim
inoremap <C-h> <Home>   " Ctrl + HでHomeキーの代わり
inoremap <C-h> \<Home>  " Ctrl + Hで "<Home>" と入力
```

`inoremap` については後述。

## コメント

二重引用符 `"` がコメントになります。

```vim
" 基本設定
set number
set autoindent
```

# ノーマルモード

基本となる、移動するモードです。一部編集作業もできます。

`Esc` を連打するとだいたいノーマルモードに戻ります。

- 一文字移動 `h`, `j`, `k`, `l`
- 単語移動 `w`, `W`, `b`, `B`, `e`, `E` (Word, word Backward, the End of word)
- 行内移動 `^`, `0`, `$`
- スクロール `<C-u>`, `<C-d>`, `<C-f>`, `<C-b>` (Up, Down, Forward, Backward)
- 現在位置を基準にスクロール `z<CR>`, `zz`, `z-`
- ファイル先頭、末尾へ移動 `gg`, `G`
- ヤンク（コピー）と貼り付け `yy`, `p`, `P` (Yank, Paste)
- 検索 `*`, `n`, `N`, `/` (Next)
- 検索履歴 `q/`
- 元に戻す、やり直し `u`, `<C-r>`
- 直後の操作を32回繰り返す `32a-<Esc>`
- 直前の編集をもう一度繰り返す `.`

## 編集履歴

`u` と `<C-r>` で行ったり来たりします。

Vimの環境によっては履歴がひとつしか残っていないタイプ（ `u` 連打で行ったり来たりになるやつ）もあります。

## 操作の前に数字を入力すると、その回数繰り返す

例えば `yy` の後に `p` で行を複製することができますが、これを `3p` とすると、三回貼り付けることができます。

また「 `o` で改行して挿入モードへ入り、入力後に `<Esc>` でノーマルモードに戻ってくる」という動作を考えます。Vim的に表現すると、 `ohello<Esc>` です。

```
hello
```

ここで `3ohello<Esc>` とすると、それを三度繰り返したことになり、以下が入力されます。

```
hello
hello
hello
```

## `.` で直前の操作を繰り返し

`.` 最強です。まじつよい。まじつよ。さいつよ。

例えば `yy` の後に `p` で行を複製することができますが、その直後に `.` とすると、もう一度 `p` を押したかのようにもう一行貼り付けることができます。

数字と組み合わせて `3.` のように使うこともできます。

また「 `o` で改行して挿入モードへ入り、入力後に `<Esc>` でノーマルモードに戻ってくる」という動作を考えます。Vim的に表現すると、 `ohello<Esc>` です。

その直後に `.` とすると、再び `ohello<Esc>` を入力したことになります。

# 挿入モード

普通の文字入力をするモードです。

- ノーマルモードから挿入モードへ `i`, `I`, `a`, `A` (Insert, Append)
- ノーマルモードへ戻る `Esc`, `<C-[>`, `<C-c>`
- ノーマルモードから改行して挿入モードへ `o`, `O`
- ノーマルモードから削除して挿入モードへ `s`, `S`, `cc` (Substitute, ?)
- 補完 `<C-n>`, `<C-p>`

補完はプラグインなしでも、どこかで使われている単語であれば補完できます。

## `c` の組み合わせ

`c` の次に移動の操作ひとつを組み合わせて、その範囲を削除しつつ挿入モードへ入ることができます。

- `c$` ... 行末まで削除して挿入モードへ
- `ce` ... 単語末尾まで削除して挿入モードへ
- `c^` ... 行の先頭まで削除して挿入モードへ
- `c3l` ... 三文字右まで削除して挿入モードへ

# ビジュアルモード

- ノーマルモードからビジュアルモードへ `v`, `V`, `<C-v>`
- ノーマルモードへ戻る `Esc`, `<C-[>`, `<C-c>`
- 選択しているものを削除して挿入モードへ `s` (Substitute)
- 選択しているものをコピー `y` (Yank)
- 選択範囲の逆側へカーソルを移動 `o`
- 矩形選択で、前後へ挿入 `I`, `A` (Insert, Append)

# コマンドモード

ファイル全体やVim自体に対する操作をします。画面下の一行か二行の欄です。（慣例的に ":" も含めています。）

- ノーマルモードからコマンドモードへ `:`
- ノーマルモードへ戻る `Esc`, `<C-[>`, `<C-c>`
- コマンドモードで入力したコマンドを実行 `<CR>`
- コマンドモードで左右移動 `<Left>`, `<Right>`
- 過去に呼び出した入力を呼び出す `<C-p>`, `<C-n>` (uP, dowN)
- 上書き保存 `:w<CR>`
- 名前xxxを付けて保存 `:w xxx<CR>`
- 読み込み `:e<CR>`
- 強制再読み込み `:e!<CR>`
- 123行目へ移動 `:123<CR>`
- 閉じる `:q<CR>`
- 全て閉じる `:qa<CR>`
- 上書き保存して終了 `:wq<CR>`
- 行番号を表示 `:set number`
- 行番号を非表示 `:set nonumber`
- ノーマルモードで、履歴を見る `q:`
- ノーマルモードで、直前のコマンド実行を繰り返す `@:`

ファイル読み書きはNERDTreeでやった方が良いんじゃないかなー。

# ウィンドウとタブ

Vimを一度起動すれば、そのなかで複数のファイルを編集したり、あるいは同じファイルの複数個所を並べて眺めたりすることができます。

## ウィンドウ

Vimでは画面を分割して複数の作業を並行して行うことができます。この分割した画面のことを「ウィンドウ」と呼びます。これはGUIのウィンドウとは別の用語です。

- 画面を縦に分割 `<C-w>s` (Split)
- 画面を横に分割 `<C-w>v` (Vertical split)
- ウィンドウを閉じる `<C-w>c`, `<C-w>o` (Close, close Other windows)
- 次のウィンドウへ移動 `<C-w>w`
- 隣接するウィンドウへ移動 `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l`

ウィンドウはタブ（次項）の内側に存在する的な感じです。

## タブ

タブはコマンドモードから増やします。

- `:tabnew` ... 新しいタブを開く
- `:tabnext` ... 次のタブへ移動
- `:tabprev` ... 前のタブへ移動

うひゃあ面倒ですね。キーに割り当てると良いかもしれません。

```vim
nnoremap <C-W>t :tabnew<CR>
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
```

# マップ

さてさて、Vimの非常に強力な機能のひとつです。キー入力をカスタマイズして、任意の機能へ割り当てることができます。

基本的に以下の文法で `.vimrc` へ記述します。書き換えたら再起動（あるいは `source` ）をお忘れなく。

```vim
{x}noremap {command} {operation}
```

- {x} ... 対象モード。 `n` = ノーマルモード、 `i` = 挿入モード、 `v` = ビジュアルモード。
- {command} ... 入力コマンド
- {operation} ... 実行コマンド

例えば「 "Ctrl + W" の後に "T" 」という入力を `:tabnew` の代わりにする場合、以下のようになります。

```vim
nnoremap <C-W>t :tabnew<CR>
```

## 矢印キーを無効化

ノーマルモードで矢印キーを押しても何も起こらないようになります。スパルタ！

```vim
nnoremap <Left> <Nul>
nnoremap <Down> <Nul>
nnoremap <Up> <Nul>
nnoremap <Right> <Nul>
```

## Ctrl+Sで保存

```vim
nnoremap <C-s> :w<CR>
```

コマンドを割り当てる場合は `:` で開始します。最後に `<CR>` で実行するのを忘れないように。

# ヘルプ

Vim本体の機能の他、多くのプラグインはヘルプが充実しています。早めに慣れておくと自習が捗ります。

例えばNERDTreeのヘルプを見る場合、以下で別ウィンドウに開きます。

```
:help NERDTree
```

Vimの初期操作も探すことができます。あら便利。

```
:help j
:help :w
:help ctrl-v
```

ヘルプはRead Onlyモードですが、ノーマルモードで操作できます。加えてリンクになっている個所では、 `<C-]>` でジャンプできます。また履歴ジャンプも活用すると良いでしょう。

- （ヘルプで）リンクを開く `<C-]>`
- ジャンプする前の位置へ戻る `<C-o>`
- ジャンプから戻ってきた先の位置へ戻りなおす `<C-i>`

# 推薦図書

## 実践Vim

- [実践Vim　思考のスピードで編集しよう！ (アスキー書籍) | Ｄｒｅｗ Ｎｅｉｌ, 新丈 径 | 工学 | Kindleストア | Amazon](https://www.amazon.co.jp/dp/B00HWLJI3U/)

最高のVim本です。序盤から「実践」が始まり、キー入力ひとつずつに対しカーソルや編集対象が変化していくかを並べて見せてくれます。大変わかりやすい表現になっています。（私の表現が大変わかりづらいのは申し訳ありません。）

紙の本とKindle版があります。Kindle版は固定レイアウトではないので、スマホでも読むことができます。（実践できないけど。）

## Learn Vimscript the Hard Way

- [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/)

英語。

多数のトピックに分かれて説明されています。言語を差し引いても一番最初はちょっと難しいかも。逆にちょっと慣れた方なら、なんとなく使っていたものがどんどん明らかになっていくので大変ためになります。

PDFやepub、紙の本も販売中。オンラインで読む分には無料。

# おすすめプラグイン

## イケてるステータスバーを表示

- [itchyny/lightline.vim: A light and configurable statusline/tabline plugin for Vim](https://github.com/itchyny/lightline.vim)

現在のモードやファイル名、エンコード等の情報を表示します。きれい。

## インデントレベルをわかりやすく表示

- [nathanaelkane/vim-indent-guides: A Vim plugin for visually displaying indent levels in code](https://github.com/nathanaelkane/vim-indent-guides)

## 画面内の好きなところへ一瞬で移動

- [easymotion/vim-easymotion: Vim motions on speed!](https://github.com/easymotion/vim-easymotion)

READMEのGif動画を見てください。ジャンプします。

## パスや名前で絞り込んでファイル読み込み

- [ctrlpvim/ctrlp.vim: Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.](https://github.com/ctrlpvim/ctrlp.vim)

NERDTreeと違ってファイル名が分かっている場合、こちらの方が選択が早いです。

## HTMLやCSSの入力支援

- [mattn/emmet-vim: emmet for vim: http://emmet.io/](https://github.com/mattn/emmet-vim)

例のタグや例のプロパティを例の良い感じで入力できる例のアレ。

HTMLやCSSだけじゃなさそうだけど。
