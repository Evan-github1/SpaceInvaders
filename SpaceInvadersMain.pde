Screen screen;
int cooldown = 0;
int waitToSwitch = 0;
ArrayList<BarrierPortion> barrier1 = new ArrayList<>();
ArrayList<BarrierPortion> barrier2 = new ArrayList<>();
ArrayList<BarrierPortion> barrier3 = new ArrayList<>();
ArrayList<Alien> alienList = new ArrayList<>();
ArrayList<AlienLaser> alienLaserList = new ArrayList<>();
ArrayList<ShooterLaser> shooterLaserList = new ArrayList<>();
Shooter shooter1 = new Shooter(600, 750, 75, 75/2);
boolean moveDown = false;
PFont pixelFont;
Button playButton = new Button(600, 250, 200, 100, "PLAY");

Button play = new Button(500, 500, 200, 100, "test");
public void setup() {
  size(1200, 800);
  pixelFont = createFont("slkscre.ttf", 75);
  textFont(pixelFont);
  screen = Screen.MAIN_MENU;
  resetGame();
} 
public void draw() {
  background(0);
  cooldown++;

  switch (screen) {
    case MAIN_MENU:
      textAlign(CENTER);
      fill(255);
      textSize(75);
      text("Space Invaders", 600, 125, 10);
      playButton.drawButton();
      break;

    case COSMETICS:
      break;

    case EASY_LEVEL:
      playGame(45);
      break;

    case MEDIUM_LEVEL:
      break;

    case HARD_LEVEL:
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
        screen = Screen.MAIN_MENU;
      }
      break;
    case VICTORY:
      textAlign(CENTER);
      fill(255, 223, 0);
      textSize(150);
      text("VICTORY", 600, 400, 10);
      waitToSwitch++;
      if (waitToSwitch == 180) {
        screen = Screen.MAIN_MENU;
      }
      break;
  }  
  
  
}

void resetGame() {
  // removing all aliens from the list, assuming there are
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
  switch (screen) {
    case MAIN_MENU:
      if (playButton.mouseOverButton() && playButton.checkScreen(Screen.MAIN_MENU)) {
        resetGame();
        screen = Screen.EASY_LEVEL;
      }
      break;
    case COSMETICS:
      break;

    case EASY_LEVEL:
      shooterLaserList.add(new ShooterLaser(shooter1.x, shooter1.y - shooter1.h/2 - shooter1.h/8));
      break;

    case MEDIUM_LEVEL:
      break;

    case HARD_LEVEL:
      break;

    case TWO_PLAYER_MODE:
      break;
    case GAME_OVER:
      break;
      
    case VICTORY:
      break;
      
  }  
}

void playGame(int framesToMove) {
  shooter1.drawShooter();
 
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
    
    for (int j = alienList.size() - 1; j >= 0; j--) {
      Alien a = alienList.get(j);
  
      if (s.hitLaser(a.x, a.y, a.w, a.h)) {
        shooterLaserList.remove(i);
        alienList.remove(j);
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
    waitToSwitch = 0;
    screen = Screen.VICTORY;
  }
  // how long it takes for the aliens to move, affected by difficulty
  if (cooldown == framesToMove) {
    cooldown = 0;
  }
}
