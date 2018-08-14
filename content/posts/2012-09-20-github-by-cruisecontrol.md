---
title: GithubのプロジェクトをCruiseControlで自動ビルドしてみた
created_at: 2012-09-20
kind: article
author: yysaki
layout: post
categories:
  - プログラミング
tags:
  - CruiseControl
  - Java
---
[達人プログラマー―ソフトウェア開発に不可欠な基礎知識 バージョン管理/ユニットテスト/自動化][1] に触発されて、Javaプロジェクトの自動テストにチャレンジしました。

![ダッシュボード](/images/CC_dashboard.png)

継続的インテグレーションツールである[Cruisecontrol][3](以下CC)を使って、 GitHub上のプロジェクトを自動ビルドしてみます。

今回の環境は、マシンをUbuntu 10.04.4 LTS, CCを[cruisecontrol-bin-2.8.4.zip][4]、ビルドターゲットを僕の作った[MyJavaTetris][5]とします。

目標はソフトウェア開発に役立てるというよりもCCを回すことであるので、手段と目的が逆になっている気もしますがこれも勉強の一つです。

ちなみに上の画像は、CCのdashboardで実際に表示されるページのスクリーンショットです。

<div>
</div>

<div>
  以下手順です。
</div>

本書の手順にあるスクリプトの情報は古く動作しなかったため、[公式HPのGettingStarted][6]を参考にしました。

<div>
  <h1>
    CCのインストール
  </h1>
</div>

<div>
</div>

<div>
</div>

<div>
  CCをインストールして/opt/cruisecontrol/ に配置します。
</div>

<div>
</div>

> wget http://jaist.dl.sourceforge.net/project/cruisecontrol/CruiseControl/2.8.4/cruisecontrol-bin-2.8.4.zip
> 
> unzip cruisecontrol-bin-2.8.4.zip
> 
> mv cruisecontrol-bin-2.8.4 /opt/cruisecontrol/

<div>
</div>

<div>
  ついでに.bashrcにPATHを通しておきます。
</div>

<div>
</div>

> <div>
>   echo &#8220;export PATH=$PATH:/opt/cruisecontrol&#8221; >> ~/.bashrc
> </div>
> 
> <div>
>   source ~/.bashrc
> </div>

<div>
</div>

<div>
  この手順の後、カレントディレクトリを/opt/cruisecontrol/に指定してcruisecontrol.shを実行することでCCの動作確認ができます。
</div>

<div>
</div>

<div>
</div>

# Githubプロジェクトの設定

<div>
</div>

<div>
</div>

<div>
  続いて自分のGitHubプロジェクトをCCのビルドループに追加する手順です。
</div>

<div>
  今回、作業ディレクトリを /work/cc/に置くこととして、必要なディレクトリを作成していきます。
</div>

<div>
</div>

> <div>
>   cd /work/cc
> </div>
> 
> <div>
>   mkdir projects artifacts logs
> </div>

<div>
</div>

<div>
  次に、/work/cc/下に必要なスクリプトを二つ作成します。
</div>

<div>
  一つ目はconfig.xmlです。このファイルによってCCのビルドループが設定されます。
</div>

<div>
    <pre class="brush: xml; title: ; notranslate" title="">
&lt;cruisecontrol&gt;
  &lt;project name="MyJavaTetris" buildafterfailed="true"&gt;
    &lt;listeners&gt;
      &lt;currentbuildstatuslistener
        file="logs/MyJavaTetris/status.txt"/&gt;
    &lt;/listeners&gt;

    &lt;!-- Bootstrappers are run every time the build runs,
                                                 *before* the modification checks --&gt;
    &lt;bootstrappers&gt;
    &lt;/bootstrappers&gt;

    &lt;!-- Defines where CruiseControl looks for changes, to decide
                            whether to run the build --&gt;
    &lt;modificationset quietperiod="10"&gt;
      &lt;cvs localworkingcopy="projects/MyJavaTetris"/&gt;
    &lt;/modificationset&gt;

    &lt;!-- Configures the actual build loop, how often and which
                                  build file/target --&gt;
    &lt;schedule interval="60"&gt;
      &lt;ant buildfile="build-MyJavaTetris.xml"
        uselogger="true"/&gt;
    &lt;/schedule&gt;

    &lt;!-- directory to write build logs to --&gt;
    &lt;log/&gt;

    &lt;!-- Publishers are run *after* a build completes --&gt;
    &lt;publishers&gt;
    &lt;/publishers&gt;
  &lt;/project&gt;
&lt;/cruisecontrol&gt;
</pre>
</div>

<div>
</div>

<div>
  二つ目はbuild-MyJavaTetris.xmlです。このファイルにはprojects/ディレクトリにgit cloneし、ant buildで動作確認するプロセスが記述されています。antの標準機能ではgitの操作に対応していなかったので、<a href="http://tlrobinson.net/blog/2008/11/ant-tasks-for-git/">この記事</a>を参考にgitコマンドをmacrodefしています。<pre class="brush: xml; title: ; notranslate" title="">
&lt;?xml version="1.0" encoding="UTF-8" standalone="no"?&gt;
&lt;project name="build-MyJavaTetris" default="build" basedir="projects"&gt;
  &lt;target name="build"&gt;
    &lt;macrodef name = "git"&gt;
      &lt;attribute name = "command" /&gt;
      &lt;attribute name = "dir" default = "" /&gt;
      &lt;element name = "args" optional = "true" /&gt;
      &lt;sequential&gt;
        &lt;echo message = "git @{command}" /&gt;
        &lt;exec executable = "git" dir = "@{dir}"&gt;
          &lt;arg value = "@{command}" /&gt;
          &lt;args/&gt;
        &lt;/exec&gt;
      &lt;/sequential&gt;
    &lt;/macrodef&gt;

    &lt;delete dir="MyJavaTetris" /&gt;
    &lt;git command ="clone"&gt;
      &lt;args&gt;
        &lt;arg value ="ssh://git@github.com:22/yysaki/MyJavaTetris.git"/&gt;
      &lt;/args&gt;
    &lt;/git&gt;
    &lt;ant antfile="build.xml" dir="MyJavaTetris" target="build" /&gt;
    &lt;!-- nazo no error &lt;ant antfile="build.xml" dir="MyJavaTetris" target="test" /&gt; --&gt;
  &lt;/target&gt;
&lt;/project&gt;
</pre>
  
  <p>
    これで設定は全て完了です。
  </p>
  
  <p>
    /work/cc/下でcruisecontrol.shを実行するとMyJavaTetrisの自動ビルドが行われます。
  </p>
  
  <p>
    後はずっと放置しておけばCCさんが必要なタイミングでプロジェクトの自動ビルドを行います。
  </p>
  
  <p>
    リポジトリにコミットした時などにhttp://localhost:8080/にアクセスして動作をニヤニヤ監視しましょう。
  </p>
  
  <p>
    以上です。
  </p>
</div>

 [1]: http://www.amazon.co.jp/%E9%81%94%E4%BA%BA%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9E%E3%83%BC%E2%80%95%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E9%96%8B%E7%99%BA%E3%81%AB%E4%B8%8D%E5%8F%AF%E6%AC%A0%E3%81%AA%E5%9F%BA%E7%A4%8E%E7%9F%A5%E8%AD%98-%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E7%AE%A1%E7%90%86-%E3%83%A6%E3%83%8B%E3%83%83%E3%83%88%E3%83%86%E3%82%B9%E3%83%88-software-engineering/dp/475614599X
 [2]: http://yysaki.com/blog/wp-content/uploads/2012/09/CC_dashboard1.png
 [3]: http://cruisecontrol.sourceforge.net/
 [4]: http://sourceforge.net/projects/cruisecontrol/files/CruiseControl/2.8.4/
 [5]: https://github.com/yysaki/MyJavaTetris
 [6]: http://cruisecontrol.sourceforge.net/gettingstartedsourcedist.html
