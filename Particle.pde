// class only for confetti trail effect
public class Particle {
  float x, y, w, h;
  int downCurv = int(random(10, 501));
  int dx = int(random(-2, 3));
  int[] rgb = new int[3];
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    // randomizes color
    for (int i = 0; i < rgb.length; i++) {
      rgb[i] = (int(random(0, 256)));
    }
    w = int(random(8, 13)) * bulletBoost;
    h = int(random(8, 13)) * bulletBoost;
  }
  public void drawParticle() {
    noStroke();
    rectMode(CENTER);
    fill(rgb[0], rgb[1], rgb[2]);
    x += dx;
    // movement downwards is random
    y += 1 + (x * 1/downCurv);
    rect(x, y, w, h);
    w -= .1;
    h -= .1;
  }
}
