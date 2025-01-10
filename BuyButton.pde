public class BuyButton extends Button {
  String cosmeticName, type;
  BuyButton(float x, float y, float w, float h, String text, String cosmeticName, String type) {
    super(x, y, w, h, text);
    this.cosmeticName = cosmeticName;
    this.type = type;
  }
  
  void buyItem(int price) {
    if (totalPoints >= price && !cosmeticUnlocked.get(cosmeticName)) {
      cosmeticUnlocked.put(cosmeticName, true);
      totalPoints -= price;
    }
    
    if (cosmeticUnlocked.get(cosmeticName)) {
      this.text = "EQUIPPED";
      if (type == "trail") {
        currentTrail = cosmeticName;
      } else if (type == "effect") {
        currentEffect = cosmeticName;
        for (int i = 0; i < explosionEffects.size(); i++) {
          if (cosmeticUnlocked.get(explosionEffects.get(i).cosmeticName) && explosionEffects.get(i).cosmeticName != cosmeticName) {
            explosionEffects.get(i).text = "UNEQUIPPED";
          }
        }
      }
    }
  }
}
