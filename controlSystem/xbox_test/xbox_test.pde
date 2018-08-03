import org.gamecontrolplus.*;
import java.util.List;

int  num = 0;
int count = 1;

void setup() {
  size(1200, 800);
  background(200);
  textSize(50);
}

void draw() {
  fill(200, 20); 
  rect(0, 0, width, height);

  int[] controler = {2, 4, 5, 6};
  xbox(controler[num]);
  num = (num==3)?-1:num; 
  num++;

  try {
    xbox(num);
  }
  catch(IndexOutOfBoundsException e) {
  }
  num = (num==7)?-1:num;
  num++;
}

void xbox(int NUM) {
  translate(0, 600-NUM*100);
  fill(0);

  ControlIO control;
  ControlDevice device1;    //, device2;
  ControlButton A, B, X, Y, LB, RB, BACK, START;
  ControlSlider[] sliders = new ControlSlider[5];

  control = ControlIO.getInstance(this);
  device1 = control.getDevice(NUM);
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

  ellipse(x1*100+width/2-200, y1*100+height/2-150, 8, 8);
  ellipse(x2*100+width/2+200, y2*100+height/2-150, 8, 8);
  rect(lr*300+width/2, height/2-170, 20, 20);

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
}
