abstract class Laser {
  protected float x, y, w, h, dy;
  
  protected Laser(float x, float y) {
    this.x = x;
    this.y = y;
    w = 5;
    h = 10;
  }
  
  protected void drawLaser() {
    rectMode(CENTER);
    noStroke();
    rect(x, y, w, h);
  }
  
  protected boolean hitLaser(float ex, float ey, float ew, float eh) {
    // e for entity (specifically the player)
    if (x - w/2 <= ex + ew/2 && x + w/2 >= ex - ew/2 && y + h/2 >= ey - eh/2 && y - h/2 <= ey + eh/2) {
      return true;
    } else {
      return false;
    }
  }
  
  protected void shoot() {
    y += dy;
  }
  
  abstract protected void removeLaser();
}
