public class Shooter {
  float x, y, w, h, r, g, b, dx;
  Shooter(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    r = 135;
    g = 206;
    b = 235;
    dx = 0;
  }
  
  public void drawShooter() {
    rectMode(CENTER);
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
    rect(x, y - h/2 - h/8, w/8, h/4);
    //if (x - w/2 >= 0 && dx < 0) {
      x += dx;
    //}
  }
 
}
