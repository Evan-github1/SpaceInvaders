public class Shooter {
  float x, y, w, h, r, g, b, dx;
  int lives;
  Shooter(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    r = 135;
    g = 206;
    b = 235;
    dx = 0;
    lives = 2;
  }
  
  public void drawShooter() {
    rectMode(CENTER);
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
    rect(x, y - h/2 - h/8, w/8, h/4);
    x += dx;
    x = constrain(x, w/2, 1200 - w/2);
  }
 
}
