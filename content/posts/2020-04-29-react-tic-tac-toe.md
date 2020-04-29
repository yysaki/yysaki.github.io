---
layout: post
title: "Reactのチュートリアルで三目並べ"
date: 2020-04-29
created_at: 2019-04-14 23:00:00 +0900
kind: articles
comments: true
categories:
  - blog
  - react
---

Reactのチュートリアルにある、三目並べを書いて動かしてみました.
しばらくこっちのブログを書いていなかったので、準備運動てきにブログを更新します.

<!-- more -->

### やったこと

Reactの公式ドキュメントにある[チュートリアル：React の導入 – React](https://ja.reactjs.org/tutorial/tutorial.html) に従い、三目並べ(tic-tac-toe)を書いてみました.
動作例は以下の通り:

<p class="codepen" data-height="300" data-theme-id="light" data-default-tab="js,result" data-user="yysaki" data-slug-hash="WNQEbGg" style="height: 265px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;" data-pen-title="react-tic-tac-toe">
  <span>See the Pen <a href="https://codepen.io/yysaki/pen/WNQEbGg">
  react-tic-tac-toe</a> by yysaki (<a href="https://codepen.io/yysaki">@yysaki</a>)
  on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### 感想

感想としては、素朴なreactの構造を動かしながらpropsやコンポーネントの概念が把握できました.
公式ドキュメントが日本語訳されており、とてもとっつきやすく感じました.

また, https://github.com/yysaki/react-tic-tac-toe リポジトリを作ってこの上で一通り作業していました.
これはこれで create-react-app を使って `npm run start` できる状態を作る経験になったのですが、
作業内容自体js 1ファイルのsnippetにに収まること, 動くサンプルをblogにかんたんに貼れると気づいたことから、
codepenに途中から移行しました.
手を動かして実験してみたいがリポジトリを作るほどでもないなーというものに対して使っていきたいと思います.
