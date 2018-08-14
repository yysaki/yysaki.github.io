---
title: ビルドしたpdfをsshfsからSkimで読む
created_at: 2013-12-29
kind: article
author: yysaki
layout: post
categories:
  - プログラミング
---
この度修論の開発環境を整えたのでブログ記事にしました。

## 背景

研究室マシンでtexを編集しているのですが、作業結果のPDFを手元で快適に確認したいのです。 そこで、開発方針を以下のように整えました。

*   研究室マシンでtexの編集、ビルドを行う。
*   sshfsをマウントすることで研究室マシンにアクセスする。
*   Skimでsshfs上のpdfを閲覧し、自動更新モードで変更を反映する。

環境は以下のとおりです。

*   ローカル: Mac OS X Mavericks、なるべくhomebrewを使う
*   リモート: Linux、sshで接続

## OSXFUSEのインストール

まず下記URLからOSXFUSEをダウンロード、インストールします。

*   [FUSE for OS X &#8211; Browse Files at SourceForge.net][1]

先にhomebrewでfuse–4x-kextを試したのですが、正しくsshfsを動作させられなかったのでこちらを採用です。

## sshfsのインストール

以下のコマンドでインストールします。

        $ sudo brew link fuse4x
        $ sudo brew install sshfs
        $ sudo /bin/cp -rfX /usr/local/Cellar/fuse4x-kext/0.9.2/Library/Extensions/fuse4x.kext /Library/Extensions
        $ sudo chmod +s /Library/Extensions/fuse4x.kext/Support/load_fuse4x
    

以下のコマンドでマウントします。

        $ mkdir mnt
        $ sshfs -p 22 [User]@[Host]:[Dir] mnt
    

マウントが出来たかどうかはdfで確認出来ます。 またマウントを解除するには以下のコマンドです。

        $ unmount mnt
    

## Skimのインストール

以下のURLからダウンロード出来ます。

*   [Skim | Home][2]

自動更新を行うため「環境設定&#8230; > 同期する > ファイルの変更をチェック」をちぇっくします。

## その他

*   バージョン管理はgithubのプライベートリポジトリで行っています。修論目的であれば学生用アカウントを申請することで、無料でMicroプランに加入できました。 
    *   [Contact GitHub][3]

*   エディタはvimを使用しています。以下のように.vimrcを設定すれば&#8221;&lt;Space&gt;q&#8221;でtexのmake出来ます。
    
        NeoBundle 'thinca/vim-quickrun'
        silent! map <Space>q <Plug>(quickrun)
        let g:quickrun_config['tex'] = {"command": "make", "exec" : "%c %o",  "outputter": "error:buffer:quickfix"}
        

*   学生共用のマシンで作業してるので、負荷を考え自動ビルドはやめときました。自分でmakeコマンドを叩きたくない人はOcamlのOmakeやRubyのGuardを使うと良さげです。

## まとめ

以上で修論の開発環境を整えました。 開発マシンでtexの編集を行い、ビルドするとSkimの自動更新が反応して新しいPDFを表示してくれます。 Vimで&lt;Space&gt;qすることでPDFのレビューまで自動化出来たので概ね満足な結果です. (但しSkimが反映されるまでに10秒程かかります。sshfsの限界&#8230;)

## 参考記事

*   [Mounting a Filesystem via SSH on OSX Mavericks &#8211; DanielAndrade.net][4]
*   [Macでsshfsを使う | yamaq blog][5]
*   [MacWiki &#8211; Skim][6]

 [1]: http://sourceforge.net/projects/osxfuse/files/?source=navbar
 [2]: http://skim-app.sourceforge.net
 [3]: https://github.com/edu
 [4]: http://www.danielandrade.net/2013/10/28/mounting-a-filesystem-via-ssh-on-osx-mavericks/
 [5]: http://mount-q.com/yamaqblog/?p=15899
 [6]: http://macwiki.sourceforge.jp/wiki/index.php/Skim
