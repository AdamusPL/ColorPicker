import 'dart:math';
import 'package:flutter/material.dart';

@immutable
class CMYKColor {
  int c;
  int m;
  int y;
  int k;

  CMYKColor(this.c, this.m, this.y, this.k);

  static CMYKColor fromColor(Color color){
    int r = color.red;
    int g = color.green;
    int b = color.blue;
    var rp = r / 255.0;
    var gp = g / 255.0;
    var bp = b / 255.0;
    var k = 1 - max(rp, max(gp, bp));
    if (k == 1.0) {
      return CMYKColor(0, 0, 0, 100);
    }
    var c = (1 - rp - k) / (1 - k);
    var m = (1 - gp - k) / (1 - k);
    var y = (1 - bp - k) / (1 - k);
   
    return CMYKColor((c * 100).toInt(), (m * 100).toInt(), (y * 100).toInt(), (k * 100).toInt());
  }

  Color toColor(){
    var rp = 255 * (1 - c / 100.0) * (1 - k / 100.0);
    var gp = 255 * (1 - m / 100.0) * (1 - k / 100.0);
    var bp = 255 * (1 - y / 100.0) * (1 - k / 100.0);
    return Color.fromRGBO(rp.toInt(), gp.toInt(), bp.toInt(), 1);
  }

  CMYKColor withCyan(int cyan) {
    return CMYKColor(cyan, m, y, k);
  }

  CMYKColor withMagenta(int magenta) {
    return CMYKColor(c, magenta, y, k);
  }

  CMYKColor withYellow(int yellow) {
    return CMYKColor(c, m, yellow, k);
  }

  CMYKColor withBlack(int black) {
    return CMYKColor(c, m, y, black);
  }

}