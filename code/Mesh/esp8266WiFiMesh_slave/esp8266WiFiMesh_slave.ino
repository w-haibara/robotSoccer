#include <ESP8266WiFi.h>
#include <ESP8266WiFiMesh.h>

String old_request = "";
String chipId = String(ESP.getChipId());

String manageRequest(String request);

/* Create the mesh node object */
//ESP.getChipId() returns the ESP8266 chip ID as a 32-bit integer.
ESP8266WiFiMesh mesh_node = ESP8266WiFiMesh(ESP.getChipId(), manageRequest);

/**
   Callback for when other nodes send you data

   @request The string received from another node in the mesh
   @returns The string to send back to the other node
*/
String manageRequest(String request) {
  if (request.equals(old_request)) {
    Serial.print(request);
    old_request = request;
  }
  return chipId;
}

void setup() {
  Serial.begin(115200);
  delay(10);
}

void loop() {
  /* Accept any incoming connections */
  mesh_node.acceptRequest();
}
