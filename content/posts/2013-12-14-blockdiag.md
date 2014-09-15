---
title: 'blockdiagのエラーを解決できず&#8230;'
author: yysaki
layout: post
categories:
  - プログラミング
---
[blockdiag][1]を使ってみたくてインストールしてみたのですが、画像生成でエラーが発生し、これをうまく解決できませんでした。今回開発者の[@tk0miya][2]さんに解決方法について質問をするために、エラー報告を記事にまとめたいと思います。

## 環境

私の環境は以下の通りです。

*   OS: mac OS X 10.9(Mavericks)
*   Python: 2.7.5
*   homebrew, easy_installを使ってインストール

## インストール手順

実際にblockdiagをインストールするために行った手順を記述します。

まずPILをインストールします。PILはfreetypes, zlib, libjpeg, libpngといったライブラリに依存するようなので、まずこれらのインストールから始めます。 freetypeに関しては[ここ][3]を参考に /usr/local/Library/Formula/freetype2.rb を作成します。その後、以下の手順を行います。

    $ sudo brew install freeytype2 ibjepg libpng
    $ brew tap homebrew/dupes
    $ sudo brew install zlib
    

この時インストールしたzlibライブラリはPathに通らないため、手動でリンクを貼る必要があります。そのため /usr/local/ に /usr/local/Cellar/zlib/1.2.8/ 以下のlib, include内のファイルをシンボリックリンクを貼りました。

続いてPIL自体のインストール。

    $ sudo easy_install pil
    

SUMMARYは以下のようになり、zlibやfreetypeに対応されているように見えます。

    --------------------------------------------------------------------
    PIL 1.1.7 SETUP SUMMARY
    --------------------------------------------------------------------
    version       1.1.7
    platform      darwin 2.7.5 (default, Aug 25 2013, 00:04:04)
                  [GCC 4.2.1 Compatible Apple LLVM 5.0 (clang-500.0.68)]
    --------------------------------------------------------------------
    --- TKINTER support available
    --- JPEG support available
    --- ZLIB (PNG/ZIP) support available
    --- FREETYPE2 support available
    *** LITTLECMS support not available
    --------------------------------------------------------------------
    

最後にblockdiagのインストール。

    $ sudo easy_install -mxN blockdiag
    

して、

    $ blockdiag --version
    blockdiag 1.3.2
    

のように、blockdiagをインストール出来ました。

## 症状

以下のようなsimple.diagを生成しようとして見ると、エラーが発生します。

        diagram admin {
          top_page -> config -> config_edit -> config_confirm -> top_page;
        }
    

デバッグプリントは以下の通りです。

    $ blockdiag simple.diag --debug
    Traceback (most recent call last):
      File "/Library/Python/2.7/site-packages/blockdiag-1.3.2-py2.7.egg/blockdiag/utils/bootstrap.py", line 36, in run
        return self.build_diagram(parsed)
      File "/Library/Python/2.7/site-packages/blockdiag-1.3.2-py2.7.egg/blockdiag/command.py", line 42, in build_diagram
        return super(BlockdiagApp, self).build_diagram(tree)
      File "/Library/Python/2.7/site-packages/blockdiag-1.3.2-py2.7.egg/blockdiag/utils/bootstrap.py", line 83, in build_diagram
        drawer.save()
      File "/Library/Python/2.7/site-packages/blockdiag-1.3.2-py2.7.egg/blockdiag/drawer.py", line 186, in save
        return self.drawer.save(self.filename, size, self.format)
      File "/Library/Python/2.7/site-packages/blockdiag-1.3.2-py2.7.egg/blockdiag/imagedraw/filters/linejump.py", line 172, in save
        return self.target.save(*args, **kwargs)
      File "/Library/Python/2.7/site-packages/blockdiag-1.3.2-py2.7.egg/blockdiag/imagedraw/png.py", line 400, in save
        self._image.save(self.filename, _format)
      File "build/bdist.macosx-10.9-intel/egg/PIL/Image.py", line 1453, in save
        save_handler(self, fp, filename)
      File "build/bdist.macosx-10.9-intel/egg/PIL/PngImagePlugin.py", line 619, in _save
        ImageFile._save(im, _idat(fp, chunk), [("zip", (0,0)+im.size, 0, rawmode)])
      File "build/bdist.macosx-10.9-intel/egg/PIL/ImageFile.py", line 454, in _save
        e = Image._getencoder(im.mode, e, a, im.encoderconfig)
      File "build/bdist.macosx-10.9-intel/egg/PIL/Image.py", line 405, in _getencoder
        raise IOError("encoder %s not available" % encoder_name)
    IOError: encoder zip not available
    

## 参考URL

*   [blockdiag の概要 — blockdiag 1.0 documentation][4]
*   [Python3.3対応画像処理ライブラリ Pillow(PIL) の使い方 | Librabuch][5]
*   [mac で spdylay の build もしくは homebrew と pkg-config &#8211; Qiita [キータ]][6] 
    *   zlib周りを参考にさせて頂きました

以上です。

 [1]: http://blockdiag.com/ja/blockdiag/
 [2]: https://twitter.com/tk0miya
 [3]: http://blockdiag.com/ja/blockdiag/introduction.html#macosx-homebrew
 [4]: http://blockdiag.com/ja/blockdiag/introduction.html
 [5]: http://librabuch.jp/2013/05/python_pillow_pil/
 [6]: http://qiita.com/Jxck_/items/d329aa5c9b50519dcfaf
