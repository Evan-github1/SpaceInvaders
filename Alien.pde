public class Alien {
  float x, y, w, h, dx, dy;
  String type;
  boolean shooting = false;
  PImage octopusStatic, octopusShooting, squidStatic, squidShooting, crabStatic, crabShooting, redExplosion, blueExplosion, greenExplosion;
  int explosionDuration = 0;
  int lastHit = 1020;
  int rageTimer = 0;
  int prevLives = shooter1.lives;
  boolean death = false;
  Alien(float x, float y, String type) {
    this.x = x;
    this.y = y;
    dx = 20;
    dy = 25;
    this.type = type;
    imageMode(CENTER);
    octopusStatic = loadImage("OctopusStatic.png");
    octopusShooting = loadImage("OctopusShooting.png");
    squidStatic = loadImage("SquidStatic.png");
    squidShooting = loadImage("SquidShooting.png");
    crabStatic = loadImage("CrabStatic.png");
    crabShooting = loadImage("CrabShooting.png");
    redExplosion = loadImage("RedExplosion.png");
    greenExplosion = loadImage("GreenExplosion.png");
    blueExplosion = loadImage("BlueExplosion.png");
  }
  
  public void drawAlien() {
    if (!death) {
      switch (type) {
        case "squid":
          w = 32;
          h = 32;
          if (!shooting) {
            image(squidStatic, x, y);
          } else {
            image(squidShooting, x, y);
          }
          break;
        case "crab":
          w = 44;
          h = 32;
          if (!shooting) {
            image(crabStatic, x, y);
          } else {
            image(crabShooting, x, y);
          }        
          break;
        case "octopus":
          w = 48;
          h = 32;
          if (!shooting) {
            image(octopusStatic, x, y);
          } else {
            image(octopusShooting, x, y);
          }        
          break;
        default:
          System.out.println("Error! Incorrect type entered: " + type);
      }
    } else {
      w = 32;
      h = 32;
      switch (currentEffect) {
        case "Red Explosion Effect":
          image(redExplosion, x, y);
          break;
        case "Blue Explosion Effect":
          image(blueExplosion, x, y);
          break;
        case "Green Explosion Effect":
          image(greenExplosion, x, y);
          break;      
      }
      explosionDuration++;
      if (explosionDuration >= 60) {
        alienList.remove(this);  
      }
    }
  }
  
  public boolean edgeCheck() {
    if (x == 1170 || x == 30 && !death) {
      return true;  
    } else {
      return false;
    }
  }
  
  public void moveAlien() {
    x += dx;
    if (!shooting) {
      shooting = true;
    } else {
      shooting = false;
    }
  }
  
  public void killAlien() {
    if (type == "squid") {
      pointsGained += int(40 * screen.DIFFMULT);
    } else if (type == "crab") {
      pointsGained += int(20 * screen.DIFFMULT);
    } else if (type == "octopus") {
      pointsGained += int(10 * screen.DIFFMULT);
    }
    if (currentEffect != null && explosionDuration <= 60) {
      death = true;
    } else {
      alienList.remove(this);
    }
  }
  
  boolean alienRage() {
    if (lastHit <= 300 && lastHit >= 0) {
      textAlign(CENTER);
      fill(139, 0, 0);
      textSize(75);
      text("Alien Rage in " + int(lastHit/60), 600, 125);
    }
    if (rageTimer == 420) {
      rageTimer = 0;
      resetRage();
      return false;
    } else if (lastHit <= 0 && prevLives <= shooter1.lives) {
      return true;
    } else {
      return false;
    }
  }
  
  void resetRage() {
    prevLives = shooter1.lives;
    lastHit = 1020;
  }
}
