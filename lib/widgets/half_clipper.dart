import 'package:flutter/widgets.dart';

class HalfClipper extends CustomClipper<Path> {
  HalfClipper({required this.top});

  double top;

  @override
  getClip(Size size) {
    top = (top < 0) ? 0 : top;
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - top);
    path.lineTo(0, size.height - top);
    return path;
    // throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
    // throw UnimplementedError();
  }
}
