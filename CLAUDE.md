# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## 言語設定

**このリポジトリでは日本語でやりとりしてください。**

## 概要

Nanoc（Ruby製静的サイトジェネレーター）とwebpackでアセットをバンドルした個人ブログです。GitHub Actionsを通じてGitHub Pagesにデプロイされます。

## ビルドコマンド

### フルビルド
```bash
make build
# または手動で:
bundle exec nanoc && npm run build
```

これは以下の両方を実行します:
1. `bundle exec nanoc` - markdownの投稿とERBテンプレートからHTMLを生成
2. `npm run build` - webpackでCSS/SCSSをバンドル

### 開発サーバー
```bash
make dev
# または:
bundle exec nanoc view -o 0.0.0.0
```

ローカルサーバー（デフォルトポート3000）を起動し、サイトをプレビューします。

### リント
```bash
make lint
# または:
bundle exec rubocop
```

### 新規投稿の作成
```bash
make new
# または:
bundle exec rake new
```

`content/posts/` に現在日付とデフォルトのfrontmatterを含む新規投稿テンプレートを作成します。

## アーキテクチャ

### ビルドパイプライン

1. **Nanocコンパイル** (`bundle exec nanoc`):
   - `content/posts/` 内のmarkdownファイルをkramdown（GFMサポート）で処理
   - `layouts/` のレイアウト（ERBテンプレート）を適用
   - HTMLを `output/` ディレクトリに出力
   - `static/` 内の静的ファイルは出力ルートに直接コピー

2. **Webpackバンドル** (`npm run build`):
   - エントリーポイント: `src/index.js`
   - SCSSファイルをsass-loader、css-loader、style-loaderで処理
   - `main.js` を `output/` に出力

### 投稿のURL構造

投稿のファイル名は次のパターンに従います: `YYYY-MM-DD-title-slug.md`

`post_url` ヘルパー (lib/post_url.rb:3-10) はこれをURLパスに変換します:
- ファイル名: `2025-12-23-aws-saa-c03.md`
- URL: `/blog/2025/12/23/aws-saa-c03/`
- ファイル出力: `/blog/2025/12/23/aws-saa-c03/index.html`

### コンパイルルール (Rulesファイル)

- `/index.*` - 2回コンパイル: `/index.html` と `/blog/index.html` 用
- `/posts/**/*` - Kramdownフィルター → articleレイアウト → defaultレイアウト
- `/atom.*` - AtomフィードのためのERBフィルター
- `/static/**/*` - 出力ルートにそのままコピー

### ヘルパー関数 (lib/)

- `articles` (lib/articles.rb:3-8) - 識別子でソートされた全投稿を返す（新しい順）
- `post_url` (lib/post_url.rb:3-10) - 日付プレフィックス付きファイル名からURLを生成
- `published_at` (lib/published_at.rb:3-6) - ファイル名から日付を抽出
- Nanocヘルパー（Blogging、Rendering）はlib/helpers.rbにインクルード

### デプロイ

GitHub Actionsワークフロー (.github/workflows/deploy.yml) が `main` へのpush時に実行されます:
1. Ruby 2.7.2とNode 24.11.0をインストール
2. フルビルド（nanoc + webpack）を実行
3. `output/` ディレクトリを `master` ブランチ（GitHub Pages）にデプロイ

注意: このリポジトリは開発に `main` を、公開サイトに `master` を使用しています。

## 設定

- **nanoc.yaml** - Nanocの設定（出力ディレクトリ、データソース、デプロイ設定を含む）
- **webpack.config.js** - SCSS処理のためのWebpack設定
- **Gemfile** - Ruby依存関係（nanoc、kramdownなど）
- **package.json** - Node依存関係（webpack、sass-loader、Foundation Sites、jQueryなど）

## 投稿のFrontmatter

新規投稿には以下のfrontmatter構造を含めてください:
```yaml
---
layout: post
title: タイトル
date: YYYY-MM-DD HH:MM:SS +0900
created_at: YYYY-MM-DD HH:MM:SS +0900
kind: articles
comments: true
categories:
  - blog
---
```
