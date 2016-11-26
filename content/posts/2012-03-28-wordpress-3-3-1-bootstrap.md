---
title: WordPressでBootstrapテーマを触ってみる
created_at: 2012-03-28
kind: article
author: yysaki
layout: post
categories:
  - 未分類
---
今流行りのCSSフレームワークである、Twitter Booststrapについて、一度使ってみたいなーと記事を読みあさっていました。  
そこでTwitter Bootstrapで作られたWordPressテーマであるWPBSを使ってcssの勉強したいと思い、このwebサイトのテーマに設定しました。  
WPBSの設定の仕方などは以下の記事を参考にさせて頂きました。

はじめよう/Twitter Bootstrapで出来たWordPressテーマ「WPBS」を使ってみる 

http://getstarted.main.jp/blog/wordpress/twitterbootstrap-wordpress-theme-wpbs/

インストール、導入はとても簡単でしたが、一点不具合があり、少し解決に苦労しました。  
このテーマのウィジェットであるMain Sidebarは、ブログ記事枠の右に配置されています。  
しかしレイアウトが見本と比べ崩れ、位置が記事の下に配置されてしまいました。  
これは、前記事で引用ブロックの使用に誤りがあり、ブログ記事の枠から文字がはみ出て、ブログ枠隣にMain Sidebarの置ける余地がなくフローレイアウトでブログ枠下に流れたためでした。  
引用ブロックを正しい?文法に書きなおした時にこの症状が収まりました。

この不具合の内容をまとめると、ブログ記事の記述方法が悪いとWPBSテーマ全体のレイアウトが崩れる可能性があるから注意しましょう、という感じでしょうか。

また、WPBSは外観の変更が簡単(Bootstrapの性質)なので、テーマに少し調節をしてみて楽しもうかと思います。。
