import org.gamecontrolplus.*;

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

boolean C1 = false;
boolean C2 = false;
boolean C3 = false;
boolean C4 = false;

int com = -1;

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
    drawCount++;
    break;
  case 1:
    drawTitle(200, 20);
    if (drawCount>40) {
      swichScene = 2;
    }
    drawCount++;
    break;
  case 2:
    background(20);
    swichScene = 3;
    break;
  case 3:
    int[] controlers = {2, 4, 5, 6};
    xbox(controlers, num-1, true);
    /*try {
     xbox(num);
     }
     catch(IndexOutOfBoundsException e) {
     }
     num = (num==7)?-1:num;
     num++;*/
    break;
  default :
  }

  println(swichScene);//drawCount);
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
    ControlIO control;
    ControlDevice device1;    //, device2;
    ControlButton A, B, X, Y, LB, RB, BACK, START;
    ControlSlider[] sliders = new ControlSlider[5];

    ControlHat hat;

    control = ControlIO.getInstance(this);
    device1 = control.getDevice(Controlers[num-1]);
    //device2 = control.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");
    device1.open();

    hat = device1.getHat(0);
    println(hat);

    A = device1.getButton(0);
    B = device1.getButton(1);
    X = device1.getButton(2);
    Y = device1.getButton(3);
    LB = device1.getButton(4);
    RB = device1.getButton(5);
    BACK = device1.getButton(6);
    START = device1.getButton(7);
    ControlButton[] buttonStatus  ={ A, B, X, Y, RB, LB, BACK, START};

    sliders[0] = device1.getSlider(0);
    sliders[1] = device1.getSlider(1);
    sliders[2] = device1.getSlider(2);
    sliders[3] = device1.getSlider(3);
    sliders[4] = device1.getSlider(4);

    float x1 = sliders[1].getValue();
    float y1 = sliders[0].getValue();
    float x2 = sliders[3].getValue();
    float y2 = sliders[2].getValue();
    float lr = -sliders[4].getValue();

    drawJoy(x1, y1, x2, y2, lr);

    String[] buttonName  ={ "A", "B", "X", "Y", "RB", "LB", "BACK", "START"};
    for (int i=0; i<=7; i++) {
      if (buttonStatus[i].pressed()) {
        text(buttonName[i], 120+i*100, 60);
      }
    }
  } else {
    float x1 = 0;
    float y1 = 0;
    float x2 = 0;
    float y2 = 0;
    float lr = 0;

    //    lr = (float((mouseX-width/4)*5)/width);
    //    y1 = float(mouseY-height/2+390)/100;

    drawJoy(x1, y1, x2, y2, lr);

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
  printBoolean();
  getKeyStatus();
}

void drawDeviceNum(int num) {
  if (num>=0) {
    text("device "+num, 20, 60+height/6);
  } else {
    text("no device", 20, 60+height/6);
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



void drawComNum() {
  if (com>=0) {
    text("COM "+com, width/2-140, 60+height/6);
  } else {
    text("no port", width/2-160, 60+height/6);
  }
}

void drawJoy(float x1, float y1, float x2, float y2, float lr) {
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