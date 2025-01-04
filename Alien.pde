public class Alien {
  float x, y, w, h, dx, dy;
  String type;
  boolean shooting = false;
  PImage octopusStatic, octopusShooting, squidStatic, squidShooting, crabStatic, crabShooting;

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
  }
  
  public void drawAlien() {
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
        System.out.println("Incorrect type entered: " + type);
    }
  }
  
  public boolean edgeCheck() {
    if (x == 1170 || x == 30) {
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
      pointsGained += int(40 * diffMult);
    } else if (type == "crab") {
      pointsGained += int(20 * diffMult);
    } else if (type == "octopus") {
      pointsGained += int(10 * diffMult);
    }
    alienList.remove(this);
  }
}
