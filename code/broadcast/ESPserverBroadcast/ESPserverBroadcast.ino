#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <WiFiUDP.h>

WiFiUDP UDP;

byte WiFibuff[1];

IPAddress myIP(192, 168, 4, 1);
const char *ssid = "AoD_RS_2018";
const char *password = "AoD_RS_2018";

const int LED = 14;

void setup() {

  Serial.begin(115200);

  WiFi.mode(WIFI_AP);
  WiFi.softAP(ssid, password);
  WiFi.config(myIP, WiFi.gatewayIP(), WiFi.subnetMask());
  UDP.begin(100);

  pinMode(LED, OUTPUT);
}

void sendWiFi(byte byteData) {
  if (UDP.beginPacket(HOSTIP, 893)) {
    UDP.write(byteData);
    UDP.endPacket();
  }
}

void loop() {
  if (Serial.available() >= 1) {
    inputchar = Serial.read();
    sendWiFi(inputchar);
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
  end_loop();
}

void end_loop() {
  if (WiFi.status() != WL_CONNECTED) {
    WiFi.disconnect();
    connectWiFi();
  }
}
