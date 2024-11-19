import 'package:flutter/material.dart';
import 'package:flutter_color_picker/models/color_model.dart';
import 'package:flutter_color_picker/models/cmykcolor.dart';
import 'package:flutter_color_picker/components/square.dart';
import 'package:flutter_color_picker/components/text_field_row.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Square(),

          // RGB Fields
          TextFieldRow(
            labels: const ['R', 'G', 'B'],
            style: const TextStyle(fontSize: 20),
            textFieldCount: 3,
            readOnly: false,
            getValue: (label) {
              switch (label) {
                case 'R':
                  return colorModel.rgb.red.toString();
                case 'G':
                  return colorModel.rgb.green.toString();
                case 'B':
                  return colorModel.rgb.blue.toString();
                default:
                  return '';
              }
            },
            onValueChange: (label, value) {
              Color color = Color(colorModel.rgb.value);
              value = value.isEmpty ? '0' : value;
              switch (label) {
                case 'R':
                  color = color.withRed(int.parse(value));
                  break;
                case 'G':
                  color = color.withGreen(int.parse(value));
                  break;
                case 'B':
                  color = color.withBlue(int.parse(value));
                  break;
              }
              colorModel.setRGB(color);
            },
            validateChange: (label, value) {
              return int.tryParse(value) != null &&
                  (int.parse(value) >= 0 &&
                  int.parse(value) <= 255 &&
                  value.length <= 3) || value.isEmpty;
            },
          ),

          // HSV Fields
          TextFieldRow(
            labels: const ['H', 'S', 'V'],
            style: const TextStyle(fontSize: 20),
            textFieldCount: 3,
            readOnly: false,
            getValue: (label) {
              switch (label) {
                case 'H':
                  double hue = colorModel.hsv.hue;
                  return hue.toStringAsFixed(2);
                case 'S':
                  double saturation = colorModel.hsv.saturation * 100;
                  return saturation.toStringAsFixed(2);
                case 'V':
                  double value = colorModel.hsv.value * 100;
                  return value.toStringAsFixed(2);
                default:
                  return '';
              }
            },
            onValueChange: (label, value) {
              HSVColor hsvColor = HSVColor.fromAHSV(
                  colorModel.hsv.alpha,
                  colorModel.hsv.hue,
                  colorModel.hsv.saturation,
                  colorModel.hsv.value);
              value = value.isEmpty ? '0' : value;
              switch (label) {
                case 'H':
                  hsvColor = hsvColor.withHue(double.parse(value));
                  break;
                case 'S':
                  hsvColor = hsvColor.withSaturation(double.parse(value) / 100);
                  break;
                case 'V':
                  hsvColor = hsvColor.withValue(double.parse(value) / 100);
                  break;
              }
              colorModel.setHSV(hsvColor);
            },
            getSuffix: (label) {
              switch (label) {
                case 'H':
                  return '°';
                case 'S':
                case 'V':
                  return '%';
                default:
                  return '';
              }
            },
            validateChange: (label, value) {
              return double.tryParse(value) != null &&
                  (double.parse(value) >= 0 &&
                  double.parse(value) <= 360 &&
                  value.length <= 6) || value.isEmpty;
            },
          ),

          // CMYK Fields
          TextFieldRow(
            labels: const ['C', 'M', 'Y', 'K'],
            style: const TextStyle(fontSize: 20),
            textFieldCount: 4,
            readOnly: false,
            getValue: (label) {
              switch (label) {
                case 'C':
                  return colorModel.cmyk.c.toString();
                case 'M':
                  return colorModel.cmyk.m.toString();
                case 'Y':
                  return colorModel.cmyk.y.toString();
                case 'K':
                  return colorModel.cmyk.k.toString();
                default:
                  return '';
              }
            },
            onValueChange: (label, value) {
              CMYKColor cmykColor = CMYKColor(colorModel.cmyk.c,
                  colorModel.cmyk.m, colorModel.cmyk.y, colorModel.cmyk.k);
              value = value.isEmpty ? '0' : value;
              switch (label) {
                case 'C':
                  cmykColor = cmykColor.withCyan(int.parse(value));
                  break;
                case 'M':
                  cmykColor = cmykColor.withMagenta(int.parse(value));
                  break;
                case 'Y':
                  cmykColor = cmykColor.withYellow(int.parse(value));
                  break;
                case 'K':
                  cmykColor = cmykColor.withBlack(int.parse(value));
                  break;
              }
              colorModel.setCMYK(cmykColor);
            },
            getSuffix: (_) => '%',
            validateChange: (label, value) {
              return int.tryParse(value) != null &&
                  (int.parse(value) >= 0 &&
                  int.parse(value) <= 100 &&
                  value.length <= 3) || value.isEmpty;
            },
          ),

          // HEX Field
          TextFieldRow(
            labels: const ['HEX'],
            style: const TextStyle(fontSize: 20),
            textFieldCount: 1,
            readOnly: false,
            getValue: (label) {
              switch (label) {
                case 'HEX':
                  return colorModel.hex;
                default:
                  return '';
              }
            },
            onValueChange: (label, value) {
              if (value.length != 6) return;
              value = value.isEmpty ? '000000' : value;
              colorModel.setHEX(value);
            },
            getPrefix: (_) => '#',
            validateChange: (label, value) {
              return RegExp(r"^[A-Fa-f0-9]{0,6}$").hasMatch(value);
            },
          ),
        ],
      ),
    ));
  }
}
