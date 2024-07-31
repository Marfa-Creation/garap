import 'package:flutter/material.dart';

class CircleStatusWidget extends StatelessWidget {
  const CircleStatusWidget(
      {this.color, required this.text, super.key});

  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 21,
      height: 21,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: null,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
