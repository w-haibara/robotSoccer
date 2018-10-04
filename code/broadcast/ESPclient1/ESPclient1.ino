#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <WiFiUDP.h>

WiFiUDP UDP;

byte WiFibuff[1];

const int LED = 14;

IPAddress HOSTIP (192, 168, 4, 1);
IPAddress myIP(192, 168, 4, 2);
const char *ssid = "AoD_RS_2018";
const char *password = "AoD_RS_2018";

void connectWiFi() {
  WiFi.begin(ssid, password);//接続先を指定する
  WiFi.config(myIP, WiFi.gatewayIP(), WiFi.subnetMask());

  //Serial.println("start_connect");
  while (WiFi.status() != WL_CONNECTED) {//接続状態の確認
    delay(100);
  }
}

void setup() {
  Serial.begin(115200);

  WiFi.mode(WIFI_STA);
  UDP.begin(100);
  connectWiFi();

  pinMode(LED, OUTPUT);
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
