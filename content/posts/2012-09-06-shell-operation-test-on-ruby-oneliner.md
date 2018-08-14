---
title: 『シェル操作課題 』をRubyのワンライナーで解いてみた
created_at: 2012-09-06
kind: article
author: yysaki
layout: post
categories:
  - プログラミング
tags:
  - Ruby
  - プログラミング
---
[シェル操作課題 (cut, sort, uniq などで集計を行う) 設問編][1] の記事にある設問を遅ればせながら解いてみました。

Rubyの勉強中だったので、全問をRubyのワンライナーのみでやります。
Rubyのversionは1.9.3, 入力ファイル名を"data"とします。

### 問1

``` bash
ruby -pe '' data
```

-eオプションでスクリプトモード, -pオプションで `while gets{/\* code \*/ puts $_}` としてコード片を実行する。

この場合 コード片は空なのでファイルを一列ずつputsするのみです。

### 問2

``` bash
ruby -F, -ane 'puts "#{$F[0]},#{$F[3]}"' data
```

-n オプションは-p の `puts $_` を削ったもの。

-aは"auto aplit"の頭文字、`$_.split`の結果が配列として$F変数に代入される。

-F オプションで区切り文字を指定する。これは文字列でも正規表現でもOK

### 問3

``` bash
ruby -F, -ane 'puts $_ if $F[0]=="server4"' data
```

### 問4

``` bash
ruby -ne 'i||=0; i+=1; END{ puts i }' data
```

注目は`||=`演算子とENDキーワードの二つ。

`||=`はループ文の中で値を初期化する際便利な、今回調べて一番便利だと感じたイディオムでした。

上の式の場合`i = i || 0`と解釈され、iにはiが未代入の時のみ0を代入され、それ以外の時は自身を代入する。

また、ENDブロック内のコードはwhileループの終了後に実行されるため、-nオプションを使ってる場合でもwhile外部での制御が行える。

### 問5

``` bash
ruby -F, -ane 'a ||= \[]; a << $F; END{a.sort{|x, y| x[0]!=y[0] ? x[0] <=> y[0] : x[2].to\_i <=> y[2].to\_i}.[\](0,5).each{|b| puts "#{b[0]},#{b[1]},#{b[2]},#{b[3]}"} }' data
```

sortの判定方法をイテレータ用のブロックで指定する記法はRubyならではでおもしろかったです。

この辺からセミコロンが増えて、ワンライナーというには少し苦しいかも。

### 問6

``` bash
ruby -ne 'a ||= []; a << $_ unless a.index($_); END{ puts a.size }' data
```

### 問7

``` bash
ruby -F, -ane 'a ||= []; a << $F[2] unless a.index($F[2]); END{ puts a.size }' data
```

### 問8

``` bash
ruby -F, -ane 'h ||= {}; h.default = 0; h\[$F[3]] += 1; END{ a = h.to_a.sort{|x, y| y[1] <=> x[1]}.[\](0); puts "#{a[1]} #{a[0]}" }' data
```

Hashオブジェクトはdefault属性を設定することで初期値を設定できる。

### 問9

``` bash
ruby -F, -ane 'h ||= {}; h.default = 0; h[$F[0].gsub(/server/, "xxx")] += 1; END{ h.to_a.sort{|x, y| x[0] <=> y[0]}.each{|l, r| puts "#{r} #{l}"} }' data
```

### 問10

``` bash
ruby -F, -ane 'a ||= []; n = $F[2].to_i; a << n if (n>=10) && (not a.index(n)); END{ a.sort!; puts a }' data
```

&nbsp;

&nbsp;

以上。

sed, awkなどunix伝統の文字列処理に慣れてないので、スクリプト言語一つ勉強しておくだけでこういった処理が書けるのはいいですね

 [1]: http://d.hatena.ne.jp/Yamashiro0217/20120727/1343371036
