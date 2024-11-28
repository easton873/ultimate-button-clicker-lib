import 'package:button_clicker/game/const.dart';
import 'package:button_clicker/game/mco.dart';
import 'package:button_clicker/ui/color.dart';
import 'package:button_clicker/ui/elements/confirm.dart';
import 'package:button_clicker/ui/displays/displays.dart';
import 'package:button_clicker/ui/displays/update_widget.dart';
import 'package:button_clicker/ui/game_text.dart';
import 'package:flutter/material.dart';

class ResetButton extends GameUpdateWidget {
  const ResetButton({super.key});

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends GameUpdateWidgetState<ResetButton> {
  @override
  Widget build(BuildContext context) {
    Image resetButtonImage = Image.asset('${Constants.imagesPath}/reset.png');
    void Function()? onTap = (){ showResetConfirmation(context); };
    String text = "Reset and gain\n${MCO().currGame.displayNewBonus()}\n${getBonusPluralOrNot(MCO().currGame.getNewBonus())}";
    List<Widget> children = [
      resetButtonImage,
      GameText(text)
    ];
    if (MCO().currGame.getNewBonus() == 0) {
      text = 'Earn ${Constants.displayInt(MCO().currGame.data.getBonusCost())}\n${getThingProducedPluralOrNot(MCO().currGame.data.getBonusCost())} to reset';
      Widget lock = const Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(
            Icons.lock, // Lock icon
            color: Colors.white, // Color of the icon
          ),
        ),
      );
      onTap = null;
      children = [
        ColorFiltered(
          colorFilter: const ColorFilter.matrix(
            <double>[
              0.2126, 0.7152, 0.0722, 0, 0,  // Red channel
              0.2126, 0.7152, 0.0722, 0, 0,  // Green channel
              0.2126, 0.7152, 0.0722, 0, 0,  // Blue channel
              0, 0, 0, 1, 0,                 // Alpha channel
            ],
          ),
          child: resetButtonImage,
        ),
        GameText(text),
        lock
      ];
    }
    Widget child = GestureDetector(
      onTap: onTap, 
      child: Stack(
      alignment: Alignment.center,
      children: children,
    ));
    return SizedBox(height: 200, width: 200, child: child);
  }
}

class ClearButton extends GameUpdateWidget {
  const ClearButton({super.key});

  @override
  State<ClearButton> createState() => _ClearButtonState();
}

class _ClearButtonState extends GameUpdateWidgetState<ClearButton> {
  @override
  Widget build(BuildContext context) {
    if (!MCO().currGame.detectWin()) {
      return const SizedBox.shrink();
    }
    return ElevatedButton(
      onPressed: () {showClearConfirmation(context);},
      style: GameColor.getCurrGameElevatedButtonStyle(),
      child: const Text('Clear')
    );
  }
}

class ScalingDownBox extends StatelessWidget {
  const ScalingDownBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: child,
      ),
    );
  }
}
