#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x3f, 16, 2); //I2Cアドレスを指定

const int dataSize = sizeof('H') + sizeof(byte) * 4;

boolean button2 = false;
boolean button1 = false;
int y = 0;
int x = 0;

void setup() {
  Serial.begin(9600);
  lcd.init(); //LCDを初期化
  lcd.backlight(); //LCDのバックライトをつける
}

void loop() {
  int pwm[] = {0, 100, 180, 255};
  int pwm_l = 0;
  int pwm_r = 0;

  readSerialBit(1);

  if (button1) {
    //A・Xボタンが押されたときの処理
  }
  if (button2) {
    //B・Yボタンが押されたときの処理
  }
  /*  if (x>=B00000100) {
      switch (x | B00000011) {
        case B00000001:
        x=
          break;
          default;
      }
    }*/


  /*
    buuton2 = ;
    buuton1 = ;
    y = ;
    x = ;
  */
}

void readSerialBit(uint8_t contNum) {
  if ( Serial.available() >= dataSize ) {
    byte data[] = {0, 0, 0, 0};
    if ( Serial.read() == 'H' ) {
      data[0] = Serial.read();
      data[1] = Serial.read();
      data[2] = Serial.read();
      data[3] = Serial.read();
    }

    button2 = (data[0] >> 7) ? true : false;
    button1 = ((data[0] >> 6) & B00000001) ? true : false;

    y = (data[0] >> 3) & B00000111;
    y = (y >= B00000100) ? -(y & B00000011) : y;

    x = data[0] & B00000111;
    x = (x >= B00000100) ? -(x & B00000011) : x;

    lcd.setCursor(0, 0); //LCDの1段目に表示

    if (button1) {
      lcd.print("1");
    } else {
      lcd.print(" ");
    }

    if (button2) {
      lcd.print("2");
    } else {
      lcd.print(" ");
    }

    lcd.setCursor(0, 1);

    lcd.print("x:");
    lcd.print(x);

    lcd.print("   ");

    lcd.print("y:");
    lcd.print(y);
    lcd.print("   ");


  }
}

