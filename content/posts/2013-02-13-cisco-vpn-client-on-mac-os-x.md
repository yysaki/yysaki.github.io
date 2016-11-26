---
title: MacOSX Cisco VPNClient対策
created_at: 2013-02-13
author: yysaki
layout: post
categories:
  - 未分類
tags:
  - macbookair
---
### 状況

*   macbook air学内VPN接続のためvpnクライアントをインストールしたが64bitカーネルでは動かず 
    *   ciscoは32bitのみサポートしている
    *   ネットのmacユーザにはciscoを避ける向きがあるようだ

### 対策

*   OSを常に32bitカーネルとして起動する 
    *   搭載メモリは今のところ4GB以内のため被害は少ないと判断
    *   &#8220;sudo systemsetup -setkernelbootarchitecture i386&#8243;を実行する

### 参考URL

*   [同症状とその対策][1]
*   [Cisco VPN Client lacks 64 bit Support][2]
*   [32bit化手順][3]

 [1]: http://forums.macrumors.com/archive/index.php/t-1110046.html
 [2]: https://discussions.apple.com/thread/3077376?start=0&tstart=0
 [3]: http://support.apple.com/kb/HT3773?viewlocale=ja_JP
