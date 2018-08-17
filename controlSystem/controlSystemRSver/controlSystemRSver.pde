import org.gamecontrolplus.*; //<>//
import processing.serial.*;

int comNum = 5;
Serial myPort = new Serial(this, "COM" + comNum, 9600);//115200);
byte serialData = 0b00000000;

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
boolean Button1 = false;
boolean Button2 = false;

float x1 = 0;
float y1 = 0;

void setup() {
  fullScreen();
  //  size(50, 50);
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
    if (x1>0) {
      serialData = 1;
    } else {
      serialData = 0;
    }
    myPort.write(serialData);

    System.gc();
    delay(5);
    break;

  default :
  }

  //println(swichScene);//drawCount);
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

      int hatPos = hat.getPos();

      sliders[0] = device1.getSlider(0);
      sliders[1] = device1.getSlider(1);

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

      drawJoy();

      if (A.pressed() || X.pressed()) {
        text("A", 120+100, 60);
        text("X", 120+300, 60);
        Button1 = true;
      } else {
        Button1 = false;
      }

      if (B.pressed() || Y.pressed()) {
        text("B", 120+200, 60);
        text("Y", 120+400, 60);
        Button1 = true;
      } else {
        Button1 = false;
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

  num++;
  num = (num==5)? 1 : num;

  count++;
}

void drawDeviceNum(int devNum) {
  if (devNum>=0) {
    text("device "+devNum, 60, 60+height/6);
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

void drawJoy() {
  ellipse(x1*100+width/4-200, y1*100+height/2-390, 8, 8);
}
