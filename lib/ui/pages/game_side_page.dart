import 'package:button_clicker/ui/elements/app_bar.dart';
import 'package:button_clicker/ui/pages/game_page.dart';
import 'package:flutter/material.dart';

abstract class GameSidePage extends GamePage {
  const GameSidePage({super.key});
}

abstract class GameSidePageState<T extends StatefulWidget> extends GameState<T> {
  
  BoxDecoration getDecoration() {
    return BoxDecoration(
      image: DecorationImage( 
        image: AssetImage(getBackgroundImageName()), fit: BoxFit.cover, alignment: getDecorationAlignment()
      ),
    );
  }

  String getBackgroundImageName();
  Alignment getDecorationAlignment() {
    return Alignment.center;
  }

  CustomAppBar getAppBar() {
    return const CustomAppBar();
  }

  Widget getFloatingActionButton() {
    return const SizedBox.shrink();
  }

  @override
  Widget nextBuildStep(BuildContext context) {
    return Scaffold(
      floatingActionButton: getFloatingActionButton(),
      body: DecoratedBox(
        decoration: getDecoration(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getAppBar(),
              Expanded(child: buildWidget(context))
            ],
          ),
        ),
      ),
    );
  }
}