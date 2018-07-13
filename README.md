# robotSoccer

# 各部品の仕様

## AE-ATMEGA328-MINI
arduino pro mini互換機です．  

ピン配列は  
RX : 0  
TX : 1  
PWM : 3,5,6,9,10,11  
となっています．  
詳しくは[秋月の取扱説明書](https://www.google.co.jp/)を参照のこと．  

## TA7291P
モータードライバです．  

ピン配列と接続先は，ICを正面から見た時，左から順に

 --| ------ | ---------------- | -------------------    
|1 |  GND   |GND               |GND                  |  
|2 |  OUT1  |出力端子          |モーターの端子       |  
|3 |  NC    |非接続            |非接続               |  
|4 |  V_ref |制御電源端子      |arduinoのPWM出力ピン |  
|5 |  IN1   |入力端子          |arduinoのデジタルピン|  
|6 |  IN2   |入力端子          |arduinoのデジタルピン|  
|7 |  V_cc  |ロジック側電源端子|マイコン側電源(VCC1) |  
|8 |  V_s   |出力側電源端子    |モーター側電源(VCC2) |  
|9 |  NC    |非接続            |非接続               |  
|10|  OUT2  |出力端子          |モーターの端子       |  

となっています．  
詳しくは[仕様書](http://akizukidenshi.com/download/ta7291p.pdf)の2ページを参照のこと．

特に今回は

 

入力ピンの状態と出力の関係  

|  IN1  |  IN2  | OUT1 | OUT2 |  
  ----- | ----- | ---- | ----    
|   0   |   0   |High-Z|High-Z|  
|   1   |   0   |  H   |  L   |  
|   0   |   1   |  L   |  H   |  
|   1   |   1   |  L   |  L   |  

詳しくは[仕様書](http://akizukidenshi.com/download/ta7291p.pdf)の3ページを参照のこと．

## ESP-WROOM-02ピッチ変換済みモジュール《T型》  

wifi通信モジュールです．arduino互換機として動かします．  

詳しくは[スイッチサイエンスの販売ページ](https://www.switch-science.com/catalog/2580/)を参照してください．  

ピン配列と今回の接続先は  
 ---- | -------------------------------- | ------------------------  
|IO14 | GPIO14; HSPI_CLK                 |                          |  
|IO12 | GPIO12; HSPI_MISO                |                          |  
|IO13 | GPIO13; HSPI_MOSI; UART0_CTS     |                          |  
|IO15 | GPIO15; MTDO; HSPICS; UART0_RTS  |                          |  
|IO2  | GPIO2; UART1_TXD                 |                          |  
|IO0  | GPIO0                            |                          |  
|GND  | GND                              |                          |  
|     |                                  |                          |  
|IO4  | GPIO4                            |                          |  
|RXD  | UART0_RXD; GPIO3                 |                          |  
|TXD  | UART0_TXD; GPIO1                 |                          |  
|GND  | GND                              |                          |  
|IO5  | GPIO5                            |                          |  
|RST  | Reset                            |                          |  
|TOUT | AD Conveter                      |                          |  
|IO16 | GPIO16                           |                          |  
|GND  | GND                              |                          |  


詳しくは[仕様書](http://doc.switch-science.com/datasheets/0c-esp-wroom_datasheet_en_v0.6.pdf)の6,7ページを参照のこと．


