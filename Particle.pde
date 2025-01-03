public class Particle {
  float x, y, w, h;
  int downCurv = int(random(10, 501));
  int dx = int(random(-2, 3));
  int[] rgb = new int[3];
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    for (int i = 0; i < rgb.length; i++) {
      rgb[i] = (int(random(0, 256)));
    }
    w = int(random(8, 13));
    h = int(random(8, 13));
  }
  public void drawParticle() {
    noStroke();
    rectMode(CENTER);
    fill(rgb[0], rgb[1], rgb[2]);
    x += dx;
    y += 1 + (x * 1/downCurv);
    rect(x, y, w, h);
    w -= .1;
    h -= .1;
    
  }
}
