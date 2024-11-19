import 'package:flutter/material.dart';
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
    _hsvColor = HSVColor.fromColor(_color);
    _cmykColor = CMYKColor.fromColor(_color);
    notifyListeners();
  }

  void setHSV(HSVColor hsv) {
    _hsvColor = hsv;
    _color = _hsvColor.toColor();
    _cmykColor = CMYKColor.fromColor(_color);
    notifyListeners();
  }

  void setCMYK(CMYKColor cmyk) {
    _cmykColor = cmyk;
    _color = _cmykColor.toColor();
    _hsvColor = HSVColor.fromColor(_color);
    notifyListeners();
  }

  void setHEX(String hex) {
    setRGB(Color(int.parse('0xFF$hex')));
  }
}