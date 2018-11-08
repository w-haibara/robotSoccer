//<<<<< Sender>>>>>>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

WiFiUDP Udp;
char packetBuffer[128];

const char *ssid = "AoD_RS_2018";
const char *password = "AoDRS2018";
const unsigned int localPort = 100;

IPAddress ipServer(192, 168, 12, 1);
IPAddress ipGateway(0, 0, 0, 0);
IPAddress Subnet(255, 255, 255, 0);
IPAddress ipBroadcast(192, 168, 12, 2);  //255);

void setup() {
  Serial.begin(115200);
  WiFi.softAPConfig(ipServer, ipGateway, Subnet);
  WiFi.softAP(ssid, password);
  Udp.begin(localPort);
}

void loop() {
  Udp.beginPacket(ipBroadcast, 100);

  byte data = Serial.read();
  Udp.write(data);

  Udp.endPacket();
}
