public class ShooterLaser extends Laser {
  ArrayList<Particle> particleList = new ArrayList<>();
  boolean posFun = false;
  float atomX = x + 20, atomY;
  float atomX2 = x - 20, atomY2;
  boolean TRUEDEMO;
  boolean demo;
  ShooterLaser(float x, float y, boolean demo) {
    super(x, y);
    dy = -5 * speedBoost;
    w = 5 * bulletBoost;
    h = 10 * bulletBoost;
    this.demo = demo;
  }
  
  void drawLaser() {
    fill(255, 0, 0);
    super.drawLaser();
    
    // Arhan helped me implement the atom 
    if ((currentTrail == "Atom Trail" && !demo) || TRUEDEMO) {
      // boolean TRUEDEMO only used for demo laser in COSMETICS, not the best way to implement though
      if (posFun){
        atomX += 1;
        atomX2 -= 1;
        atomY = sqrt(pow(20, 2) - pow((atomX - x), 2)) + y;
        atomY2 = -(sqrt(pow(20, 2) - pow((atomX - x), 2))) + y;
        if (atomX == x + 20) {
          posFun = !posFun;
        }
      } else {
        atomX -= 1;
        atomX2 += 1;
        atomY = -(sqrt(pow(20, 2) - pow((atomX - x), 2))) + y;
        atomY2 = sqrt(pow(20, 2) - pow((atomX - x), 2)) + y;
        if (atomX == x - 20) {
          posFun = !posFun;
        }
      }
      fill(124, 176, 109);
      ellipse(atomX, atomY, 5, 5);
      fill(53, 81, 92);
      ellipse(atomX2, atomY2, 5, 5);
    }
  }
  
  void removeLaser() {
    shooterLaserList.remove(this);
  }
}
