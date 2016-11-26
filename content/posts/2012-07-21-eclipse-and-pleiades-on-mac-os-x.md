---
title: Mac OS Xにeclipse + pleiadesをインストールする時少し引っ掛かった
created_at: 2012-07-21
kind: article
author: yysaki
layout: post
categories:
  - 未分類
---
macbookair を借りて作業ができるようになったので、プログラミング開発環境を整えています。  
Mac OS Xがlinuxベースであることからunixライクなターミナルを立ち上げることが出来ることや、パッケージ管理のHomeBrewがあることがWindowsと比べ魅力的だと感じています。

今回はjavaの開発用にeclipse4.2 + pleiades1.3.4をインストールしました。  
下にあるリンクの記事を参考にしてインストール手順を進めたのですが、pleiades関係で一点だけ詰まった箇所があったのでそれをメモしておきます。

その詰まった箇所とは、eclipse起動時にpleiadesを呼び出すためeclipse.iniに記述する一行です。それが、

-javaagent:plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar 

では良くなく、パスを絶対パスで

-javaagent:/Applications/eclipse/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar 

のように記述することが必要でした。  
(Readme.txtをよくよく読めば解決する話でしたがどうも見落としてしまったようです^^;)

他の手順はリンク先を参考にし、上記問題を解決したところでeclipseは無事動作したので、無事Eclipse上でjavaのHello Worldプログラムを実行することができました。  
後は/Application/に放り込み、eclipse.AppをDockに並べた所でeclipseのインストールは完了しました。

以上です、MacのインストールはWindowsと違ってレジストリを気にしたり実行ファイル置き場に悩まなくて済むからスマートでいいですね！

参考:  
[MacでPleiades All in One Eclipse &#8211; Archit!!  
][1]

 [1]: http://d.hatena.ne.jp/architshin/20110224/1298519661
