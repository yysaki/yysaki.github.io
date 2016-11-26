---
title: 'WordPress セキュリティ強化後の&#8221;ディレクトリを作成できませんでした。&#8221;を解決する'
created_at: 2013-01-31
author: yysaki
layout: post
categories:
  - 未分類
tags:
  - Wordpress
---
&#8220;wordpress Markdown on Save Improved&#8221;プラグインをインストールする際に躓いた点を記事にしました。  
(このプラグインを使用して、この記事をmarkdown形式で書いたのですが使い勝手は上々です。)

以前このブログについて [WordPressのセキュリティを徹底強化 &#8211; CSSPRO][1] という記事を参考にセキュリティ強化を行ったのですが、プラグインの新規追加をダッシュボード上で行おうとした際に

      ディレクトリを作成できませんでした。 /xxx/xxx/xxxx/wp-content/upgrade/markdown-on-save-improved.tmp/markdown-on-save-improved
    

というエラーが出てしまう問題に遭遇しました。

試しにwp-content以下全てのディレクトリのパーミッションを777に変更しても状況は変わりませんでした。  
似たような症状がないかwebを検索すると [この記事][2]を発見し、そこでは&#8221;AskApache Password Protect&#8221;プラグインが原因になっていました。  
そこでセキュリティ強化の際インストールした&#8221;AskApache Password Protect&#8221;プラグインを一時停止してみると、プラグインの新規追加が無事行えました。

セキュリティ強化の記事では、wp-adminの保護のため&#8221;AskApache Password Protect&#8221;導入を進めていたのですが、このプラグインはwp-adminだけでなくwp-content以下にも影響があるものだったようです。  
今後プラグインの新規追加など行う際にはこのプラグインを停止することを忘れずにいたいと思います。

 [1]: http://csspro.digitalskill.jp/%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB/%E3%83%AF%E3%83%BC%E3%83%89%E3%83%97%E3%83%AC%E3%82%B9/wordpress%E3%81%AE%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E5%BC%B7%E5%8C%96/
 [2]: http://webcache.googleusercontent.com/search?q=cache:KWw6ipeQ-4kJ:openpne3.biz/category/%E6%9C%AA%E5%88%86%E9%A1%9E/+&cd=1&hl=ja&ct=clnk
