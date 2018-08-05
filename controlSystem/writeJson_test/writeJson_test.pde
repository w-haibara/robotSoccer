PrintWriter output; 

void setup() {  
  size(400, 400);  
  output = createWriter("saySomething.json");

  write("hello");
} 

void draw() {
} 

void write(String msg) {
  String json1 = "[{\"id\":\"bb0fd829.c0ec18\",\"type\":\"tab\",\"label\":\"say " + msg + "\",\"disabled\":false,\"info\":\"\"},{\"id\":\"904ac127.de66f\",\"type\":\"inject\",\"z\":\"bb0fd829.c0ec18\",\"name\":\"\",\"topic\":\"\",\"payload\":\"" + msg + "\",\"payloadType\":\"str\",\"repeat\":\"1\",\"crontab\":\"\",\"once\":false,\"onceDelay\":0.1,\"x\":102,\"y\":69.14999389648437,\"wires\":[[\"e2bf8937.1e51e8\"]]},{\"id\":\"e2bf8937.1e51e8\",\"type\":\"debug\",\"z\":\"bb0fd829.c0ec18\",\"name\":\"\",\"active\":true,\"tosidebar\":true,\"console\":true,\"tostatus\":false,\"complete\":\"payload\",\"x\":161,\"y\":165.29998779296875,\"wires\":[]}]";

  output.println(json1);

  output.flush();
  output.close();
}
