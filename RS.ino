/* we want to fix the RS machine
   DCmoter compose a shoot machinism doesn't react
*/
#include <VarSpeedServo.h>
VarSpeedServo servo;

int count = 0;

void setup() {
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  servo.attach(11);
}

void loop() {
  moter('R', HIGH, LOW, 500, 255);
  moter('R', HIGH, HIGH, 500, 255);

  moter('L', HIGH, LOW, 500, 200);
  moter('L', HIGH, HIGH, 500, 255);

  moter('S', HIGH, LOW, 500, 200);
  moter('S', HIGH, HIGH, 500, 255);
  delay(500);
  /*
      servo.write(0, 255, true);
      delay(500);
      servo.write(90, 255, true);
      delay(500);*/

}

void moter(char type, int I1, int I2, int Time, int pwm) {

  int pins[] = {0, 0, 0}; //pinI1, pinI2, pinPWM

  switch (type) {
    case 'R':
      pins[0] = 2;
      pins[1] = 3;
      pins[2] = 6;
      break;

    case 'L':
      pins[0] = 7;
      pins[1] = 8;
      pins[2] = 9;
      break;

    case 'S':
      pins[0] = 13;
      pins[1] = 12;
      pins[2] = 10;
      break;
  }

  analogWrite(pins[2], pwm);

  digitalWrite(pins[0], I1);
  digitalWrite(pins[1], I2);
  delay(Time);
}


