import 'package:button_clicker/game/clicker.dart';
import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/game.dart';

int getAmountLimited(Clicker clicker, int amount) {
  if (clicker.quantity + amount < 0) { // if quantity goes over max, limit it to max
    amount = Constants.maxInteger - clicker.quantity;
  }
  return amount;
}

abstract class BuyingAmountState {
  BuyingAmountState getNextState();
  String getText();
  int getAmount(Game game, Clicker clicker);

  void buy(Game game, Clicker clicker) {
    int amount = getAmount(game, clicker);
    amount = getAmountLimited(clicker, amount);
    if (canBuy(game, clicker, amount)) {
      game.spendClicks(clicker.getCost(amount));
      clicker.buyClickerAmount(amount);
      game.save();
    }
  }
  bool canBuy(Game game, Clicker clicker, int amount) {
    return game.hasSufficientClicks(clicker.getCost(amount));
  }
}

class OneState extends BuyingAmountState {
  @override
  BuyingAmountState getNextState() {
    return TenState();
  }
  
  @override
  int getAmount(Game game, Clicker clicker) {
    return 1;
  }
  
  @override
  String getText() {
    return "1";
  }
}

class TenState extends BuyingAmountState {
  @override
  BuyingAmountState getNextState() {
    return HundredState();
  }

  @override
  String getText() {
    return "10";
  }
  
  @override
  int getAmount(Game game, Clicker clicker) {
    return 10;
  } 
}

class HundredState extends BuyingAmountState {
  @override
  BuyingAmountState getNextState() {
    return MaxState();
  }

  @override
  String getText() {
    return "100";
  }
  
  @override
  int getAmount(Game game, Clicker clicker) {
    return 100;
  }
}

class MaxState extends BuyingAmountState {
  @override
  BuyingAmountState getNextState() {
    return OneState();
  }

  @override
  String getText() {
    return "Max";
  }
  
  @override
  void buy(Game game, Clicker clicker) {
    int amount = getAmount(game, clicker);
    if (amount <= 0) {
      return;
    }
    super.buy(game, clicker);
  }
  
  @override
  int getAmount(Game game, Clicker clicker) {
    int amount = clicker.getBuyableAmount(game.getClicks());
    amount = getAmountLimited(clicker, amount);
    return amount;
  }
}