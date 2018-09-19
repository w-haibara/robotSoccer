/*Ver 1.5
  Wifi接続1Byte通信のプログラム
  サーバー(受信)側

  そもそもシリアル通信が1Byte用だからそれに合わせて
  WiFiUDP通信？も1Byteのみ通信する形にした
  配列が残ったままだが消すとエラーが出る
  不自然だがそのままでも使えるので勘弁してクレメンス

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
byte WiFibuff[1];

// UDP setting
WiFiUDP UDP;
// WiFi setting
IPAddress myIP(192, 168, 4, 1);
const char *ssid = "AoD_ESP_100";
const char *password = "AoDESP100";
const uint8_t port = 100;

void setup() {

  Serial.begin(115200);

  WiFi.mode(WIFI_AP);
  WiFi.softAP(ssid, password);
  WiFi.config(myIP, WiFi.gatewayIP(), WiFi.subnetMask());
  UDP.begin(port);
  //Serial.println("UDP.begin!");
}

void rcvWiFi() {
  UDP.read(WiFibuff, 1);
  Serial.write(WiFibuff[0]);
  UDP.flush();
}

void loop() {
  if (UDP.parsePacket() > 0) {
    rcvWiFi();
  }
}
