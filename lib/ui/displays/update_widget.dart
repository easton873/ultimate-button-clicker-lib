import 'package:button_clicker/game/game_observer.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/displays/reset_widget.dart';
import 'package:flutter/material.dart';

abstract class GameUpdateWidget extends GameResetWidget {
  const GameUpdateWidget({super.key});
}

abstract class GameUpdateWidgetState<T extends StatefulWidget> extends GameResetWidgetState<T> implements GameUpdateObserver {
   @override
  void initState() {
    super.initState();
    MCO().registerUpdateObserver(this);
  }

  @override
  void dispose() {
    MCO().unregisterUpdateObserver(this);
    super.dispose();
  }

  @override
  void notifyGameUpdate() {
   updateState();
  }
}