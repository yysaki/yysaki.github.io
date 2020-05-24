---
layout: post
title: "Terraform RegistryのModuleを使ってHasuraを立てる"
date: 2020-06-07
created_at: 2019-06-07 12:00:00 +0900
kind: articles
comments: true
categories:
  - blog
  - terraform
---

Terraformの素振りのため、公開されているModuleを使ってAWS ECSクラスター上にHasuraを立ててみました.
Auth0での認証認可まで疎通確認できたので手順を共有します.

## 概要

[Hasura](https://hasura.io/) について軽く説明をすると, これはPostgreSQLをバックエンドとしてAPIを自動生成してくれるGraphQLサーバーです. DBスキーマからとりうるCRUD操作をAPI越しに一通り行うことができるようにしてくれます. また、ロールベースの権限付与の仕組みをサポートしており、 [Auth0](https://auth0.com/jp/) といったOAuthサービスプロバイダーと組み合わせることで、Hasura外部のサービスで認証を行ったユーザの認可から, ロールに許されたAPI操作を割り振ることができます。
Hasuraのサービスを稼働させるためにはHerokuが推奨されていますが、あえてAWSで立てようとするなら [docker hubに提供されているDockerイメージ](https://hub.docker.com/r/hasura/graphql-engine) とデータストアであるPostgreSQLを構築する必要から、ECSを使うのが自然な選択肢になるかと思います. ちょうどTerraformでAWSの環境構築をする練習りをしたかったこともあり [Hasura](https://hasura.io/)を立てるのがお題として手頃そうでした.
一方、Terraform Registryを"hasura"で検索してみると3件ほどマッチしました。 このうちメンテナンスされておりdownload数の多い [Rayraegah/hasura/aws](https://registry.terraform.io/modules/Rayraegah/hasura/aws/3.0.2) があります.  ライセンスのところに [Gordon Johnston](https://github.com/elgordino) により提案されたAWSアーキテクチャを採用しているとあります, おそらく以下の記事のことと見られます.

[Deploying Hasura on AWS with Fargate, RDS and Terraform - DEV](https://dev.to/lineup-ninja/deploying-hasura-on-aws-with-fargate-rds-and-terraform-4gk7)

今回はこちらをお借りしてTerraformを素振りさせてもらいました.

## 事前準備

今回の手順を行うにあたって必要な準備は以下の通りです:

- Terraform 0.12 の実行環境
- AWSアカウント
  - IAMユーザ
  - Route53で管理されているドメイン
- Auth0アカウント
- [GraphiQL.app](https://www.electronjs.org/apps/graphiql) の実行環境
  - macos Homebrewであれば `brew cask install graphiql` しておく

この記事ではそれぞれのセットアップについては述べません.

## Auth0の設定

まず, Auth0について [Hasuraの公式ドキュメント](https://hasura.io/docs/1.0/graphql/manual/guides/integrations/auth0-jwt.html) を参考に事前にSingle Page Applicationを用意しておきます. Hasuraの認証認可の仕組みをこちらで整えることになります.  手順の通りなのですが, ハマりどころとして2点補足しておきます.

一つ目はRulesです. "Configure Auth0 Rules & Callback URLs"の手順にてJWTカスタムクレームを埋め込むためのスニペットが2通り記載されています. 厳密にはどちらでも構いませんが, この手順では前者のauth0.js向けのスニペットを入力してください. 2つ目は [OIDC Conformantを無効にする](https://auth0.com/docs/api-auth/tutorials/adoption/oidc-conformant) ということです. "Test auth0 login and generate sample JWTs for testing" の手順でid_tokenを取得しますが, これを無効にしておかないとコールバック時にエラーとなります.

## TerraformのApply

手元の実行環境のお好きなディレクトリ配下に, Terraformのapplyのためmoduleの呼び出しを行う `main.tf` および変数定義を行う `terraform.tfvars` を用意しました.
[gist](https://gist.github.com/yysaki/ad8396547b9fc1f14865d1b554bd24b7)に貼ってありますが、それぞれ以下の通りです:

まず, main.tf:

``` terraform
variable "domain" {}
variable "hasura_admin_secret" {}
variable "rds_password" {}
variable "hasura_jwt_secret_key" {}

module "hasura" {
  source                         = "Rayraegah/hasura/aws"
  version                        = "3.0.2"
  domain                         = var.domain
  hasura_version_tag             = "v1.2.1"
  hasura_admin_secret            = var.hasura_admin_secret
  hasura_jwt_secret_key          = var.hasura_jwt_secret_key
  hasura_jwt_secret_algo         = "RS256"
  rds_db_name                    = "hasura"
  rds_instance                   = "db.t3.small"
  rds_username                   = "hasura"
  rds_password                   = var.rds_password
  create_iam_service_linked_role = false
}

provider "aws" {
  region = "ap-northeast-1"
}
```

module "hasura"になるべくdefault値を使ったうえで必要な変数定義をしています. 秘密情報にしたかったものはvariableに切り出してtfvarsにて記述することにしました. defaultを上書きした変数は3箇所あります. 1つ目は `hasura_version_tag` , これは単純に執筆時点の最新版を使いたかったためです. 2つ目は `hasura_jwt_secret_algo` , こちらにはHS256 または RS256が選べますが, Auth0で使用するのは後者のため設定しました. 最後にcreate_iam_service_linked_role, これはAWSのアカウント上で初めてECSを作成したときに勝手に作られる [service_linked_role](https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/using-service-linked-roles.html) の有無についてです. 私の環境では以前にECSクラスターを作ったことがあるためfalseにしましたが, この操作が初めての場合defaultのtrueとしておきましょう.

次に, terraform.tfvars:

``` txt
domain                = "example.com"
hasura_admin_secret   = "Password"
rds_password          = "Password"
hasura_jwt_secret_key = <<EOF
-----BEGIN CERTIFICATE-----
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxx
-----END CERTIFICATE-----
EOF
```

これにはvariableで定義した変数を指定しています. 1つ目の `domain` にはRoute53で管理しているdomainを指定してください. 続く `hasura_admin_secret` `rds_password` には, 前者はHasura管理画面の、 後者はRDSのパスワードになります. 最後の `hasura_jwt_secret_key` には先のAuth0の設定後に得られる公開鍵情報を入力します. `https://<your-auth0-domain>.auth0.com/pem` にアクセスすることで取得できます.

以上で設定が完了です. 作業したディレクトリ上で `terraform init`, `terraform plan`, `terraform apply` を実行しましょう.

##  Hasuraコンソールにログインする

上記が無事成功したことを確認するために, ブラウザから `https://hasura.<あなたのdomain>` にアクセスしましょう. Hasuraのパスワード入力画面が出ますので, `hasura_admin_secret` を入力してください. 
Hasuraの管理画面が開くはずです.

Hasuraのコンソール画面から, テーブル定義およびそれのuserへのpermissionをしたとします. コンソール上でポチポチ操作するだけでOKで, これによりDBマイグレーションなどのメタデータ設定が簡単に行えます. 私の環境では `users` と `posts` テーブルを一対多の関係で定義、`user` ロールにそれぞれのテーブルへのSELECT権限の付与を行いました. 

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">hasuraが立ったので雑なテーブル定義 <a href="https://t.co/jiOcOHCasZ">pic.twitter.com/jiOcOHCasZ</a></p>&mdash; sasaki (@yysaki) <a href="https://twitter.com/yysaki/status/1264112622816735232?ref_src=twsrc%5Etfw">May 23, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## GraphQL APIの操作

これまでの設定がうまくいったことを確認するために, GraphQL APIを触ってみたいと思います. 手順としてはGraphiQL.app を起動します. アプリが起動したら `GraphQL Endpoint`に `https://hasura.<あなたのdomain>/v1/graphql` を入力します. 次に `Edit HTTP Headers` をクリックし, `Add Header` からHeader nameに`Authorization`, Header valueに `Bearer <id_token>` を入力します. このid_tokenは "Test auth0 login and generate sample JWTs for testing"で取得したものになります. これでトップ画面に戻るとうまくいった場合Document Explorer > ROOT TYPES に利用可能なqueryがリストアップされます. これでHasuraから認証認可を踏まえたGraphQLのndpointが得られました.

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Auth0認可も通ったのでOK <a href="https://t.co/6TaN17mIqU">pic.twitter.com/6TaN17mIqU</a></p>&mdash; sasaki (@yysaki) <a href="https://twitter.com/yysaki/status/1264122926783066112?ref_src=twsrc%5Etfw">May 23, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## 後始末

満足できるまで確認ができたら, 課金対象ですので AWSリソース を削除しましょう.  ただし, 安全のためaws_db_instanceのlife_cycleが `prevent_destroy = true` となっているため, 単に`terraform destroy` をしても成功しません. workaroundとして, main.tf 中のmodule定義をすべてコメントアウトして `terraform apply` を行ってから `terraform destroy` をすることでリソースの削除に成功します.

## まとめ

以上で, terraformのmoduleを使わせてもらったAWSでのhasuraの構築の素振りを行いました. 素振りをやろうとした当初はイチからtfファイルを書く気持ちでいたのですが, 先人の肩を借りて手数少なく実施することができました. まじまじとregistryに公開されているmoduleを読むのは初めてでしたが, ためになります.
