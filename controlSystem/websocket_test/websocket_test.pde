import websockets.*;

WebsocketClient wsc = new WebsocketClient(this, "ws://localhost:1880/ws/rs/ControlSystem");
String message = "";

int count = 0;

void setup() {
  size(400, 400);
  background(255);
  fill(0);
  
}

void draw() {
  text(message, 20, 20);
  delay(100);
  wsc.sendMessage(str(count));
  count++;
}
