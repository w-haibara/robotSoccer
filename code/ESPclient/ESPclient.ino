/*Ver 1.5
  Wifi接続1Byte通信のプログラム
  クライアント(送信)側

  まず、
  http://okiraku-camera.tokyo/blog/?p=3278
  か
  https://qiita.com/arigadget/items/0c0a0c3ce4f0555c66a5
  ↑ここを参考にIDEの設定を変更すべし

  const char *ssid = "AoD_ESP_001";
  の
  AoD_ESP_001
  を好きに割り振るようにして
  SSIDが被らなければ複数対が別々に通信できる

  ※SSIDに空白とか日本語とか使えない文字がある
  ※PWにも使えない文字があって、英数混合8文字以上っていう制限付き
  ※IPアドレスは同一ネットワーク内じゃないから変更不要(被りok)


*/

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <WiFiUDP.h>

// Variable setting
byte inputchar;

// UDP settings
WiFiUDP UDP;

// WiFi settings
IPAddress HOSTIP (192, 168, 4, 1);
IPAddress myIP(192, 168, 4, 3);//4.1: 4.2: 4.3
const char *ssid = "AoD_ESP_999";
const char *password = "AoDESP999";

void connectWiFi() {
  WiFi.begin(ssid, password);//接続先を指定する
  WiFi.config(myIP, WiFi.gatewayIP(), WiFi.subnetMask());

  //Serial.println("start_connect");
  while (WiFi.status() != WL_CONNECTED) {//接続状態の確認
    delay(100);
    //Serial.print(".");
  }
  //Serial.println("CONNECTED!");
}

void setup() {
  Serial.begin(115200);
  //Serial.println("start");
  WiFi.mode(WIFI_STA);//重要!
  UDP.begin(100);
  connectWiFi();
}

void sendWiFi(byte byteData) {
  if (UDP.beginPacket(HOSTIP, 893)) {
    UDP.write(byteData);
    UDP.endPacket();
    //Serial.println(byteData);
  }
}

void loop() {
  if (Serial.available() >= 1) {
    // シリアルポートより読み込む
    inputchar = Serial.read();
    sendWiFi(inputchar);
  }

  end_loop();
}

void end_loop() {
  if (WiFi.status() != WL_CONNECTED) {
    WiFi.disconnect();
    //Serial.println("disconnect!");
    connectWiFi();
  }
}
