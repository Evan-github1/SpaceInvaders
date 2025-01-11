public class Powerup {
  PImage killPowerup, repairBarriersPowerup, bulletBoostPowerup, healPowerup, calmPowerup, speedBoostPowerup;
  float x, y, wh;
  int type = int(random(0, 6));
  int lifeSpan = 0;
  int powerLasting = 0;
  Powerup(float x, float y) {
    this.x = x;
    this.y = y;
    wh = 30;
    killPowerup = loadImage("killPowerup.png");
    repairBarriersPowerup = loadImage("repairBarriers.png");
    bulletBoostPowerup = loadImage("bulletBoost.png");
    healPowerup = loadImage("heal.png");
    calmPowerup = loadImage("calmAliens.png");
    speedBoostPowerup = loadImage("speedBoost.png");
  }
  
  public void drawPowerup() {
    lifeSpan++;
    rectMode(CENTER);
    noStroke();
    switch (type) {
      case 0:
        image(killPowerup, x, y);
        break;
      case 1:
        image(repairBarriersPowerup, x, y);
        break;
      case 2:
        image(bulletBoostPowerup, x, y);
        break;
      case 3:
        image(healPowerup, x, y);
        break;
      case 4:
        image(calmPowerup, x, y);
        break;
      case 5:
        image(speedBoostPowerup, x, y);
        break;
      default:
        System.out.println("Error! Type doesn't exist: " + type); 
        break;
    }
    if (lifeSpan >= 480/screen.DIFFMULT) {
      powerupList.remove(this);
    }
  }
  
  void hitPowerup(float ex, float ey, float ew, float eh) {
    // e for entity (player lasers)
    if (x - wh/2 <= ex + ew/2 && x + wh/2 >= ex - ew/2 && y + wh/2 >= ey - eh/2 && y - wh/2 <= ey + eh/2) {
      switch (type) {
      case 0:
        // kills up to 5 enemies randomly
        // try catch statement needed in case there are less than 5 enemies remaining
        try {
          for (int i = 0; i <= 4; i++) {
            alienList.get(int(random(0, alienList.size() - 1))).killAlien();
          }
        } catch (IndexOutOfBoundsException IGNOREME) {
          // ignore the exception; needed to prevent program from crashing
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
      case 3:
        if (shooter1.lives < 6) {
          shooter1.lives++;
        }
        break;
      case 4:
        for (int i = 0; i < alienList.size(); i++) {
          alienList.get(i).resetRage();
        }
        break;
      case 5:
        speedBoost = 3;
        break;
      default:
        System.out.println("Error! Type dosn't exist: " + type);
        break;
      }
      powerupList.remove(this);
    }
  }
}
