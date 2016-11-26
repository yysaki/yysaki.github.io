---
title: WordPress 3.3.1 自動update時のout　of　memoryエラー
created_at: 2012-02-13
author: yysaki
layout: post
categories:
  - 未分類
tags:
  - ブログ
---
wordpressの更新ボタンを押し3.3.1へのインストールを行わせると

> Fatal error: Out of memory (allocated 22282240) (tried to allocate 3932160 bytes) in /usr/home/nextweb/starm/html/yysaki/wp/wp-includes/class-http.php on line 1066

の警告が出てupdateに失敗した。バックアップデータはこの後update作業前に残せたので一安心。  
そして”Out of memory”の原因を探る。  
参考にしたWordPressのフォーラム記事(http://wordpress.org/support/topic/fatal-error-out-of-memory-4)によると、対策法は

> text editor and change the values for memory\_limit. By default it should see memory\_limit = 8M. Try changing it to 12M. if it wil not resolve the problem then try to increase it either 16M or 24M.
> 
> 2) If you can’t find the php.ini file, open up the PHP file which requires more memory and add this line just after ini\_set(’memory\_limit’, ‘12M’); we can increase memory upto 16M or 24M to resolve the issue. But do it try with 12M first.
> 
> 3) In last, open the .htaccess file from the root/public\_html folder and add this line php\_value memory_limit 12M 

のようだ。  
レンタルしている鯖はroot権限が無いため1), 3)の対処が取れず、2)なら望みがありそうだ。  
エラー文によると 原因は&#8221;class-http.php on line 1066&#8243;行コマンドのメモリ不足なので、1066行の一行前にそのメモリ使用量を増やす関数を追加することで、解決できそうだ。  
しかし, memory_limitの値は変更出来ない場合があり include/setup.inc.php を編集して解決する例があった。(参考記事: http://d.hatena.ne.jp/rougeref/20100108)  
よって私の環境では1), 3)同様php.iniに触れないため、対処できないことがわかりました。  
他の環境でもroot権限がありPHPの設定をいじれる方なら３方法いずれでも対処出来る問題だと思います。

よって結論としては、現環境ではWordpress自動アップデートはサーバのPHPメモリ使用量制限と使用量操作へのアクセス権がないこと、の二点でした。  
今回は諦め、今回は手動インストールしてみます。

(2012/02/13追記)  
3.3.1の手動インストールを後で行った所、問題なく成功しました。しかしやはり手間だった

(2012/02/13追記2)  
php.iniは.htaccessのあるディレクトリに自分で置き、&#8221;memory_limit=48M&#8221;と書けばOKでした

(2012/3/27追記3)  
本文のレイアウトが崩れていたのを修正
