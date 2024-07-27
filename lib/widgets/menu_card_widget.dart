import 'package:flutter/material.dart';

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({
    this.gradient,
    this.onTap,
    this.color = const Color.fromARGB(255, 64, 65, 75),
    this.icon = const Icon(
      Icons.question_mark_outlined,
      size: 100,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    this.text = 'Soon',
    super.key,
  });

  final Icon icon;
  final String text;
  final Color color;
  final Gradient? gradient;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            gradient: gradient),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (onTap != null) onTap!();
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: icon),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
