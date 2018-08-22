#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x3f, 16, 2); //I2Cアドレスを指定

int dataSize = sizeof('H') + sizeof(byte) * 4

void setup() {
  Serial.begin(9600);
  lcd.init(); //LCDを初期化
  lcd.backlight(); //LCDのバックライトをつける
}

void loop() {
  byte data[] = {0, 0, 0, 0};
  byte buuton2 = 0;
  byte buuton1 = 0;
  byte y = 0;
  byte x = 0;

  int pwm[] = {0, 100, 180, 255};
  int pwm_x = 0;
  int pwm_y = 0;
}
void showSerial() {
  if ( Serial.available() >= dataSize ) {
    if ( Serial.read() == 'H' ) {
      data[0] = Serial.read();
      data[1] = Serial.read();
      data[2] = Serial.read();
      data[3] = Serial.read();
    }
  }
}

