import 'package:button_clicker/ui/game_controller.dart';
import 'package:button_clicker/ui/pages/summary_page.dart';
import 'package:button_clicker/ui/tutorial/summary_tutorial_page.dart';
import 'package:flutter/material.dart';

class SummaryPageController extends GameController {
  const SummaryPageController({super.key});

  @override
  State<SummaryPageController> createState() => _SummaryPageControllerState();
}

class _SummaryPageControllerState extends GameControllerState<SummaryPageController> {
  @override
  Widget buildWidget(BuildContext context) {
    return const SummaryPage();
  }

  @override
  Widget buildTutorialWidget(BuildContext context) {
    return const SummaryTutorialPage();
  }
}