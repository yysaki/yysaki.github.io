---
title: 『シェル操作課題 』をシェルで解きなおす
created_at: 2013-04-04
kind: article
author: yysaki
layout: post
categories:
  - 未分類
tags:
  - プログラミング
---
以前解いた[『シェル操作課題 』をRubyのワンライナーで解いてみた][1] の問題をunixコマンドのみで解き直した。

<script src="https://gist.github.com/yysaki/5310298.js">{}</script>

*   `uniq -c`で重複した数をカウント出来る
*   `sort`の`-k`オプションを同時に指定することで第一指定順、第二指定順でソート出来る

 [1]: http://yysaki.com/blog/archives/79
