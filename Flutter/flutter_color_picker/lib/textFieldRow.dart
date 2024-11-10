import 'package:flutter/material.dart';
import 'package:flutter_color_picker/color.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:provider/provider.dart';

class TextFieldRow extends StatefulWidget {
  const TextFieldRow({
    super.key,
    required this.values,
    required this.style,
    required this.textFieldCount,
  });

  final List<String> values;
  final TextStyle style;
  final int textFieldCount;

  @override
  _TextFieldRowState createState() => _TextFieldRowState();
}

class _TextFieldRowState extends State<TextFieldRow> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.textFieldCount, (index) {
      
      return TextEditingController(text: '0');
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);
    
    return SizedBox(
      width: double.infinity, // Ensures the Row takes up the full width
      child: Row(
        children: List.generate(widget.textFieldCount, (index) {
          _controllers[index].text = colorModel.getValue(widget.values[index]);
          return Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: _controllers[index],
              decoration: InputDecoration(
                filled: true,
                fillColor: purple40.withOpacity(0.1),
                labelText: widget.values[index],
                suffixText: getSuffix(widget.values, index),
                prefixText: getPrefix(widget.values, index),
              ),
              style: widget.style,
              onChanged: (value) {
                var toValidate = value.isNotEmpty ? value : '0'; 
                if (validateChange(toValidate, widget.values[index])) {
                  switch (widget.values[index]) {
                    case 'R':
                      colorModel.setRGB(
                          [value, colorModel.rgb[1], colorModel.rgb[2]]);
                      break;
                    case 'G':
                      colorModel.setRGB(
                          [colorModel.rgb[0], value, colorModel.rgb[2]]);
                      break;
                    case 'B':
                      colorModel.setRGB(
                          [colorModel.rgb[0], colorModel.rgb[1], value]);
                      break;
                    case 'H':
                      colorModel.setHSV(
                          [value, colorModel.hsv[1], colorModel.hsv[2]]);
                      break;
                    case 'S':
                      colorModel.setHSV(
                          [colorModel.hsv[0], value, colorModel.hsv[2]]);
                      break;
                    case 'V':
                      colorModel.setHSV(
                          [colorModel.hsv[0], colorModel.hsv[1], value]);
                      break;
                    case 'C':
                      colorModel.setCMYK([
                        value,
                        colorModel.cmyk[1],
                        colorModel.cmyk[2],
                        colorModel.cmyk[3]
                      ]);
                      break;
                    case 'M':
                      colorModel.setCMYK([
                        colorModel.cmyk[0],
                        value,
                        colorModel.cmyk[2],
                        colorModel.cmyk[3]
                      ]);
                      break;
                    case 'Y':
                      colorModel.setCMYK([
                        colorModel.cmyk[0],
                        colorModel.cmyk[1],
                        value,
                        colorModel.cmyk[3]
                      ]);
                      break;
                    case 'K':
                      colorModel.setCMYK([
                        colorModel.cmyk[0],
                        colorModel.cmyk[1],
                        colorModel.cmyk[2],
                        value
                      ]);
                      break;
                    case 'HEX':
                      colorModel.setHEX(value);
                      break;
                  }
                } else {
                  _controllers[index].text = colorModel.getValue(widget.values[index]);
                }
              },
            ),
          ));
        }),
      ),
    );
  }

  String getSuffix(text, index) {
    switch (text[index]) {
      case 'H':
        return '°';
      case 'S':
        return '%';
      case 'V':
        return '%';
      case 'C':
        return '%';
      case 'M':
        return '%';
      case 'Y':
        return '%';
      case 'K':
        return '%';
      default:
        return '';
    }
  }

  String getPrefix(text, index) {
    if (text[index] == 'HEX') {
      return '#';
    } else {
      return '';
    }
  }

  bool validateChange(String value, String label) {
    if (value.isEmpty) {
      return false;
    }
    switch (label) {
      case 'R':
      case 'G':
      case 'B':
        return int.tryParse(value) != null &&
            int.parse(value) >= 0 &&
            int.parse(value) <= 255;
      case 'H':
        return double.tryParse(value) != null &&
            double.parse(value) >= 0 &&
            double.parse(value) <= 360;
      case 'S':
      case 'V':
        return double.tryParse(value) != null &&
            double.parse(value) >= 0 &&
            double.parse(value) <= 100;
      case 'C':
      case 'M':
      case 'Y':
      case 'K':
        return double.tryParse(value) != null &&
            double.parse(value) >= 0 &&
            double.parse(value) <= 100;
      case 'HEX':
        return RegExp(r"^[A-Fa-f0-9]{0,6}$").hasMatch(value);
      default:
        return false;
    }
  }
}
