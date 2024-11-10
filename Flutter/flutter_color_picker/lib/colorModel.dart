import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_color_picker/colorConverter.dart';
import 'package:flutter_color_picker/models/cmykcolor.dart';

class ColorModel with ChangeNotifier {
  Color _color = Colors.black;
  HSVColor _hsvColor = HSVColor.fromColor(Colors.black);
  CMYKColor _cmykColor = CMYKColor.fromColor(Colors.black);

  

  Color get rgb => _color;
  HSVColor get hsv => _hsvColor;
  CMYKColor get cmyk => _cmykColor;
  String get hex => _color.value.toRadixString(16).substring(2);

  void setRGB(Color rgb) {
    _color = rgb;
    // var r = int.parse(rgb[0].isNotEmpty ? rgb[0] : '0');
    // var g = int.parse(rgb[1].isNotEmpty ? rgb[1] : '0');
    // var b = int.parse(rgb[2].isNotEmpty ? rgb[2] : '0');
    _hsvColor = HSVColor.fromColor(_color);
    _cmykColor = CMYKColor.fromColor(_color);
    notifyListeners();
  }

  void setHSV(HSVColor hsv) {
    _hsvColor = hsv;
    // var h = double.parse(hsv[0].isNotEmpty ? hsv[0] : '0');
    // var s = double.parse(hsv[1].isNotEmpty ? hsv[1] : '0');
    // var v = double.parse(hsv[2].isNotEmpty ? hsv[2] : '0');
    // var rgb = ColorConverter.hsvToRgb(h, s, v);
    // _rgb = rgb.map((e) => e.toString()).toList();
    // _cmyk = ColorConverter.rgbToCmyk(rgb[0], rgb[1], rgb[2]);
    // _hex = ColorConverter.rgbToHex(rgb[0], rgb[1], rgb[2]);
    _color = _hsvColor.toColor();
    _cmykColor = CMYKColor.fromColor(_color);
    notifyListeners();
  }

  void setCMYK(CMYKColor cmyk) {
    _cmykColor = cmyk;
    // var c = int.parse(cmyk[0].isNotEmpty ? cmyk[0] : '0');
    // var m = int.parse(cmyk[1].isNotEmpty ? cmyk[1] : '0');
    // var y = int.parse(cmyk[2].isNotEmpty ? cmyk[2] : '0');
    // var k = int.parse(cmyk[3].isNotEmpty ? cmyk[3] : '0');
    // var rgb = ColorConverter.cmykToRgb(c, m, y, k);
    // _rgb = rgb.map((e) => e.toString()).toList();
    // _hsv = ColorConverter.rgbToHsv(rgb[0], rgb[1], rgb[2]);
    // _hex = ColorConverter.rgbToHex(rgb[0], rgb[1], rgb[2]);
    _color = _cmykColor.toColor();
    _hsvColor = HSVColor.fromColor(_color);
    notifyListeners();
  }

  void setHEX(String hex) {
    setRGB(Color(int.parse('0xFF$hex')));
    // var rgb = ColorConverter.hexToRgb(hex.isNotEmpty ? hex : '000000');
    // _rgb = rgb.map((e) => e.toString()).toList();
    // _hsv = ColorConverter.rgbToHsv(rgb[0], rgb[1], rgb[2]);
    // _cmyk = ColorConverter.rgbToCmyk(rgb[0], rgb[1], rgb[2]);
    // notifyListeners();
  }
}