Screen screen;
HashMap<String, Boolean> cosmeticUnlocked = new HashMap<String, Boolean>();
int cooldown = 0;
int waitToSwitch = 0;
int shootingCooldown = 0;
int totalPoints = 0;
int bulletBoost = 1;
int powerTimer = 0;
int pointsGained = 0;
float diffMult = 1;
boolean moveDown = false;
PFont pixelFont;
ArrayList<Powerup> powerupList = new ArrayList<>();
ArrayList<Screen> prevScreen = new ArrayList<>();
ArrayList<BarrierPortion> barrier1 = new ArrayList<>();
ArrayList<BarrierPortion> barrier2 = new ArrayList<>();
ArrayList<BarrierPortion> barrier3 = new ArrayList<>();
ArrayList<Alien> alienList = new ArrayList<>();
ArrayList<AlienLaser> alienLaserList = new ArrayList<>();
ArrayList<ShooterLaser> shooterLaserList = new ArrayList<>();
Shooter shooter1 = new Shooter(600, 750, 75, 75/2);
Button playButton = new Button(600, 250, 200, 100, "PLAY");
Button easyButton = new Button(600, 250, 200, 100, "EASY");
Button mediumButton = new Button(600, 400, 250, 100, "MEDIUM");
Button hardButton = new Button(600, 550, 200, 100, "HARD");
Button backButton = new Button(1100, 750, 100, 50, "BACK");
Button cosmeticButton = new Button(600, 400, 300, 100, "COSMETICS");
Button confettiBuyButton = new Button(300, 500, 300, 100, "2000");
ShooterLaser demoLaser = new ShooterLaser(300, 400);
public void setup() {
  size(1200, 800);
  pixelFont = createFont("slkscre.ttf", 75);
  textFont(pixelFont);
  screen = Screen.MAIN_MENU;
  resetGame();
  cosmeticUnlocked.put("Confetti Trail", false);
  cosmeticUnlocked.put("Red Explosion Effect", true);
  demoLaser.dy = 0;
  demoLaser.w *= 2.5;
  demoLaser.h *= 2.5;
} 

public void draw() {
  background(0);
  cooldown++;
  if (bulletBoost != 1) {
    powerTimer++;
  }
  if (powerTimer >= 600) {
    bulletBoost = 1;
    powerTimer = 0;
  }
  switch (screen) {
    case MAIN_MENU:
      textAlign(CENTER);
      fill(255);
      textSize(75);
      text("Space Invaders", 600, 125);
      playButton.drawButton();
      cosmeticButton.drawButton();
      break;

    case COSMETICS:
      textAlign(CENTER);
      fill(255);
      textSize(75);
      text("Cosmetics Shop", 600, 125);
      textSize(20);
      text("Total Points: " + totalPoints, 150, 750);
      text("Confetti Laser Trail", 300, 350);
      backButton.drawButton();
      
      confettiBuyButton.drawButton();
      demoLaser.drawLaser();
      if (int(random(1, 16)) == 1) {
        demoLaser.particleList.add(new Particle(demoLaser.x, demoLaser.y + demoLaser.h/2));
      }
      for (int j = demoLaser.particleList.size() - 1; j >= 0; j--) {
        demoLaser.particleList.get(j).drawParticle();
        if (demoLaser.particleList.get(j).w <= 0 || demoLaser.particleList.get(j).h <= 0) {
          demoLaser.particleList.remove(j);
        }
      }
      if (cosmeticUnlocked.get("Confetti Trail")) {
        confettiBuyButton.text = "UNLOCKED";
      }
      break;

    case EASY_LEVEL:
      playGame(45, 35);
      break;

    case MEDIUM_LEVEL:
      playGame(35, 40);
      break;

    case HARD_LEVEL:
      playGame(30, 45);
      break;

    case TWO_PLAYER_MODE:
      break;
    case GAME_OVER:
      textAlign(CENTER);
      fill(220, 20, 60);
      textSize(150);
      text("GAME OVER", 600, 400, 10);
      waitToSwitch++;
      if (waitToSwitch == 180) {
        totalPoints += pointsGained;
        screen = prevScreen.get(prevScreen.size() - 1);
        prevScreen.remove(prevScreen.size() - 1);
      }
      break;
    case DIFFICULTY:
      textAlign(CENTER);
      fill(255);
      textSize(75);
      text("Select Difficulty", 600, 125, 10);
      easyButton.drawButton();
      mediumButton.drawButton();
      hardButton.drawButton();
      backButton.drawButton();
      break;
  }  
}

void keyReleased() {
  if (key == 'a' || key == 'd') {
    shooter1.dx = 0;
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == 'a' && key != 'd') {
      shooter1.dx = -8;
    } else if (key == 'd' && key != 'a') {
      shooter1.dx = 8;
    } 
  }
}

void mousePressed() {
  try {
    if (backButton.activateButton(screen)) {
      screen = prevScreen.get(prevScreen.size() - 1);
      prevScreen.remove(prevScreen.size() - 1);
    }
  } catch(IndexOutOfBoundsException IGNOREME) {
  }
  
  switch (screen) {
    case MAIN_MENU:
      if (playButton.activateButton(Screen.MAIN_MENU)) {
        prevScreen.add(screen);
        screen = Screen.DIFFICULTY;
      } else if (cosmeticButton.activateButton(Screen.MAIN_MENU)) {
        prevScreen.add(screen);
        screen = Screen.COSMETICS;
      }
      break;
    case COSMETICS:
      if (confettiBuyButton.activateButton(Screen.COSMETICS) && !cosmeticUnlocked.get("Confetti Trail")) {
        if (totalPoints >= 2000) {
          cosmeticUnlocked.put("Confetti Trail", true);
          totalPoints -= 2000;
        }
      }
      break;

    case EASY_LEVEL:
      diffMult = 1;
      if (shootingCooldown == 35) {
        shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8));
        shootingCooldown = 0;
      }
      break;
    case MEDIUM_LEVEL:
      diffMult = 1.25;
      if (shootingCooldown == 40) {
        shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8));
        shootingCooldown = 0;
      }     
      break;
    case HARD_LEVEL:
      diffMult = 1.5;
      if (shootingCooldown == 45) {
        shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8));
        shootingCooldown = 0;      
      }
      break;

    case TWO_PLAYER_MODE:
      break;
    case GAME_OVER:
      break;
      
    case DIFFICULTY:
      if (easyButton.activateButton(Screen.DIFFICULTY)) {
        resetGame();
        prevScreen.add(screen);
        screen = Screen.EASY_LEVEL;
      } else if (mediumButton.activateButton(Screen.DIFFICULTY)) {
        resetGame();
        prevScreen.add(screen);
        screen = Screen.MEDIUM_LEVEL;
      } else if (hardButton.activateButton(Screen.DIFFICULTY)) {
        resetGame();
        prevScreen.add(screen);
        screen = Screen.HARD_LEVEL;
      }
      break;
      
  }  
}

void playGame(int framesToMove, int shootingCooldown) {
  fill(255);
  textSize(20);
  text("Points: " + pointsGained, 1100, 750);
  shooter1.drawShooter();
  if (int(random(1, 500 * diffMult)) == 1) {
    powerupList.add(new Powerup(int(random(15, 1190)), int(random(15, 500))));
  }
  for (int i = powerupList.size() - 1; i >= 0; i--) {
    powerupList.get(i).drawPowerup();
  }
  if (shootingCooldown != this.shootingCooldown) {
    this.shootingCooldown++;
  }
  for (int i = 0; i < barrier1.size(); i++) {
    BarrierPortion b = barrier1.get(i);
    b.drawPortion();
    if (b.lives == 0) {
      barrier1.remove(i);
    }
  }
  for (int i = 0; i < barrier2.size(); i++) {
    BarrierPortion b = barrier2.get(i);
    b.drawPortion();
    if (b.lives == 0) {
      barrier2.remove(i);
    }
  }
  for (int i = 0; i < barrier3.size(); i++) {
    BarrierPortion b = barrier3.get(i);
    b.drawPortion();
    if (b.lives == 0) { 
      barrier3.remove(i);
    }
  }

  
  for (int i = 0; i < alienList.size(); i++) {
    Alien a = alienList.get(i);
    a.drawAlien();
    if (a.y + 75 >= shooter1.y) {
      screen = Screen.GAME_OVER;
    }
    if ((int) random(1, alienList.size() + 1) == 1 && a.shooting && cooldown == 1) {
      alienLaserList.add(new AlienLaser(a.x + a.w/2, a.y + a.h/2));
    }
    
    if (a.edgeCheck()) {
      for (int j = 0; j < alienList.size(); j++) {
        Alien all = alienList.get(j);
        all.dx *= -1; 
        all.y += all.dy;
        all.moveAlien();
        all.shooting = false;
      }
    }
    for (int i2 = 0; i2 < barrier1.size(); i2++) {
      BarrierPortion b = barrier1.get(i2);
      if (b.hitPortion(a.x, a.y, a.w, a.h)) {
        b.lives = 0;
      }
    }
    for (int i2 = 0; i2 < barrier2.size(); i2++) {
      BarrierPortion b = barrier2.get(i2);
      if (b.hitPortion(a.x, a.y, a.w, a.h)) {
        b.lives = 0;
      }
    }
    for (int i2 = 0; i2 < barrier3.size(); i2++) {
      BarrierPortion b = barrier3.get(i2);
      if (b.hitPortion(a.x, a.y, a.w, a.h)) {
        b.lives = 0;
      }
    }
    if (cooldown == framesToMove) {
      a.moveAlien();
    }
  }
  
  for (int i = 0; i < alienLaserList.size(); i++) {
    AlienLaser a = alienLaserList.get(i);
    a.drawLaser();
    a.shoot();
    if (a.hitLaser(shooter1.x, shooter1.y, shooter1.w, shooter1.h)) {
      waitToSwitch = 0;
      screen = Screen.GAME_OVER;
      alienLaserList.remove(i);
    }
    if (a.y + a.h/2 >= 800) {
      alienLaserList.remove(i);
    }
    
    for (int i2 = 0; i2 < barrier1.size(); i2++) {
      BarrierPortion b = barrier1.get(i2);
      if (a.hitLaser(b.x, b.y, b.w, b.h)) {
        b.lives--;
        a.removeLaser();
      }
    }
    for (int i2 = 0; i2 < barrier2.size(); i2++) {
      BarrierPortion b = barrier2.get(i2);
      if (a.hitLaser(b.x, b.y, b.w, b.h)) {
        b.lives--;
        a.removeLaser();
      }
    }
    for (int i2 = 0; i2 < barrier3.size(); i2++) {
      BarrierPortion b = barrier3.get(i2);
      if (a.hitLaser(b.x, b.y, b.w, b.h)) {
        b.lives--;
        a.removeLaser();
      }
    }
  }  
  
  for (int i = shooterLaserList.size() - 1; i >= 0; i--) {
    ShooterLaser s = shooterLaserList.get(i);
    s.drawLaser();
    s.shoot();
    for (int j = powerupList.size() - 1; j >= 0; j--) {
      powerupList.get(j).hitPowerup(s.x, s.y, s.w, s.h);
    }
    // particle trail
    if (cosmeticUnlocked.get("Confetti Trail")) {
      if (s.y - s.h/2 <= 0) {
        shooterLaserList.remove(i);
      }
      if (int(random(1, 16)) == 1) {
        s.particleList.add(new Particle(s.x, s.y + s.h/2));
      }
      for (int j = s.particleList.size() - 1; j >= 0; j--) {
        s.particleList.get(j).drawParticle();
        if (s.particleList.get(j).w <= 0 || s.particleList.get(j).h <= 0) {
          s.particleList.remove(j);
        }
      }
    }
    
    for (int j = alienList.size() - 1; j >= 0; j--) {
      Alien a = alienList.get(j);
  
      if (s.hitLaser(a.x, a.y, a.w, a.h) && !a.death) {
        a.killAlien();
        a.death = true;
        shooterLaserList.remove(i);
      }
    }
    
    for (int i2 = 0; i2 < barrier1.size(); i2++) {
      BarrierPortion b = barrier1.get(i2);
      if (s.hitLaser(b.x, b.y, b.w, b.h)) {
        b.lives--;
        s.removeLaser();
      }
    }
    for (int i2 = 0; i2 < barrier2.size(); i2++) {
      BarrierPortion b = barrier2.get(i2);
      if (s.hitLaser(b.x, b.y, b.w, b.h)) {
        b.lives--;
        s.removeLaser();
      }
    }
    for (int i2 = 0; i2 < barrier3.size(); i2++) {
      BarrierPortion b = barrier3.get(i2);
      if (s.hitLaser(b.x, b.y, b.w, b.h)) {
        b.lives--;
        s.removeLaser();
      }
    }
  }
  
  if (alienList.isEmpty()) {
    renewGame();
  }
  // how long it takes for the aliens to move, affected by difficulty
  if (cooldown == framesToMove) {
    cooldown = 0;
  }
}

void resetGame() {
  // removing all aliens from the list, assuming there are
  shootingCooldown = 0;
  cooldown = 0;
  alienList.clear();
  alienLaserList.clear();
  shooterLaserList.clear();
  powerupList.clear();
  pointsGained = 0;
  shooter1.x = 600;
  // refreshing with new aliens
  for (int i = 0; i < 5; i++) {
    for (int i2 = 0; i2 < 11; i2++) {
      
      if (i == 0) {
        alienList.add(new Alien(i2 * 100 + 50, i * 75 + 25, "squid"));
      } else if (i == 1 || i == 2) {
        alienList.add(new Alien(i2 * 100 + 50, i * 75 + 25, "crab"));
      } else if (i == 3 || i == 4) {
        alienList.add(new Alien(i2 * 100 + 50, i * 75 + 25, "octopus"));
      }
    }  
  }
  
  for (int i = 0; i < 3; i++) {
    for (int i2 = 0; i2 < 3; i2++) {
    if (!(i == 1 && i2 == 2)) {
        barrier1.add(new BarrierPortion(270 + i * 40, 570 + i2 * 30, 3));
        barrier2.add(new BarrierPortion(570 + i * 40, 570 + i2 * 30, 3));
        barrier3.add(new BarrierPortion(870 + i * 40, 570 + i2 * 30, 3));
      } 
    }
  }
}


void renewGame() {
  // removing all aliens from the list, assuming there are
  shootingCooldown = 0;
  cooldown = 0;
  alienList.clear();
  alienLaserList.clear();
  shooterLaserList.clear();
  // refreshing with new aliens
  for (int i = 0; i < 5; i++) {
    for (int i2 = 0; i2 < 11; i2++) {
      
      if (i == 0) {
        alienList.add(new Alien(i2 * 100 + 50, i * 75 + 25, "squid"));
      } else if (i == 1 || i == 2) {
        alienList.add(new Alien(i2 * 100 + 50, i * 75 + 25, "crab"));
      } else if (i == 3 || i == 4) {
        alienList.add(new Alien(i2 * 100 + 50, i * 75 + 25, "octopus"));
      }
    }  
  }
}
