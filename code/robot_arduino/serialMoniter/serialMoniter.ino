#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <VarSpeedServo.h>

LiquidCrystal_I2C lcd(0x3f, 16, 2); //I2Cアドレスを指定

uint8_t data[] = {0, 0, 0, 0};
int num = 1;
const int dataSize = sizeof('H') + sizeof(uint8_t) * 4;

void setup() {
  Serial.begin(9600);
  lcd.init(); //LCDを初期化
  lcd.backlight(); //LCDのバックライトをつける
}

void loop() {
  showSerial(1, 1);
  showSerial(2, 2);
}

void showSerial(int cursorNum, int num) {
  if ( Serial.available() >=  dataSize) {
    if ( Serial.read() == 'H' ) {
      data[0] = Serial.read();
      data[1] = Serial.read();
      data[2] = Serial.read();
      data[3] = Serial.read();
    }
  }
  String bin = binZeroPad(8, data[num]);
  lcd.setCursor(0, cursorNum - 1); //LCDの1段目に表示
  lcd.print(num);
  lcd.print(":");
  lcd.print(bin);
}

String binZeroPad(int numLength, int num) {
  /* numをnumLength桁になるようにゼロ埋めしたString型の変数で返す関数
  */
  byte minus = 0;
  if (num < 0) {
    num = abs(num + 1);
    minus = 1;
  }

  String NUM = String(num, BIN);
  String ZERO = "0";

  if (num == 0) {
    for (int i = 2; i <= numLength; i++) {
      ZERO.concat(NUM);
      NUM = ZERO;
      ZERO = "0";
    }
  } else {
    for (int i = 1; i <= numLength - minus; i++) {
      if (0 < num && num < pow(2, i - 1)) {
        ZERO.concat(NUM);
        NUM = ZERO;
        ZERO = "0";
      }
    }
  }

  if (minus == 1) {
    String MINUS = "-";
    MINUS.concat(NUM);
    NUM = MINUS;
    num = -num;
  }
  return (NUM);
}
