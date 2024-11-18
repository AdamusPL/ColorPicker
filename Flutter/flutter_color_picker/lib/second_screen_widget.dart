import 'package:flutter/material.dart';
import 'package:flutter_color_picker/color_model.dart';
import 'package:flutter_color_picker/models/cmykcolor.dart';
import 'package:flutter_color_picker/square.dart';
import 'package:flutter_color_picker/text_field_row.dart';
import 'package:provider/provider.dart';
import 'package:flutter_color_picker/color_palette.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          // Color Palette
          Expanded(
            flex: 3,
            child: Center(
              child: SizedBox.square(
                dimension: screenWidth * 0.75, // Keep the palette proportional to screen width
                child: ColorPalette(width: screenWidth * 0.75),
              ),
            ),
          ),
          
          // Square Widget
          const SizedBox(
            height: 100.0,
            width: 100.0,
            child: Center(
              child: Square(),
            ),
          ),

          // RGB Fields
          
          TextFieldRow(
              labels: const ['R', 'G', 'B'],
              style: const TextStyle(fontSize: 20),
              textFieldCount: 3,
              readOnly: true,
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
            ),

          // HSV Fields
          TextFieldRow(
              labels: const ['H', 'S', 'V'],
              style: const TextStyle(fontSize: 20),
              textFieldCount: 3,
              readOnly: true,
              getValue: (label) {
                switch (label) {
                  case 'H':
                    return colorModel.hsv.hue.toStringAsFixed(0);
                  case 'S':
                    return (colorModel.hsv.saturation * 100).toStringAsFixed(0);
                  case 'V':
                    return (colorModel.hsv.value * 100).toStringAsFixed(0);
                  default:
                    return '';
                }
              },
              onValueChange: (label, value) {
                HSVColor hsvColor = colorModel.hsv;
                value = value.isEmpty ? '0' : value;
                switch (label) {
                  case 'H':
                    hsvColor = hsvColor.withHue(double.parse(value));
                    break;
                  case 'S':
                    hsvColor =
                        hsvColor.withSaturation(double.parse(value) / 100);
                    break;
                  case 'V':
                    hsvColor = hsvColor.withValue(double.parse(value) / 100);
                    break;
                }
                colorModel.setHSV(hsvColor);
              },
            ),
          

          // CMYK Fields
          TextFieldRow(
              labels: const ['C', 'M', 'Y', 'K'],
              style: const TextStyle(fontSize: 20),
              textFieldCount: 4,
              readOnly: true,
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
                CMYKColor cmykColor = colorModel.cmyk;
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
              labels: const ['HEX'],
              style: const TextStyle(fontSize: 20),
              textFieldCount: 1,
              readOnly: true,
              getValue: (label) {
                return colorModel.hex;
              },
              onValueChange: (label, value) {
                if (value.length != 6) return;
                colorModel.setHEX(value);
              },
            ),
        ],
      ),
    );
  }
}
