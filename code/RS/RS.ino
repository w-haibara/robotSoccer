/* we want to fix the RS machine
*  DC moter compose a shoot machinism doesn't react
*/
#define LEFT 13,12,10 //Left moter pins (SIG1,SIG2,PWM)
#define RIGHT 7,8,9    //Right -
#define SHOOT 2,3,6    //Shoot -

#include <VarSpeedServo.h>

VarSpeedServo servo;

void setup() {
    pinMode(2,OUTPUT);
    pinMode(3,OUTPUT);
    pinMode(7,OUTPUT);
    pinMode(8,OUTPUT);
    pinMode(13,OUTPUT);
    pinMode(12,OUTPUT);
    servo.attach(11);
}

void loop() {
    char[] com = 'front';
    switch(val){
        case('front'):
            moter(LEFT,HIGH,LOW,255);
            moter(RIGHT,HIGH,LOW,255);
            break;
        case('rear'):
            moter(LEFT,LOW,HIGH,255);
            moter(RIGHT,LOW,HIGH,255);
            break;
        case('left'):
            moter(LEFT,LOW,HIGH,255);
            moter(RIGHT,HIGH,LOW,,255);
            break;
        case('right'):
            moter(LEFT,HIGH,LOW,255);
            moter(RIGHT,LOW,HIGH,255);
            break;




    }
//    servo.write(0, 255, true);
}

void moter(int I1Pin,int I2Pin,int pwmPin, int I1, int I2, int pwm) {

    analogWrite(pwmPin,pwm);

    digitalWrite(I1Pin,I1);
    digitalWrite(I2Pin,I2);
}
