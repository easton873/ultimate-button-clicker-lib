import 'package:button_clicker/ui/confirm.dart';
import 'package:flutter/material.dart';

class RefundButton extends StatelessWidget {
  const RefundButton({super.key, required this.buttonFn});
  final VoidCallback? buttonFn;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: buttonFn, 
        icon: const Icon(
          Icons.recycling,
          color: Colors.green
        )
      ),
    );
  }
}