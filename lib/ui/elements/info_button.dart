import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key, required this.buttonFn});
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
          Icons.info,
          color: Colors.black,
          size: 30.0
        )
      ),
    );
  }
}