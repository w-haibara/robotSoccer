# robotSoccer

# 各部品の仕様

## AE-ATMEGA328-MINI
arduino pro mini互換機です．  

ピン配列は  
RX : 0  
TX : 1  
PWM : 3,5,6,9,10,11  
となっています．  
詳しくは[AE-ATMEGA328-MINIの取扱説明書](https://www.google.co.jp/)を参照のこと．  

## TA7291P
モータードライバです．  

ピン配列と接続先は，ICを正面から見た時，左から順に

|No.|  Pin名 |機能              |接続先               |  
 -- | ------ | ---------------- | -------------------    
|1  |  GND   |GND               |GND                  |  
|2  |  OUT1  |出力端子          |モーターの端子       |  
|3  |  NC    |非接続            |非接続               |  
|4  |  V_ref |制御電源端子      |arduinoのPWM出力ピン |  
|5  |  IN1   |入力端子          |arduinoのデジタルピン|  
|6  |  IN2   |入力端子          |arduinoのデジタルピン|  
|7  |  V_cc  |ロジック側電源端子|マイコン側電源(VCC1) |  
|8  |  V_s   |出力側電源端子    |モーター側電源(VCC2) |  
|9  |  NC    |非接続            |非接続               |  
|10 |  OUT2  |出力端子          |モーターの端子       |  

となっています．  
詳しくは[TA7291Pの仕様書](http://akizukidenshi.com/download/ta7291p.pdf)の2ページを参照のこと．

特に今回は

|モーター|OUT1|OUT2|PWM|  
 ------- | -- | -- | -   
|LEFT    | 13 | 12 | 10|  
|RIGHT   |  7 |  8 |  9|  
|SHOOT   |  2 |  3 |  6|

というようにそれぞれのモーターとドライバ，arduinoを接続します．

入力ピンの状態と出力の関係  

|  IN1  |  IN2  | OUT1 | OUT2 |  
  ----- | ----- | ---- | ----    
|   0   |   0   |High-Z|High-Z|  
|   1   |   0   |  H   |  L   |  
|   0   |   1   |  L   |  H   |  
|   1   |   1   |  L   |  L   |  

詳しくは[TA7291Pの仕様書](http://akizukidenshi.com/download/ta7291p.pdf)の3ページを参照のこと．

## ESP-WROOM-02ピッチ変換済みモジュール《T型》  

wifi通信モジュールです．arduino互換機として動かします．  

詳しくは[スイッチサイエンスの販売ページ](https://www.switch-science.com/catalog/2580/)を参照してください．  

ピン配列と今回の接続先は  

|Pin名| 機能                             | 接続先                                         |  
 ---- | -------------------------------- | ----------------------------------------------  
|3V3  | 3.3V power supply                |MM-TXS01のVCC(3.3V)                             |  
|EN   | HIGHならチップをアクティブにする |3.3Vにプルアップ                                |  
|IO14 | GPIO14; HSPI_CLK                 |非接続                                          |  
|IO12 | GPIO12; HSPI_MISO                |非接続                                          |  
|IO13 | GPIO13; HSPI_MOSI; UART0_CTS     |非接続                                          |  
|IO15 | GPIO15; MTDO; HSPICS; UART0_RTS  |プルダウン            　　　　　　　　　　　    |  
|IO2  | GPIO2; UART1_TXD                 |3.3Vにプルアップ            　　　　　　　　    |  
|IO0  | GPIO0                            |3.3Vにプルアップ(ESPに書き込むときはプルダウン) |  
|GND  | GND                              |GND                                             |  
|     |                                  |                                                |  
|IO4  | GPIO4                            |非接続                                          |  
|RXD  | UART0_RXD; GPIO3                 |MM-TXS01のB8(->arduinoのTX)                     |  
|TXD  | UART0_TXD; GPIO1                 |MM-TXS01のB7(->arduinoのRX)                     |  
|GND  | GND                              |GND                                             |  
|IO5  | GPIO5                            |非接続                                          |  
|RST  | Reset                            |3.3Vにプルアップ                                |  
|TOUT | AD Conveter                      |非接続                                          |  
|IO16 | GPIO16                           |非接続                                          |  
|GND  | GND                              |GND                                             |  


詳しくは[ESP-WROOM-02の仕様書](http://doc.switch-science.com/datasheets/0c-esp-wroom_datasheet_en_v0.6.pdf)の6,7ページを参照のこと．

## MM-TXS01
2電源 8bit 双方向ロジックレベル変換モジュールです．

|ESP側(3.3V)|<->|arduino側(5V)|  
 -----------| - | ------------  
|VCC(3.3V)  |<->|VCC(5V)      |  
|A1         |<->|B1           |  
|A2         |<->|B2           |  
|A3         |<->|B3           |  
|A4         |<->|B4           |  
|A5         |<->|B5           |  
|A6         |<->|B6           |  
|A7         |<->|B7           |  
|A8         |<->|B8           |  
|OE         |   |GND          |  

OEピンをLOWにするとA1-A8,B1-B8のすべてのピンがHIGH-Zになる．(基板上でプルアップされている)

今回は次のように接続した

|ESP|3.3V側|<->|5v側|arduino側|  
 -- | ---- | - | -- | -------  
|   |      |   |    |         |  
|TX |  A7  |<->| B7 | RX      |  
|RX |  A8  |<->| B8 | TX      |  
|GND|      |   |GND | GND     |  

詳しくは[MM-TXS01取扱説明書](http://www.sunhayato.co.jp/dcms_media/other/SG13006_MM-TXS01_%E5%8F%96%E8%AA%AC.pdf)を参照してください．
