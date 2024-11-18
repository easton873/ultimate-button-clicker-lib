import 'package:button_clicker/game/game_observer.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:flutter/material.dart';

abstract class GameUI extends StatefulWidget {
  const GameUI({super.key});
}

abstract class GameUIState<T extends StatefulWidget> extends State<T>  implements GameWinObserver {
  @override
  void initState() {
    super.initState();
    MCO().registerWinObserver(this);
  }

  @override
  void dispose() {
    MCO().unregisterWinObserver(this);
    super.dispose();
  }
  
  Widget nextBuildStep(BuildContext context);

  Widget buildWidget(BuildContext context);

  void updateState() {
    setState(() {});
  }

  @override
  void notifyForcedUpdate(){
    updateState();
  }

  @override
  Widget build(BuildContext context) {
    if (!MCO().isInitialized){
      return const Scaffold(
        body: const Center(child: Text('loading')),
      );
    }
    return PopScope(
      canPop: true,
      child: nextBuildStep(context),
      onPopInvokedWithResult: (didPop, result) => MCO().unregisterWinObserver(this),
    ); 
  }
}