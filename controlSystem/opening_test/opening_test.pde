int count = 0;

void setup() {
  fullScreen();
  background(20);
  noStroke();
}

void draw() {
  opening();
}

void opening() {
  if (count%3==0) {
    fill(200, 100, 100, 50);
    rect(0, 0, width, height);
  }
  if (count%2==0) {
    fill(200, 20, 250, 30);
    rect(0, 0, width, height);
  }
  fill(200, 20, 20, 10);
  rect(0, 0, width, height);

  fill(255);
  PFont nameFont = loadFont("Kilowatt-Regular-70.vlw");
  textFont(nameFont);
  text(count, count, count);
  count=int(random(0, 1024));
}
