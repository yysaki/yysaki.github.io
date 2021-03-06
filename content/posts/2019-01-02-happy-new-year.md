---
layout: post
title: "昨年の振り返りと新年の抱負"
created_at: 2019-01-02
kind: article
date: 2019-01-02 15:00:00 +0900
comments: true
categories:
  - year
  - book

---

明けましておめでとうございます。
早いもので2018年があっという間に一年が過ぎていきました。
せっかくの節目の時ですので、備忘のために昨年の振り返りと新年の抱負を書いていきたいと思います。

<!-- more -->

## 読書について

今年は読書ペースが例年より上がりました。
booklogから取れた読書記録のグラフを貼ってみます。

<img src="/images/reading_2018.png" alt="今年一年のグラフ" width='50%'/>

年内に100冊読むのがちょっとした目標だったのですが達成ならずです。
なお、漫画、ライトノベルはカウントすると件数が乱高下するので記録しない習慣でいます。

趣味の読書としては一般小説やSF、ノンフィクションものが多く、勉強を兼ねた読書では７月はIT技術書がメインに読んでいました。
前者で読んでよかったものを３つ挙げると「アンドロイドの夢の羊」、「五色の虹」、「わたしを離さないで」。
後者では「レガシーコード改善ガイド」、「アジャイルな見積もりと計画づくり」、「エンジニアのためのマネジメントキャリアパス」がためになりました。

## 趣味プロジェクトのこと

業務の外で味のプログラミングをしておりますが、どんな腹積もりでやっているかを書いてみます。
自分のソフトウェアエンジニアとしてのスキルはどのようなものかを振り返ってみると、抜け穂が多いなーと感じました。
SIerのエンジニア職でC#・PHPを触っており、職種としてはサーバーサイドからWEBフロントエンジニアの中間あたりにいるはずです。
だけど、だからといってあまり体型だったスキルを持っているとは言えないんじゃないかと思っています。

- 一から運用サーバの構築をした経験が乏しい
    - 社内Redmine/gitoliteサーバのリプレイスで構築しなおすみたいなことはしたけど、売上の発生する本業ではない
- 複雑なSQLのDML文をゴリゴリ書くのは好きだけどforeign key制約のあるデータベースを扱ったことがない
    - 業務は回せても汎用的なスキルとしては育っていないんじゃ？
- 一通り作れるといってもデザインから画面イメージを1から起こせる自信がない
    - html/cssあたりにノウハウが足りない

この辺を自分の弱点だと感じていたので、趣味プロジェクトでいろいろやっていました。
自分の方向性、趣味としては、ビジネスロジックを考えたりユニットテストを作りこむのは好きだがサーバーの面倒はなるべく見たくない。
ユーザの体験に直結するUI/UXは作ってみたいが、iOS/androidのネイティブ開発にwebで汎用的にフロントエンドを作るほうが時間投資の優先度が高い。
突き詰めると自分が向いてる・実際にやりたいのは職種でいうとサーバーサイドよりのwebフロントエンドなのかなあと考えました。
そのようなことをつらつら考えつつ以下のようなことをやってきました。

- Vue.js/Firebaseを使ってマークダウンアプリを作った

以前ブログ投稿したのですが、これはwebフロントエンドの流行を追いかけてみたいモチベーションでやってみました。

記事: [yysaki blog - #Webサービスを作る本 を読んで簡易markdownエディタを作った](https://www.yysaki.com/blog/2018/09/30/vue-firebase-tutorial/)

[このURL](https://mymarkdown-e7d15.firebaseapp.com/) で稼働中です。

- Firebase/Nuxt.jsで趣味プロジェクトをリプレースした

数年前にheroku・jQuery Mobile・node jsといった構成で作ったモバイルアプリがあったのですが、今度はNuxt.jsを触ってみたかったのでFirebaseでホストするNuxt.jsのSSRアプリとしてリプレースしました。
こちら [このURL](https://shikibetsuhyo.yysaki.com) で稼働中です。
[一部Qiita記事](https://qiita.com/yysaki/items/aa699ac02ad1875f9b21)に切り出しているのですが、開発に飽きたのでそのうちまとめ記事を書こうかと思ってます。

- Rails1000時間メニューに入門

FirebaseはNoSQLとして構築が簡単でいいのですが・先程挙げた弱点の克服にweb api、DBを体系立てて学ぶのにはRuby on Railsがちょうどいいと思います。
golangやPHPのLarabelなど選択肢はいくつもありますが、人生初めて触ったLL言語がRubyのため、Rubyに個人的に思い入れがあります。
簡単なRailsアプリを作ったことはありますが業務でやったことがないので、何が不足してるかわからん、みたいな状態です。
そんなところで [未経験からRuby on Railsを学んで仕事につなげるまでの1000時間メニュー - Qiita](https://qiita.com/saboyutaka/items/1a8c40e105e93ac6856a) という記事を見かけました。
どこが抜けてるか試すのにちょうどいいので初心者向けすぎてマッチしてないと感じる箇所はスキップしつつ、このコースを走っているのが今ココです。

あとはそうですね、vimの活動として [Vimconf2018](https://vimconf.org/2018/) に参加したり、 [Vim Advent Calendar 2018 その2 に記事を投稿したり](https://qiita.com/yysaki/items/fb1cbca8933c6080ebb6) しました。
今年は参加記事を書いておらず恐縮ですが、vimのautherであるBram Moolenaar氏のKeynoteが直に聞けたのは最高でした。

## 新年の抱負

さて、新年の抱負としては、以下のようなことをしてみたいと思っています。

- 1年間で100冊本を読む

昨年達成できなかったので再度目標にしたいと思います。

- rubykaigiに参加する

福岡なので遠いなあと思っていたのですが、会社支援のもと参加できることになりました。
以前参加したrubykaigi 2015は自費+有給使用でしたので福利厚生が増したのを感じます。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">RubyKaigi申し込んだ<br>会社支援のもと参加できるのありがたい</p>&mdash; sasaki (@yysaki) <a href="https://twitter.com/yysaki/status/1078224873867010048?ref_src=twsrc%5Etfw">2018年12月27日</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

- メンタルヘルスマネジメント検定を受ける

メンタルに自信のない、ちょうどいい資格試験があるのを教わりました。

[メンタルヘルス・マネジメント検定試験,検定,試験,メンタル,大阪商工会議所](https://www.mental-health.ne.jp/)

ひとまずⅢ種 セルフケアコース の公式テキストを取り寄せて読んでいます。
これの資格取得を含め、学習していきたいところです。
