public enum Screen {
  MAIN_MENU(1),
  COSMETICS(1),
  EASY_LEVEL(1),
  MEDIUM_LEVEL(1.25),
  HARD_LEVEL(1.5),
  TWO_PLAYER_MODE(1),
  GAME_OVER(1),
  DIFFICULTY(1),
  COSMETICS_2(1),
  INVENTORY(1);
  
  final float DIFFMULT;
  Screen(float diffMult) {
    this.DIFFMULT = diffMult;
  }
 
}
