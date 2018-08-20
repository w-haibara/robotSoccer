float x1 = 0;
float y1 = 0;

boolean Button1 = false;
boolean Button2 = false;

boolean L = false;
boolean R = false;
boolean F = false;
boolean B = false;

void setup() {
  background(255);
  size(100, 100);
}

void draw() {
  getKeyStatus();
}

void getKeyStatus() {
  x1 = 0;
  y1 = 0;
  println("");
  if (R) {
    x1 = 1;
    print("LEFT  ");
  } else if (L) {
    x1 = -1;
    print("RIGHT  ");
  }
  if (F) {
    y1 = 1;
    print("FORW  ");
  } else if (B) {
    y1 = -1;
    print("BACK  ");
  }
  if (R && (F || B)) {
    x1 = 0.7;
  }  
  if (L && (F || B)) {
    x1 = -0.7;
  }
  if ((L || R) && F) {
    y1 = 0.7;
  }  
  if ((L || R) && B) {
    y1 = -0.7;
  }
  if (Button1) {
    print("Button1");
  }
  if (Button2) {
    print("Button2");
  }
  if (!L && !R && !F && !B && !Button1 && !Button2) {
    print("not pressed");
  }
  print(" x1:"+x1+""+y1);
}

void keyPressed() {
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
  if (!Button2 && key=='i') {
    Button1 = true;
  }
  if (!Button1 && key=='o') {
    Button2 = true;
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
  if (key=='i' || key=='o') {
    Button1 = false;
    Button2 = false;
  }
}
