public class Button {
  float x, y, w, h, rectColor, textColor;
  String text;
  Button(float x, float y, float w, float h, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    rectColor = 255;
    textColor = 0;
  }

  public void drawButton() {
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    // hover animation
    if (!mouseOverButton()) {
      // black to white
      fill(255);
      stroke(0);
      rect(x, y, w, h);
      fill(0);
      textSize(h/2.5);
      text(text, x, y);
      
    } else {
      // white to black
      fill(0);
      stroke(255);
      rect(x, y, w, h);
      fill(255);
      textSize(h/2.5);
      text(text, x, y);
    }
  }

  public boolean mouseOverButton() {
    if (mouseX <= x + w/2 && mouseX >= x - w/2 && mouseY >= y - h/2 && mouseY <= y + h/2) {
      return true;
    } else {
      return false;
    }
  }
  
  protected boolean checkScreen(Screen buttonScreen /* enter what screen the button is */) {
    // prevents clicking nonexistent button on different screens
    if(screen == buttonScreen) {
      return true;
    } else {
      return false; 
    }
  }
  
  protected boolean activateButton(Screen buttonScreen) {
    // a shortcut so I don't need to call checkScreen() and mouseOverButton() everytime I create a new button
    if (this.mouseOverButton() && this.checkScreen(buttonScreen)) {
      return true;
    } else {
      return false;
    }
  }
  
}
