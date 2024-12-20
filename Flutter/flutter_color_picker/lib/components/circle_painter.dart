import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double locationX;
  final double locationY;

  CirclePainter(this.locationX, this.locationY);

  final _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(locationX - size.width / 2, locationY - size.height / 2, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}