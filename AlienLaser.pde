public class AlienLaser extends Laser {
  
  AlienLaser(float x, float y) {
    super(x, y);
    dy = 5;
  }
  
  void drawLaser() {
    fill(255, 0, 0);
    super.drawLaser();
  }
  
  void removeLaser() {
    alienLaserList.remove(this);
  }
}
