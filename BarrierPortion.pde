public class BarrierPortion {
  float x, y, w, h;
  int lives;
  final int LIVES;
  BarrierPortion(float x, float y, int lives) {
    this.x = x;
    this.y = y;
    this.lives = lives;
    this.LIVES = lives;
    w = 40;
    h = 30;
  }
  
  void drawPortion() {
    /*
    | | |
    | | |
    |   |
    */
    rectMode(CENTER);
    fill(255 - ((LIVES - lives) * 40));
    rect(x, y, 40, 30);
  }
  
  boolean hitPortion(float ex, float ey, float ew, float eh) {
    // e for entity (lasers)
    if (x - w/2 <= ex + ew/2 && x + w/2 >= ex - ew/2 && y + h/2 >= ey - eh/2 && y - h/2 <= ey + eh/2) {
      return true;
    } else {
      return false;
    }
  }
}
