abstract class GameUpdateObserver {
  notifyGameUpdate();
}

abstract class GameWinObserver {
  notifyGameWon();
  notifyForcedUpdate();
}

abstract class GameResetObserver {
  notifyGameReset();
}