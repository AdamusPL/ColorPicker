import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_color_picker/colorConverter.dart';

class ColorModel with ChangeNotifier {
  List<String> _rgb = ['0', '0', '0'];
  List<String> _hsv = ['0.0', '0.0', '0.0'];
  List<String> _cmyk = ['0.0', '0.0', '0.0', '0.0'];
  String _hex = '000000';

   List<String> get rgb => _rgb;
  List<String> get hsv => _hsv;
  List<String> get cmyk => _cmyk;
  String get hex => _hex;

  void setRGB(List<String> rgb) {
    _rgb = rgb;
    var r = int.parse(rgb[0].isNotEmpty ? rgb[0] : '0');
    var g = int.parse(rgb[1].isNotEmpty ? rgb[1] : '0');
    var b = int.parse(rgb[2].isNotEmpty ? rgb[2] : '0');
    _hsv = ColorConverter.rgbToHsv(r, g, b);
    _cmyk = ColorConverter.rgbToCmyk(r, g, b);
    _hex = ColorConverter.rgbToHex(r, g, b);
    notifyListeners();
  }

  void setHSV(List<String> hsv) {
    _hsv = hsv;
    var h = double.parse(hsv[0].isNotEmpty ? hsv[0] : '0');
    var s = double.parse(hsv[1].isNotEmpty ? hsv[1] : '0');
    var v = double.parse(hsv[2].isNotEmpty ? hsv[2] : '0');
    var rgb = ColorConverter.hsvToRgb(h, s, v);
    _rgb = rgb.map((e) => e.toString()).toList();
    _cmyk = ColorConverter.rgbToCmyk(rgb[0], rgb[1], rgb[2]);
    _hex = ColorConverter.rgbToHex(rgb[0], rgb[1], rgb[2]);
    notifyListeners();
  }

  void setCMYK(List<String> cmyk) {
    _cmyk = cmyk;
    var c = int.parse(cmyk[0].isNotEmpty ? cmyk[0] : '0');
    var m = int.parse(cmyk[1].isNotEmpty ? cmyk[1] : '0');
    var y = int.parse(cmyk[2].isNotEmpty ? cmyk[2] : '0');
    var k = int.parse(cmyk[3].isNotEmpty ? cmyk[3] : '0');
    var rgb = ColorConverter.cmykToRgb(c, m, y, k);
    _rgb = rgb.map((e) => e.toString()).toList();
    _hsv = ColorConverter.rgbToHsv(rgb[0], rgb[1], rgb[2]);
    _hex = ColorConverter.rgbToHex(rgb[0], rgb[1], rgb[2]);
    notifyListeners();
  }

  void setHEX(String hex) {
    _hex = hex;
    var rgb = ColorConverter.hexToRgb(hex.isNotEmpty ? hex : '000000');
    _rgb = rgb.map((e) => e.toString()).toList();
    _hsv = ColorConverter.rgbToHsv(rgb[0], rgb[1], rgb[2]);
    _cmyk = ColorConverter.rgbToCmyk(rgb[0], rgb[1], rgb[2]);
    notifyListeners();
  }

  String getValue(String value) {
    switch (value) {
      case 'R':
        return _rgb[0];
      case 'G':
        return _rgb[1];
      case 'B':
        return _rgb[2];
      case 'H':
        return _hsv[0];
      case 'S':
        return _hsv[1];
      case 'V':
        return _hsv[2];
      case 'C':
        return _cmyk[0];
      case 'M':
        return _cmyk[1];
      case 'Y':
        return _cmyk[2];
      case 'K':
        return _cmyk[3];
      case 'HEX':
        return _hex;
      default:
        return '';
    }
  }
}