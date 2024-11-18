import 'package:button_clicker/ui/confirm.dart';
import 'package:flutter/material.dart';

class RefundButton extends StatelessWidget {
  const RefundButton({super.key, required this.saveKey});
  final String saveKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: (){
          showRefunConfirmation(context, saveKey);
        }, 
        icon: const Icon(
          Icons.recycling,
          color: Colors.green
        )
      ),
    );
  }
}