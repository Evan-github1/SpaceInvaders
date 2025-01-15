// creating variables
HashMap<String, Boolean> cosmeticUnlocked = new HashMap<String, Boolean>();
int cooldown = 0;
int waitToSwitch = 0;
int shootingCooldown = 0;
int totalPoints = 20000;
int bulletBoost = 1;
int speedBoost = 1;
int speedBoostTimer = 0;
int bulletBoostTimer = 0;
int pointsGained = 0;
int round = 0;
PImage redExplosionDemo, blueExplosionDemo, greenExplosionDemo;
boolean moveDown = false;
PFont pixelFont;
ArrayList<BuyButton> explosionEffects = new ArrayList<>();
ArrayList<BuyButton> trailEffects = new ArrayList<>();
ArrayList<Powerup> powerupList = new ArrayList<>();
ArrayList<Screen> prevScreen = new ArrayList<>();
ArrayList<BarrierPortion> barrier1 = new ArrayList<>();
ArrayList<BarrierPortion> barrier2 = new ArrayList<>();
ArrayList<BarrierPortion> barrier3 = new ArrayList<>();
ArrayList<Alien> alienList = new ArrayList<>();
ArrayList<AlienLaser> alienLaserList = new ArrayList<>();
ArrayList<ShooterLaser> shooterLaserList = new ArrayList<>();
Screen screen;
Shooter shooter1 = new Shooter(600, 750, 75, 75/2);
ShooterLaser demoConfettiLaser = new ShooterLaser(300, 400, true);
ShooterLaser demoAtomLaser = new ShooterLaser(900, 400, true);
Button playButton = new Button(600, 250, 200, 100, "PLAY");
Button easyButton = new Button(600, 250, 200, 100, "EASY");
Button mediumButton = new Button(600, 400, 250, 100, "MEDIUM");
Button hardButton = new Button(600, 550, 200, 100, "HARD");
Button backButton = new Button(1100, 750, 100, 50, "BACK");
Button cosmeticButton = new Button(600, 400, 300, 100, "COSMETICS");
BuyButton confettiBuyButton = new BuyButton(300, 500, 325, 100, "2000", "Confetti Trail", "trail");
BuyButton atomBuyButton = new BuyButton(900, 500, 325, 100, "2000", "Atom Trail", "trail");
BuyButton redExplosionBuyButton = new BuyButton(250, 500, 325, 100, "1000", "Red Explosion Effect", "effect");
BuyButton blueExplosionBuyButton = new BuyButton(600, 500, 325, 100, "1500", "Blue Explosion Effect", "effect");
BuyButton greenExplosionBuyButton = new BuyButton(950, 500, 325, 100, "1500", "Green Explosion Effect", "effect");
Button nextButton = new Button(1100, 650, 100, 50, "NEXT");
String currentTrail = null;
String currentEffect = null;

public void setup() {
  size(1200, 800);
  // sets font to pixelated font
  pixelFont = createFont("slkscre.ttf", 75);
  textFont(pixelFont);
  screen = Screen.MAIN_MENU;
  // creates cosmetics
  cosmeticUnlocked.put("Confetti Trail", false);
  cosmeticUnlocked.put("Atom Trail", false);
  cosmeticUnlocked.put("Red Explosion Effect", false);
  cosmeticUnlocked.put("Blue Explosion Effect", false);
  cosmeticUnlocked.put("Green Explosion Effect", false);
  explosionEffects.add(redExplosionBuyButton);
  explosionEffects.add(blueExplosionBuyButton);
  explosionEffects.add(greenExplosionBuyButton);
  trailEffects.add(confettiBuyButton);
  trailEffects.add(atomBuyButton);
  // sets demo cosmetics' to look bigger and still (displayed in COSMETICS)
  demoConfettiLaser.dy = 0;
  demoConfettiLaser.w *= 2.5;
  demoConfettiLaser.h *= 2.5;
  demoAtomLaser.dy = 0;
  demoAtomLaser.w *= 2.5;
  demoAtomLaser.h *= 2.5;
  // loads images for explosions
  redExplosionDemo = loadImage("RedExplosion.png");
  blueExplosionDemo = loadImage("BlueExplosion.png");
  greenExplosionDemo = loadImage("GreenExplosion.png");
  demoAtomLaser.TRUEDEMO = true;
}

public void draw() {
  background(0);
  cooldown++;
  // speed and size boost timers (doesn't stack nor reset)
  if (bulletBoost != 1) {
    bulletBoostTimer++;
  }
  if (bulletBoostTimer >= 600) {
    bulletBoost = 1;
    bulletBoostTimer = 0;
  }
  if (speedBoost != 1) {
    speedBoostTimer++;
  }
  if (speedBoostTimer >= 600) {
    speedBoost = 1;
    speedBoostTimer = 0;
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
    text("Atom Laser Trail", 900, 350);
    backButton.drawButton();
    nextButton.drawButton();
    confettiBuyButton.drawButton();
    atomBuyButton.drawButton();
    demoAtomLaser.drawLaser();
    demoConfettiLaser.drawLaser();
    // demo laser's confetti
    if (int(random(1, 16)) == 1) {
      demoConfettiLaser.particleList.add(new Particle(demoConfettiLaser.x, demoConfettiLaser.y + demoConfettiLaser.h/2));
    }
    for (int j = demoConfettiLaser.particleList.size() - 1; j >= 0; j--) {
      demoConfettiLaser.particleList.get(j).drawParticle();
      if (demoConfettiLaser.particleList.get(j).w <= 0 || demoConfettiLaser.particleList.get(j).h <= 0) {
        demoConfettiLaser.particleList.remove(j);
      }
    }
    break;

  // gamemodes, difficulty scales
  case EASY_LEVEL:
    playGame(45, 35);
    break;

  case MEDIUM_LEVEL:
    playGame(35, 40);
    break;

  case HARD_LEVEL:
    playGame(30, 45);
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
  case COSMETICS_2:
    // page 2 of cosmetics
    textAlign(CENTER);
    fill(255);
    textSize(75);
    text("Cosmetics Shop", 600, 125);
    textSize(20);
    text("Total Points: " + totalPoints, 150, 750);
    text("Red Explosion\nEffect", redExplosionBuyButton.x, 350);
    text("Blue Explosion\nEffect", blueExplosionBuyButton.x, 350);
    text("Green Explosion\nEffect", greenExplosionBuyButton.x, 350);
    backButton.drawButton();
    redExplosionBuyButton.drawButton();
    blueExplosionBuyButton.drawButton();
    greenExplosionBuyButton.drawButton();
    image(redExplosionDemo, redExplosionBuyButton.x, 400);
    image(blueExplosionDemo, blueExplosionBuyButton.x, 400);
    image(greenExplosionDemo, greenExplosionBuyButton.x, 400);
    break;
}
}
  // movements
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
  
  // shooting and going to screens
void mousePressed() {
  // goes to the previous screen
  // try catch needed because you are able to press the back button on different screens, doing so will cause an index out of bounds error
  try {
    if (backButton.activateButton(screen)) {
      screen = prevScreen.get(prevScreen.size() - 1);
      prevScreen.remove(prevScreen.size() - 1);
    }
  }
  catch(IndexOutOfBoundsException IGNOREME) {
    // ignore this exception; needed to prevent the program from crashing
  }

    // different screens linked to different buttons
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
    if (confettiBuyButton.activateButton(Screen.COSMETICS)) {
      confettiBuyButton.buyItem(2000);
    } else if (atomBuyButton.activateButton(Screen.COSMETICS)) {
      atomBuyButton.buyItem(2000);
    }
    if (nextButton.activateButton(Screen.COSMETICS)) {
      prevScreen.add(screen);
      screen = Screen.COSMETICS_2;
    }
    break;
    // shooting cooldown scales with difficulty
  case EASY_LEVEL:
    if (shootingCooldown == 35) {
      shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8, false));
      shootingCooldown = 0;
    }
    break;
  case MEDIUM_LEVEL:
    if (shootingCooldown == 40) {
      shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8, false));
      shootingCooldown = 0;
    }
    break;
  case HARD_LEVEL:
    if (shootingCooldown == 45) {
      shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8, false));
      shootingCooldown = 0;
    }
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
  case COSMETICS_2:
    if (redExplosionBuyButton.activateButton(Screen.COSMETICS_2)) {
      redExplosionBuyButton.buyItem(1000);
    } else if (blueExplosionBuyButton.activateButton(Screen.COSMETICS_2)) {
      blueExplosionBuyButton.buyItem(1500);
    } else if (greenExplosionBuyButton.activateButton(Screen.COSMETICS_2)) {
      greenExplosionBuyButton.buyItem(1500);
    }
    break;
  }
}

void playGame(int framesToMove, int shootingCooldown) {
  waitToSwitch = 0;
  fill(255);
  textSize(20);
  text("Points: " + pointsGained, 1100, 750);  
  text("Lives: " + shooter1.lives, 1100, 710);
  text("Round: " + (round + 1), 1100, 670);  
  shooter1.drawShooter();
  // shooter dies
  if (shooter1.lives == 0) {
    waitToSwitch = 0;
    screen = Screen.GAME_OVER;
  }
  // powerups spawning, rarer the higher difficulty
  if (int(random(1, 400 * screen.DIFFMULT)) == 1) {
    powerupList.add(new Powerup(int(random(15, 1190)), int(random(15, 500))));
  }
  for (int i = powerupList.size() - 1; i >= 0; i--) {
    powerupList.get(i).drawPowerup();
  }
  // shooting timer
  if (shootingCooldown != this.shootingCooldown) {
    this.shootingCooldown++;
  }
  // drawing all barriers
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

  for (int i = alienList.size() - 1; i >= 0; i--) {
    // alien rage
    Alien a = alienList.get(i);
    a.drawAlien();
    a.lastHit--;
    if (a.alienRage()) {
      alienList.get(i).rageTimer++;
    }
    if (a.y + 75 >= shooter1.y && !a.death) {
      screen = Screen.GAME_OVER;
    }
    if ((int) random(1, alienList.size() + 1) == 1 && a.shooting && cooldown == 1 && !a.death) {
      alienLaserList.add(new AlienLaser(a.x + a.w/2, a.y + a.h/2));
    }
    
    // moving downwards
    if (a.edgeCheck()) {
      for (int j = 0; j < alienList.size(); j++) {
        Alien all = alienList.get(j);
        all.dx *= -1;
        all.y += all.dy;
        all.moveAlien();
        all.shooting = false;
      }
    }
    // destroying barriers once touching it
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
    if (a.alienRage() && (cooldown >= int((framesToMove - (round * 5))/2))) {
      a.moveAlien();
    } else if (cooldown >= framesToMove - (round * 5)) {
      a.moveAlien();
    }
  }
  // alien lasers
  for (int i = 0; i < alienLaserList.size(); i++) {
    AlienLaser a = alienLaserList.get(i);
    a.drawLaser();
    a.shoot();
    // hit detection
    if (a.hitLaser(shooter1.x, shooter1.y, shooter1.w, shooter1.h)) {
      shooter1.lives--;
      for (int j = 0; j < alienList.size(); j++) {
        alienList.get(j).resetRage();
      }
      alienLaserList.remove(i);
    }
    if (a.y + a.h/2 >= 800) {
      alienLaserList.remove(i);
    }
    
    // hits barriers, loses lives
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
    // activates powerups
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

    // kills aliens
    for (int j = alienList.size() - 1; j >= 0; j--) {
      Alien a = alienList.get(j);

      if (s.hitLaser(a.x, a.y, a.w, a.h) && !a.death) {
        a.killAlien();
        if (int(random(1, 4)) == 1) {
          powerupList.add(new Powerup(a.x, a.y));
        }
        a.death = true;
        shooterLaserList.remove(i);
      }
    }
    
    // damages own barriers
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
  // new round once all aliens are killed 
  if (alienList.isEmpty()) {
    renewGame();
    round++;
  }
  // how long it takes for the aliens to move, affected by difficulty
  for (int i = 0; i < alienList.size(); i++) {
    if (alienList.get(i).alienRage() && (cooldown >= int((framesToMove - (round * 5))/2))) {
      cooldown = 0;
    } else if (cooldown >= framesToMove - (round * 5)) {
      cooldown = 0;
    }
  }
}

void resetGame() {
  // removing all aliens from the list, assuming there are
  shooter1.lives = 2;
  round = 0;
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
