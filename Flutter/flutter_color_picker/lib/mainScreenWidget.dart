import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:flutter_color_picker/models/cmykcolor.dart';
import 'package:flutter_color_picker/square.dart';
import 'package:flutter_color_picker/textFieldRow.dart';
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
          Square(),
          TextFieldRow(
              labels: ['R', 'G', 'B'],
              style: TextStyle(fontSize: 20),
              textFieldCount: 3,
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
              }),
          TextFieldRow(
              labels: ['H', 'S', 'V'],
              style: TextStyle(fontSize: 20),
              textFieldCount: 3,
              getValue: (label) {
                switch (label) {
                  case 'H':
                    double hue = colorModel.hsv.hue;
                    return hue.toStringAsFixed(0);
                  case 'S':
                    double saturation = colorModel.hsv.saturation * 100;
                    return saturation.toStringAsFixed(0);
                  case 'V':
                    double value = colorModel.hsv.value * 100;
                    return value.toStringAsFixed(0);
                  default:
                    return '';
                }
              },
              onValueChange: (label, value) {
                HSVColor hsvColor = HSVColor.fromColor(colorModel.rgb);
                value = value.isEmpty ? '0' : value;
                switch (label) {
                  case 'H':
                    hsvColor = hsvColor.withHue(double.parse(value));
                    break;
                  case 'S':
                    hsvColor = hsvColor.withSaturation(double.parse(value));
                    break;
                  case 'V':
                    hsvColor = hsvColor.withValue(double.parse(value));
                    break;
                }
                colorModel.setHSV(hsvColor);
              }),
          TextFieldRow(
            labels: ['C', 'M', 'Y', 'K'],
            style: TextStyle(fontSize: 20),
            textFieldCount: 4,
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
              CMYKColor cmykColor = CMYKColor.fromColor(colorModel.rgb);
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
          ),
          TextFieldRow(
            labels: ['HEX'],
            style: TextStyle(fontSize: 20),
            textFieldCount: 1,
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
          ),
        ],
      ),
    ));
  }
}
