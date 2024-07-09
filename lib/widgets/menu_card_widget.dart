import 'package:flutter/material.dart';

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({
    this.onTap,
    this.color = Colors.white,
    this.icon = const Icon(Icons.question_mark_outlined, size: 100),
    this.text = const Text(
      'Soon',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    super.key,
  });

  final Icon icon;
  final Text text;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
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
                    child: text,
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

var a = GestureDetector(
  onTap: () {},
);
