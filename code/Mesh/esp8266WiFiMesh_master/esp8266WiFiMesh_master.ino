#include <ESP8266WiFi.h>
#include <ESP8266WiFiMesh.h>

String manageRequest(String request);
byte old_byteDate = 0;
/* Create the mesh node object */
//ESP.getChipId() returns the ESP8266 chip ID as a 32-bit integer.
ESP8266WiFiMesh mesh_node = ESP8266WiFiMesh(ESP.getChipId(), manageRequest);

/**
   Callback for when other nodes send you data

   @request The string received from another node in the mesh
   @returns The string to send back to the other node
*/
String manageRequest(String request) {
  /* Print out received message */
  Serial.print("received: ");
  Serial.println(request);

  /* return a string to send back */
  return "response";
}

void setup() {
  Serial.begin(115200);
  delay(10);
  Serial.println(ESP.getChipId());
}

void loop() {
  /* Accept any incoming connections */
  mesh_node.acceptRequest();

  /* Scan for other nodes and send them a message */
  byte byteDate = Serial.read();
  if (byteDate != old_byteDate) {
    String data = String(byteDate);
    mesh_node.attemptScan(data);
    Serial.print("send data : ");
    Serial.println(data);
    old_byteDate = byteDate;
  }
  Serial.println("notSend");
}
