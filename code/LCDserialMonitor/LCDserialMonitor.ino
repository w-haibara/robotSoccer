#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x3f, 16, 2); //I2Cアドレスを指定

const int dataSize = sizeof('H') + sizeof(byte) * 4;
const int LED = 13;
void setup() {
  Serial.begin(115200);
  lcd.init(); //LCDを初期化
  lcd.backlight(); //LCDのバックライトをつける
  pinMode(LED, OUTPUT);
}

void showSerial(uint8_t contNum, uint8_t cursorNum) {
  if ( Serial.available() >= dataSize ) {
    byte data[] = {0, 0, 0, 0};
    if ( Serial.read() == 'H' ) {
      data[0] = Serial.read();
      data[1] = Serial.read();
      data[2] = Serial.read();
      data[3] = Serial.read();
    }
    String out = zeroPadBin(8, data[contNum - 1]);
    lcd.setCursor(0, cursorNum - 1); //LCDの1段目に表示
    lcd.print(contNum);
    lcd.print(":");
    lcd.print(out);

    Serial.println(out);

    if ((data[contNum - 1] >> 7) == B00000001 ) {
      digitalWrite(LED, LOW);
    } else {
      digitalWrite(LED, HIGH);
    }

  }
}

String zeroPadBin(uint8_t numLength, uint8_t num) {
  /* numをnumLength桁になるようにゼロ埋めしたString型の変数で返す関数
  */

  byte minus = 0;
  if (num < 0) {
    num = abs(num);
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

void loop() {
  /*byte data[] = {0, 0, 0, 0};
    byte buuton2 = 0;
    byte buuton1 = 0;
    byte y = 0;
    byte x = 0;

    int pwm[] = {0, 100, 180, 255};
    int pwm_x = 0;
    int pwm_y = 0;*/
  showSerial(1, 1);
}

