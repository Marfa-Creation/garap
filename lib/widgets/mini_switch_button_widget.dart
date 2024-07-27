import 'package:flutter/material.dart';

class MiniSwitchButtonWidget extends StatelessWidget {
  const MiniSwitchButtonWidget(
      {super.key,
      required this.onPressed,
      required this.buttonColor,
      this.buttonText});

  final void Function() onPressed;
  final Color? buttonColor;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Center(
            child: Text(
              buttonText ?? '',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
