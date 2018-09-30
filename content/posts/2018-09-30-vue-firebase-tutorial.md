---
layout: post
title: "#Webサービスを作る本 を読んで簡易markdownエディタを作った"
created_at: 2018-09-30
kind: article
date: 2018-09-30 19:00:00 +0900
comments: true
categories:
  - firebase
  - javascript
  - vue
---

[@nabetu](https://twitter.com/nabettu) さんの執筆した [Vue.jsとFirebaseで作るミニWebサービス (技術書典シリーズ(NextPublishing))](http://www.amazon.co.jp/exec/obidos/ASIN/4844398350/tatsuakiw-22/) の手順を写経してFirebase上で動く簡単なmarkdownディターのアプリを作成しました。 [こちらのURL](https://mymarkdown-e7d15.firebaseapp.com/) で実際に稼働中です。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/Web%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E3%82%8B%E6%9C%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Webサービスを作る本</a> 1周目終了。<br>UIの手入れすっ飛ばしたので週末vuetifyで遊んで設定してから強くてニューゲーム行きます。<br>DBは本書使用のRealtime DatabaseでなくCloud Firestoreを採用したので、設定の違いなどをブログ記事に起こすかも。<a href="https://t.co/l903YvwWbL">https://t.co/l903YvwWbL</a></p>&mdash; sasaki (@yysaki) <a href="https://twitter.com/yysaki/status/1034464372041515008?ref_src=twsrc%5Etfw">August 28, 2018</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

このtweetからもある程度作業を進め、自分の中で修正の区切りがついたので記事をまとめます。
なお、作成したwebサービスのソースコードは[github](https://github.com/yysaki/mymarkdown) に公開しています。

<!-- more -->

## 前置き

本書はタイトルの通り, Vue.jsとFirebaseを使ってSPAなWebサービスを実際に作ってみるために必要なことがまとめられた本です。
私は普段の業務では双方触らないものの、強い興味があって手っ取り早く学習してみたかったためkindle版を購入しました。

Firebaseは別の趣味プロジェクトでホスティングサービスであるところのFirebase Hosting、およびexpress js を走らせるためのFirebase Cloud Functionを使ったことはあったのですが、NoSQLのRealtime Databaseや Cloud Firestoreは使ったことがありませんでした。
Vue.jsについては全くの新規です。前知識としてはReactに並ぶ仮想DOMを使ったフロントエンドフレームワーク、というような大雑把な理解しかありませんでした。
日本人ソフトウェアエンジニア界隈で流行が始まっている気配を感じていたので、これを機会に学ぼうというところです。

## 1周目

本編はVue.jsおよびFirebase Realtime Databaseを使って動くmarkdownエディタを作成していきます。文章を読んでコードを写経すればほぼ問題なく進められました。
僕が見た時点ではファイルパスなどの誤植がいくつかありますが、 [著者のサポートリポジトリ](https://github.com/nabettu/mymarkdown) にまとめられているのでつまづくことはありませんでした。
また、ロゴの簡単な作り方や利用規約・プライバシーポリシーの書き方が説明されており、大事な部分だなと勉強になりました。
結局ロゴの作成はサボってしまったのですが、次自分のサービスを作るときにはすぐ作成できる安心感が手に入りました。

## Firebase

本編ではRealtime Databaseを使ったやり方が紹介されてますが、どちらかというと現在β版であるFirestoreが使って見たかったので、あえて後者を試しました。
これには多少苦戦して、最終的に以下の記述をして対処しました。
[githubでいうとこの辺です。](https://github.com/yysaki/mymarkdown/commit/5d89a7c7cea411c76ed6ca960c42f9a780dfc8c3)

Firestore ルール:
``` txt
service cloud.firestore {
  match /databases/{database}/documents {
    match /memos/{userId} {
      allow read, write: if request.auth.uid == userId;    
    }
  }
}
```

created:
``` javascript
created: function() {
  var self = this;
  firebase
    .firestore()
    .collection('memos')
    .doc(this.user.uid)
    .get()
    .then(function(doc) {
      if (doc.exists) {
        self.memos = doc.data().val;
      }
    });
},
```

saveMemos:
``` javascript
saveMemos: function() {
  firebase
    .firestore()
    .collection('memos')
    .doc(this.user.uid)
    .set({val: this.memos});
},
```

今イチからやるのであれば [Firestore 移行マニュアル](https://github.com/nabettu/firestore-manual) が公開してくださっているのでそちらを参考にするとよいと思います。

## 強くてニューゲーム・ちょい足しポイント

本書はシンプルなmarkdownエディタを作る手順が載っているんですが、追加お題の随所に散りばめられた「ちょい足しポイント」や巻末の初心者や中級者向けに出題された「強くてニューゲーム」があります。
私は全体の半分程度手を出したのですが、それぞれやりごたえがありました。
実際にやったうちいくつか例をあげると、

ちょい足しポイント:
* デプロイにCIを使う。
* 状態管理にVuexを使用する。
* Vuetifyを使ってマテリアルデザインのサイトにする

強くてニューゲーム:
* ナビゲーションバーの追加
* マークダウンでチェックボックスを表示できるようにする
* ログイン時に表示までLoadingを入れる
* セーブ中はセーブボタンがローディングする(ローディング中は押せない)

などです。

その際Vue.jsやライブラリであるVuex, Vue Router, Vuetify.jsの公式ドキュメントを読んだのですが、ドキュメントが充実しているのに驚きました。
ほとんどが日本語訳されているし、サンプルコードにcodepenへのリンクがあり実際にスクラッチして試せるのです。
特にCSSのflexboxに不慣れだったのですが、Vuetify.jsの [Grid system](https://vuetifyjs.com/en/layout/grid) を何度も読み書きしてなんとかまともに動くものが作れるまでになりました。

また、 [著者のリポジトリ](https://github.com/nabettu/mymarkdown/tree/feature/add-design) に強くてニューゲームのサンプルがあったので何度も参考になりました。

## 感想

この本を読んで写経することで手軽にwebサービスが作れる成功体験が得られました。
特にFirebaseは無料のプランで満足できるものが始められるので初動が気楽です。
また、社内slackに公開したURLを貼って見せるとフィードバックが得られ、typoを次々見つけてもらって面白かったということもありました。


以上です。
