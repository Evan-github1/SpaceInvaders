public class ShooterLaser extends Laser {
   ArrayList<Particle> particleList = new ArrayList<>();
  
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
