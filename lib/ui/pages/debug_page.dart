import 'package:button_clicker/save/save_data.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:flutter/material.dart';

class DebugPage extends GamePage {
  const DebugPage({super.key});
  
  @override
  GameState<GamePage> createState() => _DebugPageState();
}

class _DebugPageState extends GameState<DebugPage> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){SaveData().wipeData();}, child: const Text('Reset')),
            ],
          )
        ],
      ),
    );
  }
}