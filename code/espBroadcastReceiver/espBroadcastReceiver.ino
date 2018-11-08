#include <ESP8266WiFi.h>
#include <WiFiUdp.h >

WiFiUDP Udp;

const char *ssid = "AoD_ESP_RS2018";
const char *password = "AoDESPRS2018";

unsigned int localPort = 100;

char packetBuffer[128];

IPAddress ipServer(192, 168, 12, 1);
IPAddress ipClient(192, 168, 12, 2);
IPAddress Subnet(255, 255, 255, 0);

const int LED = 16;

void setup() {
  pinMode(LED, OUTPUT);
  digitalWrite(LED, LOW);

  Serial.begin(115200);

  WiFi.begin(ssid, password);
  WiFi.mode(WIFI_STA);
  WiFi.config(ipClient, ipServer, Subnet);

  Udp.begin(localPort);

  delay(200);
}

void loop() {
  int packetSize = Udp.parsePacket();
  if (packetSize) {
    byte byteData = Udp.read();
    Serial.println(byteData);

    if (byteData == 100) {
      digitalWrite(LED, HIGH);
    } else {
      digitalWrite(LED, LOW);
    }
  }
}
