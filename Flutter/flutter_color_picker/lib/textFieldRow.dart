import 'package:flutter/material.dart';
import 'package:flutter_color_picker/color.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:provider/provider.dart';

class TextFieldRow extends StatefulWidget {
  TextFieldRow({
    super.key,
    required this.labels,
    required this.style,
    required this.textFieldCount,
    required this.getValue,
    required this.onValueChange,
  });

  final List<String> labels;
  final TextStyle style;
  final int textFieldCount;
  final String Function(String) getValue;
  final void Function(String, String) onValueChange;

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
          _controllers[index].text = widget.getValue(widget.labels[index]);
          return Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: _controllers[index],
              decoration: InputDecoration(
                filled: true,
                fillColor: purple40.withOpacity(0.1),
                labelText: widget.labels[index],
                suffixText: getSuffix(widget.labels, index),
                prefixText: getPrefix(widget.labels, index),
              ),
              style: widget.style,
              onChanged: (value) {
                var toValidate = value.isNotEmpty ? value : '0'; 
                if (validateChange(toValidate, widget.labels[index])) {
                  widget.onValueChange(widget.labels[index], value);
                } else {
                  _controllers[index].text = widget.getValue(widget.labels[index]);
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
