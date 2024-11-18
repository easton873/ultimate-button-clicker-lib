import 'package:button_clicker/game/game_observer.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:flutter/material.dart';

abstract class GameResetWidget extends StatefulWidget {
  const GameResetWidget({super.key});
}

abstract class GameResetWidgetState<T extends StatefulWidget> extends State<T> implements GameResetObserver {
   @override
  void initState() {
    super.initState();
    MCO().registerResetObserver(this);
  }

  @override
  void dispose() {
    MCO().unregisterResetObserver(this);
    super.dispose();
  }

  void updateState() {
    setState(() {});
  }

  @override
  notifyGameReset() {
    updateState();
  }
}