---
layout: post
title: "ブログのHTTPS化および開発環境整備"
created_at: 2017-11-05
kind: article
date: 2018-08-12 19:00:00 +0900
comments: true
categories:
  - blog
  - nanoc
  - docker
---

最近 [草を生やす技術 #mydev // Speaker Deck](https://speakerdeck.com/rhysd/cao-wosheng-yasuji-shu-number-mydev) のスライドを読み直して, このブログや昔作った小さなwebアプリの整備をしてgithubの草を生やしております.
最近の進捗はプライベートリポジトリを含むとこんな感じ, 欠ける日もありますが2週間以上は続いてます.

![草の様子](/images/kusa_20180812.png)

ブログ整備がひと段落したので, 作業内容をメモします.

<!-- more -->

## nanocの更新

このサイトは [nanoc](https://nanoc.ws/) というRubyの静的サイトジェネレータを使用していますが, 使用バージョンが古かったので最新版に上げました.
当時の3.7.3から4系 への更新にはいくつかの修正箇所があり,  公式のアップグレードガイドに従いコツコツと修正しました.
[Nanoc » Nanoc 4 upgrade guide](https://nanoc.ws/doc/nanoc-4-upgrade-guide/)

## HTTPS化

次に, このサイトはHTTPSを設定していなかったのですが, Chrome 68 で常時SSLでないと警告が出るようになってしまった昨今なので, ついでに対応しました.
幸い, ホストしているGithub Pagesは2018年5月からHTTPSの配信をサポートしています.

[Custom domains on GitHub Pages gain support for HTTPS](https://blog.github.com/2018-05-01-github-pages-custom-domains-https/)

SSL証明書を別途取得する必要もなく, 手順に従いGithubのページとドメインを管理しているお名前.comの設定を画面上で操作するだけで設定が完了しました.
ただ, ブログのレイアウトには [Booklog](https://booklog.jp/) さんのwidgetを埋め込んでいたのですが, 残念ながらこちらはHTTPS未対応です.
HTTPS対応予定もなさそうなのでブログから取り外しまして, 晴れてHTTPS化となりました🎉

![https化](/images/https_badge.png)

## 開発環境のDocker化

最後に, ブログを書くたびに環境設定方法を忘れてしまうので, nanocをビルドする環境をdockerにしました.
これは [こちらの Docker Hub](https://hub.docker.com/r/yysaki/nanoc/) に公開しています.
ホストOS側にclonseしてあるブログのリポジトリをマウントしておき,  docker上で `bundle exec nanoc` コマンドでビルドしたりGithub Pagesにデプロイしたりできるようにしています.
秘密鍵をdocker imagesに含めたくないけどdocker上で認証の必要な操作がしたいどうしたものかと思いましたが, 秘密鍵自体もmountしてしまえばよいのだと気づきました.
今ではついでに.gitconfigも加えて,

```
docker run -i -t -v ~/repositories/blog:/blog -v ~/.gitconfig:/root/.gitconfig -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -p 8080:3000 yysaki/nanoc /bin/bash
```

を打ち込んでbashにアクセスしています.

### dockerからのプレビュー

dockerに環境を移して少しハマったのは, nanocのプレビューのURL.
`bundle exec nanoc` コマンドで立ち上がるWEBrickのURLはループバック・アドレスを使う http://127.0.0.1:3000/ となります.
ゲストOSの外からアクセスできるようにするには, 以下のようにデフォルトルートアドレスを指定してあげる必要があります:

```
bundle exec nanoc view -o 0.0.0.0
```


## まとめ

以上です.
一度dockerイメージを作成してしまえば次の環境での構築の手間がゼロになるので素晴らしい.
