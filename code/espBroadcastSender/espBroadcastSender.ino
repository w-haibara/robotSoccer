#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

WiFiUDP Udp;

const char *ssid = "AoD_ESP_RS2018";
const char *password = "AoDESPRS2018";

const unsigned int localPort = 100;

char packetBuffer[128];

IPAddress ipServer(192, 168, 12, 1);
IPAddress ipGateway(0, 0, 0, 0);
IPAddress Subnet(255, 255, 255, 0);
IPAddress ipBroadcast(192, 168, 12, 255);

const int LED = 16;

void setup() {
  Serial.begin(115200);

  WiFi.softAPConfig(ipServer, ipGateway, Subnet);
  WiFi.softAP(ssid, password);

  Udp.begin(localPort);
}

void loop() {
  if (Serial.available() > 0) {
    Udp.beginPacket(ipBroadcast, localPort);

    uint8_t byteData = 0;
    if(Serial.available()) byteData = Serial.read();

    Udp.write(byteData);
    Udp.endPacket();

    Serial.println(byteData);
  }
}
