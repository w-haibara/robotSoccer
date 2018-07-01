/* we want to fix the RS machine
    DCmoter compose a shoot machinism doesn't react
*/


#include <VarSpeedServo.h>

VarSpeedServo servo;

void setup() {
    pinMode(5, OUTPUT);
    pinMode(6, OUTPUT);
    servo.attach(11);
}

void loop() {

/*    moter('l', HIGH, LOW, 500, 255);
    moter('l', HIGH, HIGH, 500, 255);

    moter('r', HIGH, LOW, 500, 200);
    moter('r', HIGH, HIGH, 500, 255);

    moter('s', HIGH, LOW, 500, 200);
    moter('s', HIGH, HIGH, 500, 255);
    delay(500);

    servo.write(0, 255, true);
*/
}

void moter(char type, int I1, int I2, int pwm) {

    int pins[] = {0, 0, 0}; //pinI1, pinI2, pinPWM

    switch (type) {
        case 'l':
            pins[0] = 13;
            pins[1] = 12;
            pins[2] = 10;
           break;

        case 'r':
            pins[0] = 7;
            pins[1] = 8;
            pins[2] = 9;
            break;

        case 's':
            pins[0] = 2;
            pins[1] = 3;
            pins[2] = 6;
            break;
    }

    analogWrite(pins[2], pwm);

    digitalWrite(pins[0], I1);
    digitalWrite(pins[1], I2);
}

void ford(){
    moter('l',HIGH,LOW,255);
    moter('l',HIGH,LOW,255);
}
