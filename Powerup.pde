public class Powerup {
  float x, y, wh;
  int type = int(random(0, 3));
  int lifeSpan = 0;
  int powerLasting = 0;
  Powerup(float x, float y) {
    this.x = x;
    this.y = y;
    wh = 30;
  }
  
  public void drawPowerup() {
    lifeSpan++;
    rectMode(CENTER);
    noStroke();
    switch (type) {
      case 0:
        fill(160, 32, 240);
        break;
      case 1:
        fill(2, 48, 32);
        break;
      case 2:
        fill(255, 127, 80);
        break;
      default:
        System.out.println("Error! Type doesn't exist: " + type); 
        break;
    }
    rect(x, y, wh, wh);
    if (lifeSpan >= 480/diffMult) {
      powerupList.remove(this);
    }
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
        // repairs barriers
        barrier1.clear();
        barrier2.clear();
        barrier3.clear();
        for (int i = 0; i < 3; i++) {
          for (int i2 = 0; i2 < 3; i2++) {
            if (!(i == 1 && i2 == 2)) {
                barrier1.add(new BarrierPortion(270 + i * 40, 570 + i2 * 30, 3));
                barrier2.add(new BarrierPortion(570 + i * 40, 570 + i2 * 30, 3));
                barrier3.add(new BarrierPortion(870 + i * 40, 570 + i2 * 30, 3));
              } 
          }
        }
        break;
      case 2:
        bulletBoost = 3;
        break;
      default:
        System.out.println("Error! Type dosn't exist: " + type);
        break;
      }
      powerupList.remove(this);
    }
  }
}
