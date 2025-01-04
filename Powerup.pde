public class Powerup {
  float x, y, wh;
  int type = int(random(0, 1));
  Powerup(float x, float y) {
    this.x = x;
    this.y = y;
    wh = 20;
  }
  
  public void drawPowerup() {
    rectMode(CENTER);
    noStroke();
    fill(123, 123, 123);
    rect(x, y, wh, wh);
  }
  
  void hitPowerup(float ex, float ey, float ew, float eh) {
    // e for entity (player lasers)
    if (x - wh/2 <= ex + ew/2 && x + wh/2 >= ex - ew/2 && y + wh/2 >= ey - eh/2 && y - wh/2 <= ey + eh/2) {
      switch (type) {
      case 0:
        // kills 5 enemies randomly
        try {
          for (int i = 0; i <= 4; i++) {
            alienList.get(int(random(0, alienList.size() - 1))).killAlien();
          }
        } catch (IndexOutOfBoundsException IGNOREME) {
        }
        break;
      case 1:
        break;
        // repairs barriers
      default:
        System.out.println("Error! Type dosn't exist: " + type);
      }
      powerupList.remove(this);
    }
  }
}
