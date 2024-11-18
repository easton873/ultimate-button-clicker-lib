import 'package:button_clicker/game/game_observer.dart';

abstract class ObservableGame {
  List<GameUpdateObserver> updateObservers = [];
  List<GameWinObserver> winObservers = [];
  List<GameResetObserver> resetObservers = [];

  void registerUpdateObserver(GameUpdateObserver o) {
    updateObservers.add(o);
  }

  void unregisterUpdateObserver(GameUpdateObserver o) {
    updateObservers.remove(o);
  }

  void registerResetObserver(GameResetObserver o) {
    resetObservers.add(o);
  }

  void unregisterResetObserver(GameResetObserver o) {
    resetObservers.remove(o);
  }

  void registerWinObserver(GameWinObserver o) {
    winObservers.add(o);
  }

  void unregisterWinObserver(GameWinObserver o) {
    winObservers.remove(o);
  }

  void notifyGameUpdate() {
    for (GameUpdateObserver observer in updateObservers) {
      observer.notifyGameUpdate();
    }
  }

  void notifyGameReset() {
    for (GameResetObserver observer in resetObservers) {
      observer.notifyGameReset();
    }
  }

  void notifyGameWin() {
    winObservers.last.notifyGameWon();
    // currObserver.peek.notifyGameWon();
  }

  void forceUpdate() {
    for (GameWinObserver winObservers in winObservers) {
      winObservers.notifyForcedUpdate();
    }
  }
}