/* we want to fix the RS machine
   DC moter compose a shoot machinism doesn't react
*/
#define LEFT 13,12,10 //Left moter pins (SIG1,SIG2,PWM)
#define RIGHT 7,8,9    //Right moter pins (SIG1,SIG2,PWM)
#define SHOOT 2,3,6    //Shoot moter pins (SIG1,SIG2,PWM)

#include <VarSpeedServo.h>

VarSpeedServo servo;

int re; // 受信データ

void setup() {
  Serial.begin(9600);

  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  servo.attach(11);
}

void loop() {
  static byte drive = B00000000; /*前半4bitは右モーター，後半4bitは左モーター
                                  *それぞれの4bitについて
                                  *前半1bitは1で正転，1で逆転
                                  *後半3bitで8段階で指定する
                                  */
                                 
  static byte shoot = B00000000; /*前半1bitでshootするかどうか
                                  *後半の7bitでサーボの回転角を0〜128度の値で指定する
                                  */
  // 受信バッファに（ヘッダ＋byte*4）以上のデータが着ているか確認
  if ( Serial.available() >= sizeof('H') + sizeof(byte) * 4 ) {
    // ヘッダの確認
    if ( Serial.read() == 'H' ) {
      drive = Serial.read();
      shoot = Serial.read();
    }
  }
  
  
}

void moter(int In1Pin, int In2Pin, int pwmPin, int In1, int In2, int pwm) {

  analogWrite(pwmPin, pwm);

  digitalWrite(In1Pin, In1);
  digitalWrite(In2Pin, In2);
}
/*
   switch (val) {
  case ('front'):
  moter(LEFT, HIGH, LOW, 255);
  moter(RIGHT, HIGH, LOW, 255);
  break;
  case ('rear'):
  moter(LEFT, LOW, HIGH, 255);
  moter(RIGHT, LOW, HIGH, 255);
  break;
  case ('left'):
  moter(LEFT, LOW, HIGH, 255);
  moter(RIGHT, HIGH, LOW, , 255);
  break;
  case ('right'):
  moter(LEFT, HIGH, LOW, 255);
  moter(RIGHT, LOW, HIGH, 255);
  break;

*/
