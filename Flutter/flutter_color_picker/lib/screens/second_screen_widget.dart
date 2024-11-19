import 'package:flutter/material.dart';
import 'package:flutter_color_picker/models/color_model.dart';
import 'package:flutter_color_picker/components/square.dart';
import 'package:flutter_color_picker/components/text_field_row.dart';
import 'package:provider/provider.dart';
import 'package:flutter_color_picker/components/color_palette.dart';

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
                    return colorModel.hsv.hue.toStringAsFixed(2);
                  case 'S':
                    return (colorModel.hsv.saturation * 100).toStringAsFixed(2);
                  case 'V':
                    return (colorModel.hsv.value * 100).toStringAsFixed(2);
                  default:
                    return '';
                }
              },
              getSuffix: (label) {
                switch(label) {
                  case 'H':
                    return '°';
                  case 'S':
                  case 'V':
                    return '%';
                  default:
                    return '';
                }
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
              getSuffix: (_) => '%',
            ),
          TextFieldRow(
              labels: const ['HEX'],
              style: const TextStyle(fontSize: 20),
              textFieldCount: 1,
              readOnly: true,
              getValue: (label) {
                return colorModel.hex;
              },
              getPrefix: (_) => '#',
            ),
        ],
      ),
    );
  }
}
