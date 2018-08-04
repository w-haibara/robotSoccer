import org.gamecontrolplus.*;


int  num = 0;
int count = 1;

void setup() {
  fullScreen();
  background(20);
  noStroke();
  textSize(50);
}

void draw() {
  if (count%4==0) {
    fill(20, 10); 
    rect(0, 0, width, height);
  }
  int[] controlers = {10, 11, 12, 13};


  xbox(controlers, num);
  num++;
  num = (num==4)? 0 : num;
  count++;

  /*try {
   xbox(num);
   }
   catch(IndexOutOfBoundsException e) {
   }
   num = (num==7)?-1:num;
   num++;*/

  if (count%8==0) {
    fill(20, 30); 
    rect(0, 0, width, height);
  }
}

void xbox(int[] Controlers, int NUM) {
  translate(0, (height/Controlers.length)*NUM);
  fill(255);

  ControlIO control;
  ControlDevice device1;    //, device2;
  ControlButton A, B, X, Y, LB, RB, BACK, START;
  ControlSlider[] sliders = new ControlSlider[5];

  control = ControlIO.getInstance(this);
  device1 = control.getDevice(Controlers[num]);
  //device2 = control.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");
  device1.open();

  A = device1.getButton(0);
  B = device1.getButton(1);
  X = device1.getButton(2);
  Y = device1.getButton(3);
  LB = device1.getButton(4);
  RB = device1.getButton(5);
  BACK = device1.getButton(6);
  START = device1.getButton(7);

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

  ellipse(x1*100+width/2-200, y1*100+height/2-400, 8, 8);
  ellipse(x2*100+width/2+200, y2*100+height/2-400, 8, 8);
  rect(lr*300+width/2, height/2-420, 20, 20);

  if (A.pressed()) {
    text("A", 50, 100);
  }
  if (B.pressed()) {
    text("B", 150, 100);
  }
  if (X.pressed()) {
    text("X", 250, 100);
  }
  if (Y.pressed()) {
    text("Y", 350, 100);
  }
  if (RB.pressed()) {
    text("RB", 450, 100);
  }
  if (LB.pressed()) {
    text("LB", 550, 100);
  }
  if (BACK.pressed()) {
    text("BACK", 650, 100);
  }
  if (START.pressed()) {
    text("START", 850, 100);
  }

  translate(0, -(height/Controlers.length)*NUM);
}
