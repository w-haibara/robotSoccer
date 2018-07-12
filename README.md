# robotSoccer

# 各部品の仕様

## ＡＥ－ＡＴＭＥＧＡ３２８－ＭＩＮＩ　（Ａｒｄｕｉｎｏ　Ｐｒｏ　Ｍｉｎｉ上位互換）
arduino互換機です．  

ピン配列は  
RX:0  
TX:1  
PWM:3,5,6,9,10,11  
となっています．  
詳しくは[秋月の取扱説明書](https://www.google.co.jp/)を参照のこと．  

## TA7291P
モータードライバです．  

ピン配列と今回の接続先は，ICを正面から見た時，左から順に  
1 GND (GNDへ)
2 OUT1 出力端子(モーターの端子へ)  
3 NC 非接続  
4 V_ref 制御電源端子(arduinoのPWM出力ピンへ)  
5 IN1 入力端子(arduinoのデジタルピンへ)  
6 IN2 入力端子(arduinoのデジタルピンへ)  
7 V_cc ロジック側電源端子()  
8 V_s 出力側電源端子()  
9  NC 非接続  
10 OUT2 出力端子(モーターの端子へ)  
となっています．  
詳しくは[仕様書](http://akizukidenshi.com/download/ta7291p.pdf)の2ページを参照のこと．

入力ピンの状態と出力の関係  
|  IN1  |  IN2  | OUT1 | OUT2 |  
| ----- | ----- | ---- | ---- |  
|   0   |   0   |infty |infty |  
|   1   |   0   |  H   |  L   |  
|   0   |   1   |  L   |  H   |  
|   1   |   1   |  L   |  L   |  

