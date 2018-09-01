---
layout: post
title: "#Webサービスを作る本 をCloud FireStoreで写経した"
created_at: 2018-09-01
kind: article
date: 2018-09-01 19:00:00 +0900
comments: true
categories:
  - vue
  - javascript
  - firebase
---

先日、 [Vue.jsとFirebaseで作るミニWebサービス (技術書典シリーズ（NextPublishing）]() の手順を写経してfirebase上で動く簡単なmarkdownディターのアプリを作成し、強くてニューゲームの応用問題に対応中です。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/Web%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E3%82%8B%E6%9C%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Webサービスを作る本</a> 1周目終了。<br>UIの手入れすっ飛ばしたので週末vuetifyで遊んで設定してから強くてニューゲーム行きます。<br>DBは本書使用のRealtime DatabaseでなくCloud Firestoreを採用したので、設定の違いなどをブログ記事に起こすかも。<a href="https://t.co/l903YvwWbL">https://t.co/l903YvwWbL</a></p>&mdash; sasaki (@yysaki) <a href="https://twitter.com/yysaki/status/1034464372041515008?ref_src=twsrc%5Etfw">August 28, 2018</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

手順ではDBに Realtime Database が採用されていますが、今回は折角なのでRealtime Databaseの後継であるCloud Firestoreを使いました。
どうすれば Cloud Firestoreに置き換えられるか、差分を記載しようと思います。

<!-- more -->

## 今回やったこと

## Firestoreの設定

## コードの比較

firestore:

vue.js:
``` vue
```

## まとめ

以上です.
一度dockerイメージを作成してしまえば次の環境での構築の手間がゼロになるので素晴らしい.
