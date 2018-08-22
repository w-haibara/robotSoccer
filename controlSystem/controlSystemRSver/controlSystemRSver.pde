import org.gamecontrolplus.*; //<>//
import processing.serial.*;

int comNum = 3;
Serial myPort= new Serial(this, "COM"+comNum, 9600);

byte serialData = 0x00;

int drawCount = 1;
int swichScene = 0;

int  num = 1;

boolean Hat = false;
boolean Button1 = false;
boolean Button2 = false;
int hatPos = 0;
float x1 = 0;
float y1 = 0;

boolean Button1_key = false;
boolean Button2_key = false;
float x1_key = 0;
float y1_key = 0;

boolean L = false;
boolean R = false;
boolean F = false;
boolean B = false;

int slave = 0;

void setup() {
  // fullScreen();
  size(1200, 1000);
  background(20);
  noStroke();
}

void draw() {
  switch(swichScene) {
  case 0:
    if (drawCount>=0 && drawCount<=235 && swichScene==0) {
      swichScene = 0;
    } else {
      drawCount=0;
      swichScene = 1;
    }
    drawTitle(20, drawCount);
    delay(1);
    if (mousePressed || keyPressed) {
      drawCount=0;
      background(20);
      swichScene = 2;
    }
    drawCount += 4;
    break;

  case 1:
    drawTitle(200, 20);
    if (drawCount>40) {
      swichScene = 2;
    }
    if (mousePressed || keyPressed) {
      drawCount=0;
      background(20);
      swichScene = 2;
    }
    drawCount++;
    break;

  case 2:
    background(20);
    swichScene = 3;
    break;

  case 3:
    //    seekCom();
    swichScene = 4;
    break;

  case 4:
    xbox_main();
    System.gc();
    delay(5);
    break;

  default :
  }
}

void drawTitle(int back, int fill) {
  background(back);
  PFont TitleFont = loadFont("Kilowatt-Regular-170.vlw");
  PFont titleFont = loadFont("Kilowatt-Regular-70.vlw");
  fill = fill+20;
  fill(fill);
  textAlign(CENTER, CENTER);
  textFont(TitleFont);
  text("RS         CONTROL         SYSTEM", width/2, height/2-100);
  textFont(titleFont);
  text("ATELIE         OF         DRESM", width/2, height/2+200);
}

/*
void seekCom() {
 String[] portList = myPort.list ();
 printArray(Serial.list());
 if (portList.length>0) {
 for (int i=0; i<portList.length; i++) {
 print(portList[i]);
 try {
 myPort = new Serial(this, portList[i], 9600);
 println("success");
 comNum = i;
 }
 catch(Exception e) {
 println("failed");
 }
 }
 } else if (portList.length==0) {
 println("no available COM port");
 }
 }
 */

void sendSerial() {
  serialData = 0x00;
  //  print("device" + num + " COM" + comNum + "  ");
  if (x1<0) {
    serialData |= 0x04;
  }
  switch(int(abs(x1))) {
  case 33:
    serialData |= 0x01;
    break;
  case 66:
    serialData |= 0x02;
    break;
  case 100:
    serialData |= 0x03;
    break;
  default:
  }
  if (y1<0) {
    serialData |= 0x20;
  }
  switch(int(abs(y1))) {
  case 33:
    serialData |= 0x08;
    break;
  case 66:
    serialData |= 0x10;
    break;
  case 100:
    serialData |= 0x18;
    break;
  default:
  }
  if (Button1==true) {    
    serialData |= 0x40;
  }
  if (Button2==true) {
    serialData |= 0x80;
  }

  if (comNum>=0) {
    if (num==1) {
      myPort.write("H");
    }
    myPort.write(serialData);
  }
  if (num == 1) {
    println("serialData : " + binary(serialData) + " / x:"+x1+"/y:"+y1+"/B1"+Button1+"/B2"+Button2);
  }
}

void xbox_main() {
  int[] controlers = new int[4];
  controlers[0] = 2;
  controlers[1] = 3;
  controlers[2] = 5;
  controlers[3] = 6;

  getKeyStatus();

  if (num!=slave) {
    xbox(controlers);
  } else {
    Button1 = Button1_key;
    Button2 = Button2_key;
    x1 = x1_key;
    y1 = y1_key;
  }

  drawControlerStatus(controlers, num-1);
  sendSerial();

  num++;
  num = (num==5)? 1 : num;
}

void xbox(int[] Controlers) {
  try {
    ControlIO control;
    ControlDevice device1;    //, device2;
    ControlButton A, B, X, Y, HAT;
    ControlSlider[] sliders = new ControlSlider[2];

    ControlHat hat;

    control = ControlIO.getInstance(this);
    device1 = control.getDevice(Controlers[num-1]);
    //device2 = control.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");
    device1.open();

    A = device1.getButton(0);
    B = device1.getButton(1);
    X = device1.getButton(2);
    Y = device1.getButton(3);
    HAT  = device1.getButton(10);

    hat = device1.getHat(10);

    hatPos = hat.getPos();

    sliders[0] = device1.getSlider(0);
    sliders[1] = device1.getSlider(1);

    if (HAT.pressed()) {
      Hat = true;
      switch(hatPos) {
      case 1:
        x1 = -0.7;
        y1 = -0.7;
        break;
      case 2:
        y1 = -1;
        break;
      case 3:
        x1 = 0.7;
        y1 = -0.7;
        break;
      case 4:
        x1 = 1;
        break;
      case 5:
        x1 = 0.7;
        y1 = 0.7;
        break;
      case 6:
        y1 = 1;
        break;
      case 7:
        x1 = -0.7;
        y1 = 0.7;
        break;
      case 8:
        x1 = -1;
        break;
      }
    } else {
      Hat = false;
      x1 = sliders[1].getValue();
      y1 = sliders[0].getValue();
    }

    if (A.pressed() || X.pressed()) {
      Button1 = true;
    } else {
      Button1 = false;
    }

    if (B.pressed() || Y.pressed()) {
      Button2 = true;
    } else {
      Button2 = false;
    }
  }
  catch(java.lang.RuntimeException e) {
    fill(20); 
    int rectX = 120+700+100;
    int rectY = height/4;
    rect(0, 0, rectX, rectY);
    fill(255);
    text("the device is not available 3", width/4, height/8);
  }
}

void drawDeviceNum(int devNum) {
  if (devNum>=0) {
    if (slave==num) {
      text("slave", 50, 60+height/6);
    } else { 
      text("device "+devNum, 60, 60+height/6);
    }
  } else {
    text("no device", 20, 60+height/6);
  }
}

void drawComNum() {
  if (comNum>=0) {
    text("COM "+comNum, width/2-140, 60+height/6);
  } else {
    text("no port", width/2-160, 60+height/6);
  }
}

void drawControlerStatus(int[] Controlers, int NUM) {
  translate(0, (height/Controlers.length)*NUM);
  fill(255);
  PFont nameFont = loadFont("Kilowatt-Regular-70.vlw");
  textFont(nameFont);

  text(num, 20, 60);

  drawDeviceNum(Controlers[num-1]);

  x1 = (int(x1*3)/3.0)*100;
  y1 = (int(y1*3)/3.0)*100;

  ellipse(x1+width/4-200, y1+height/2-390, 8, 8);

  if (Hat) {
    text("HAT = " + hatPos, 820, 120);
  }
  if (Button1) {
    text("A", 120+100, 60);
    text("X", 120+300, 60);
  }
  if (Button2) {
    text("B", 120+200, 60);
    text("Y", 120+400, 60);
  }

  fill(20, 120); 
  int rectX = 120+700+100;
  int rectY = height/4;
  rect(0, 0, rectX, rectY);

  noFill();
  stroke(255);
  rect(0, 0, rectX, rectY);
  noStroke();

  translate(0, -(height/Controlers.length)*NUM);
}

void getKeyStatus() {
  x1_key = 0;
  y1_key = 0;
  if (R) {
    x1_key = 1;
  } else if (L) {
    x1_key = -1;
  }
  if (F) {
    y1_key = -1;
  } else if (B) {
    y1_key = 1;
  }
  if (R && (F || B)) {
    x1_key = 0.7;
  }  
  if (L && (F || B)) {
    x1_key = -0.7;
  }
  if ((L || R) && F) {
    y1_key = -0.7;
  }  
  if ((L || R) && B) {
    y1_key = 0.7;
  }
}

void keyPressed() {
  switch(key) {
  case '0':
    slave = 0;
    break;
  case '1':
    slave = 1;
    break;
  case '2':
    slave = 2;
    break;
  case '3':
    slave = 3;
    break;
  case '4':
    slave = 4;
    break;
  default:
  }
  if (!R && key=='a') {
    L = true;
  }
  if (!L && key=='d') {
    R = true;
  }
  if (!B && key=='w') {
    F = true;
  }
  if (!F && key=='s') {
    B = true;
  }
  if (key=='i') {
    Button1_key = true;
  }
  if (key=='o') {
    Button2_key = true;
  }
}

void keyReleased() {
  if (key=='a' || key=='d') {
    L = false;
    R = false;
  }
  if (key=='w' || key=='s') {
    F = false;
    B = false;
  }
  if (key=='i') {
    Button1_key = false;
  }
  if (key=='o') {
    Button2_key = false;
  }
}
