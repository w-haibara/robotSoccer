import processing.serial.*;
Serial myPort;
final int portLength = Serial.list ().length;

void setup() {
  myPort = getSerialPort(myPort, 9600);
  println(myPort);
}

void draw() {
}

Serial getSerialPort(Serial port, int baudRate) {
  port = null;
  int exceptionCount = 0;
outside: 
  {
    for (int i = 0; i < portLength; i++) {
      print(Serial.list ()[i] + " : ");
      try {
        port = new Serial(this, Serial.list()[i], baudRate);
        break outside;
      }
      catch(Exception e) {
        exceptionCount++;
      }
    }
    if ( exceptionCount == portLength) {
      port = null;
    }
  }
  return port;
}
