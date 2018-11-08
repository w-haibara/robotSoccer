//<<<<< Receiver>>>>>>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h >

WiFiUDP Udp;
const char *ssid = "AoD_RS_2018";
const char *password = "AoDRS2018";

char packetBuffer[255];
unsigned int localPort = 100;
IPAddress ipServer(192, 168, 12, 1);
IPAddress ipClient(192, 168, 12, 5);
IPAddress Subnet(255, 255, 255, 0);S

void setup() {
  Serial.begin(115200);
  Serial.println("setup");
  WiFi.begin(ssid, password);
  Serial.println("wifi begin");

  WiFi.mode(WIFI_STA);

  WiFi.config(ipClient, ipServer, Subnet);
  Udp.begin(localPort);
  delay(200);
}

void loop() {
  int packetSize = Udp.parsePacket();
  if (packetSize) {
    int len = Udp.read(packetBuffer, 255);
    if (len > 0) packetBuffer[len - 1] = 0;
  }
}
