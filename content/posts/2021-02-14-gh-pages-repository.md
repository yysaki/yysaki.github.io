---
layout: post
title: "blogのリポジトリ運用の変更"
date: 2021-02-14 16:51:02 +0900
created_at: 2021-02-14 16:51:02 +0900
kind: articles
comments: true
categories:
  - blog
---

このブログはGithub Pagesでホストしているのだけど、ソースコードをprivateにするため公開用とリポジトリを2つに分けていて、久しぶりに触ると運用方針を思い出すところから始まり認知的負荷がかかる。
privateにしていたものも隠すような秘匿情報を扱っているわけではないので、公開用リポジトリ側に寄せて1つにまとめてみた。
GitHub Actionsでのdeployの動作確認を兼ねて記事を投稿しておきます。

## やったこと

以下の2つのリポジトリがあったところを、前者に寄せた:

- 公開用リポジトリ: yysaki/yysaki.github.io
- ソースコード用リポジトリ: yysaki/nanoc-blog(privateリポジトリ)

それぞれmaster branchで運用していたが、ソースコードを前者のmasterに、公開用を `gh-pages` branchに移動した。
また、この際 `actions-gh-pages` の設定をいじる必要があり、以下のように変更した:

- 修正前

```
- name: Deploy
  uses: peaceiris/actions-gh-pages@v3
  with:
    deploy_key: ${{ secrets.ACTIONS_DEPLOY_KEY }}
    external_repository: yysaki/yysaki.github.io
    publish_branch: master
    publish_dir: ./output
```

- 修正後

```
- name: Deploy
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./output
```

設定が簡素になりいいことだ。
