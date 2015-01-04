---
layout: post
title: "octopress as a tracer bullet"
date: 2014-02-12 02:27:45 +0900
comments: true
categories: 
  - blog
---

一旦ブログをoctopressで立ち上げたは言いものの、[@kana](https://twitter.com/kana1)さんより

<blockquote class="twitter-tweet" lang="ja"><p><a href="https://twitter.com/yysaki">@yysaki</a> ほしのかずほどありますね! <a href="http://t.co/cnDApQUMHV">http://t.co/cnDApQUMHV</a> Ruby製だとnanocがコンパクトにまとまってて冀(neocomplcache_start_auto_complete)部実装も面白いですね。</p>&mdash; Kana Natsuno (@kana1) <a href="https://twitter.com/kana1/statuses/432530023648485378">2014, 2月 9</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

とコメントを頂戴したので、色々とRuby製の静的サイトジェネレータについて調べました。

<!-- more -->

## ツール選び
自分のブログ作成における価値観は、以下のようになります。

0. 静的サイトジェネレータでGithub Pagesに運用の楽なブログを作る
0. Markdownで記事を書きたい
0. サクサクカスタマイズ出来てそれなりの見栄えなブログを作りたい
    * octopressのリキッドレイアウトとかかっこいいよね！
0. 手慣れたRuby製ツール
0. HP作りの勉強を兼ねるので魔術的要素が少なくコンパクトなフレームワークがいい

その中、候補としては、

* nanoc
* jekyll(octopress)
* middleman

あたりに絞られました。
静的サイトジェネレータの比較は色々な記事が挙がっているので本記事では取り上げず、参考にしたリンクを下記に示すだけに留めます。
この中でnanocがヘルパーメソッドを手作りしたり自分でブログの機能を作成する感が楽しそうです。
octopressもとてもいいのですが、新しくカスタマイズする分には型にはまりすぎる印象があります。
そのため将来的にはnanocを使ってみたいですね。

## 引っ越し
しかしながらまずは引っ越し元のWordpressを荷下ろしを終わらせたいので、octopressでしばらく運用してみようと思います。
自分なりのブログに対する要求分析がしっかりされてないので、どんな機能をnanocで作っていきたいかをoctopressで洗い出すのも重要ですし。

また、多少ながらカスタマイズとして、ブログコメントサービスのDisqusの導入やはてブボタンの設置など以下のリンクを参考にやってみました。
* [5分でできる簡単 Octopress セッティング - 酒と泪とRubyとRailsと](http://morizyun.github.io/blog/octopress-hatena-disqus-new-tab/)

## 結論
曳光弾としてoctopressに引っ越して要件を洗い出しつつ、将来的にはnanocでブログの自作をする方針で行こうと思います。


### 参考リンク
* [Static Site Generators](http://staticsitegenerators.net/)
* [Nanoc以外の静的サイト生成ツールを調べてみた | ひげろぐ](http://higelog.brassworks.jp/?p=2076)
* [Ruby Red Bricks - From Octopress to nanoc](http://rubyredbricks.com/blog/2013/09/30/from-octopress-to-nanoc/)
* [nanoc導入メモ 1/5 「Getting Started」編 - ナレッジエース](http://n.blueblack.net/articles/2012-05-03_02_nanoc_getting_started/)
