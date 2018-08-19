import java.io.IOException;

void setup () {

  size (100,100);

  try {
    
Runtime runtime = Runtime.getRuntime ();
    runtime.exec ("notepad.exe");
  } 
  catch (IOException ex) {
    ex.printStackTrace ();
  }
}

void draw () {
}
