import 'dart:math';

import 'package:flutter/material.dart';

class GeekyantsLogo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    path.arcTo(
      Rect.fromPoints(Offset((size.width / 2) - 30, size.height),
          Offset((size.width / 2), 0)),
      4.5 * pi,
      0.5 * pi,
      true,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LogoPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
