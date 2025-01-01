public class ShooterLaser extends Laser {
  
  //static int shooterCooldown = 0;  
  
  ShooterLaser(float x, float y) {
    super(x, y);
    dy = -5;
  }
  
  void drawLaser() {
    fill(255, 0, 0);
    super.drawLaser();
  }
  
  void removeLaser() {
    shooterLaserList.remove(this);
  }
}
