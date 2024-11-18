import 'package:button_clicker/game/upgrades/upgrades.dart';

class ClickPower extends Upgrade {
  ClickPower() : super(BaseUpgrade("Clicks per click", 1));

  @override
  increaseCost() {
    return super.getLevel();
  }

  int getClickPower() {
    return super.getLevel();
  }

  ClickPower.fromJson(Map json) : super(BaseUpgrade.fromJson(json));
  
  @override
  decodeJson(Map<String, dynamic> json) {
    return ClickPower.fromJson(json);
  }
  
  @override
  Map encodeJson() {
    return super.getBase().encodeJson();
  }
}