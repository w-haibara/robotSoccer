import org.gamecontrolplus.*; //<>//
import websockets.*;

int drawCount = 1;
int swichScene = 0;

int  num = 1;
int count = 1;

boolean Up = false;
boolean Down = false;
boolean Right = false;
boolean Left = false;
boolean RT = false;
boolean LT = false;
boolean Buttou1 = false;
boolean Buttou2 = false;

float x1 = 0;
float y1 = 0;
float x2 = 0;
float y2 = 0;
float lr = 0;

boolean C1 = false;
boolean C2 = false;
boolean C3 = false;
boolean C4 = false;

int com = -1;

int wscCount = 0;
String[] wscMessage = {"", "", "", ""};
String wscUrl[] = 
  {"ws://localhost:1880/ws/rs/1"
  , "ws://localhost:1880/ws/rs/2"
  , "ws://localhost:1880/ws/rs/3"
  , "ws://localhost:1880/ws/rs/4"};


void setup() {
  fullScreen();
  //size(1000, 1000);
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
      swichScene = 3;
    }
    drawCount++;
    break;

  case 1:
    drawTitle(200, 20);
    if (drawCount>40) {
      swichScene = 2;
    }
    if (mousePressed || keyPressed) {
      drawCount=0;
      background(20);
      swichScene = 3;
    }
    drawCount++;
    break;

  case 2:
    background(20);
    swichScene = 3;
    break;

  case 3:
    xbox_main();

    if (wscCount == 100) {
      sendWebsocket(num-1); 
      println(num);
    }
    if (wscCount == 101) {
      sendWebsocket(num-1); 
      println(num);
    }
    if (wscCount == 102) {
      sendWebsocket(num-1); 
      println(num);
    }
    if (wscCount == 103) {
      sendWebsocket(num-1); 
      println(num);
      wscCount = 0;
    }
    wscCount++;

    num++;
    num = (num==5)? 1 : num;

    break;

  default :
  }

  //println(swichScene);//drawCount);
}

void sendWebsocket(int wscNum) {
  WebsocketClient wsc = new WebsocketClient(this, wscUrl[wscNum]);

  //wsc.sendMessage("hi");


  if (0<=wscNum && wscNum<=3) {
    //wscMessage[wscNum] = (wscNum) + "=" + wscMessage[wscNum];
    wsc.sendMessage(wscMessage[wscNum]);
    wscMessage[wscNum] = "";
  } else {
    println("[websocket, wscNum] is illegal value");
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


void xbox_main() {
  int[] controlers = new int[4];
  controlers[0] = 2;
  controlers[1] = 3;
  controlers[2] = 5;
  controlers[3] = 6;
  xbox(controlers, num-1, false);
}

void xbox(int[] Controlers, int NUM, boolean test) {
  translate(0, (height/Controlers.length)*NUM);
  fill(255);
  PFont nameFont = loadFont("Kilowatt-Regular-70.vlw");
  textFont(nameFont);

  text(num, 20, 60);

  drawDeviceNum(Controlers[num-1]);
  drawComNum();

  if (!test) {
    try {
      ControlIO control;
      ControlDevice device1;    //, device2;
      ControlButton A, B, X, Y, LB, RB, BACK, START, HAT, LPUSH, RPUSH;
      ControlSlider[] sliders = new ControlSlider[5];

      ControlHat hat;

      control = ControlIO.getInstance(this);
      device1 = control.getDevice(Controlers[num-1]);
      //device2 = control.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");
      device1.open();

      /*
    float multiplier = 1;
       float y;
       final boolean[] indicators = new boolean[4];
       final String[] itext = { "left", "right", "up", "down" };
       */
      //    hat = device1.getHat(0);

      //    println();
      //    int hat = ControlHat.getPos();
      A = device1.getButton(0);
      B = device1.getButton(1);
      X = device1.getButton(2);
      Y = device1.getButton(3);
      LB = device1.getButton(4);
      RB = device1.getButton(5);
      BACK = device1.getButton(6);
      START = device1.getButton(7);
      LPUSH = device1.getButton(8);
      RPUSH = device1.getButton(9); 
      HAT  = device1.getButton(10);
      ControlButton[] buttonStatus  ={ A, B, X, Y, RB, LB, BACK, START, LPUSH, RPUSH};

      hat = device1.getHat(10);

      int hatPos = hat.getPos();

      sliders[0] = device1.getSlider(0);
      sliders[1] = device1.getSlider(1);
      sliders[2] = device1.getSlider(2);
      sliders[3] = device1.getSlider(3);
      sliders[4] = device1.getSlider(4);

      if (HAT.pressed()) {
        text("HAT = " + hatPos, 820, 120);

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
        x1 = sliders[1].getValue();
        y1 = sliders[0].getValue();
      }

      x2 = sliders[3].getValue();
      y2 = sliders[2].getValue();
      lr = -sliders[4].getValue();

      drawJoy();

      String[] buttonName  ={ "A", "B", "X", "Y", "RB", "LB", "BACK", "START", "LPUSH", "RPUSH"};
      for (int i=0; i<=9; i++) {
        if (buttonStatus[i].pressed()) {
          text(buttonName[i], 120+i*80, 60);
          wscMessage[num-1] = buttonName[i];
        }
      }
    }
    catch(java.lang.RuntimeException e) {
      fill(20); 
      int rectX = 120+700+100;
      int rectY = height/4;
      rect(0, 0, rectX, rectY);
      fill(255);
      text("the device is not available 3", 120+4*100, 60);
    }
  } else {
    x1 = 0;
    y1 = 0;
    x2 = 0;
    y2 = 0;
    lr = 0;

    //    lr = (float((mouseX-width/4)*5)/width);
    //    y1 = float(mouseY-height/2+390)/100;

    drawJoy();

    String[] buttonName  ={ "A", "B", "X", "Y", "RB", "LB", "BACK", "START"};

    for (int i=0; i<=7; i++) {
      text(buttonName[i], 120+i*100, 60);
    }
  }

  fill(20, 80); 
  int rectX = 120+700+100;
  int rectY = height/4;

  rect(0, 0, rectX, rectY);

  do {
    noFill();
    stroke(255);
    rect(0, 0, rectX, rectY);
    noStroke();
  } while (false);

  translate(0, -(height/Controlers.length)*NUM);


  count++;
  printBoolean();
  getKeyStatus();
}

void drawDeviceNum(int devNum) {
  if (devNum>=0) {
    text("device "+devNum, 20, 60+height/6);
  } else {
    text("no device", 20, 60+height/6);
  }
}

void drawComNum() {
  if (com>=0) {
    text("COM "+com, width/2-140, 60+height/6);
  } else {
    text("no port", width/2-160, 60+height/6);
  }
}

void drawJoy() {
  ellipse(x1*100+width/4-200, y1*100+height/2-390, 8, 8);
  ellipse(x2*100+width/4+200, y2*100+height/2-390, 8, 8);
  rect(lr*300+width/4, height/2-430, 20, 20);
}

void getKeyStatus() {
  Up = (key=='w')? true: false;
  Down = (key=='s')? true: false;
  Right = (key=='d')? true: false;
  Left = (key=='a')? true: false;
  RT = (key=='q')? true: false;
  LT = (key=='e')? true: false;
  Buttou1 = (key=='z')? true: false;
  Buttou2 = (key=='c')? true: false;

  switch(key) {
  case '1':
    C1 = true;
    break;
  case '2':
    C2 = true;
    break;
  case '3':
    C3 = true;
    break;
  case '4':
    C4 = true;
    break;
  }
}

void keyPressed() {
}

void printBoolean() {
  /*
  println("Up : "+Up);
   println("Down : "+Down);
   println("Right : "+Right);
   println("Left : "+Left);
   println("RT : "+RT);
   println("LT : "+LT);
   println("Buttou1 : "+Buttou1);
   println("Buttou2 : "+Buttou2);
   */
}
