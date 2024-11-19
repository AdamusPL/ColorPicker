import 'package:flutter/material.dart';
import 'package:flutter_color_picker/theme/color.dart';

class TextFieldRow extends StatefulWidget {
  const TextFieldRow({
    super.key,
    required this.labels,
    required this.style,
    required this.textFieldCount,
    required this.getValue,
    required this.readOnly,
    this.onValueChange,
    this.getPrefix,
    this.getSuffix,
    this.validateChange
  });

  final List<String> labels;
  final TextStyle style;
  final int textFieldCount;
  final String Function(String) getValue;
  final bool readOnly;
  final void Function(String, String)? onValueChange;
  final String Function(String)? getPrefix;
  final String Function(String)? getSuffix;
  final bool Function(String, String)? validateChange;
  
  
  @override
  TextFieldRowState createState() => TextFieldRowState();
}

class TextFieldRowState extends State<TextFieldRow> {
  late List<TextEditingController> _controllers;
  late List<String> _previousValues;
  late List<FocusNode> _focusNodes;

  String _getPrefix(String label) {
    return widget.getPrefix != null ? widget.getPrefix!(label) : '';
  }

  String _getSuffix(String label) {
    return widget.getSuffix != null ? widget.getSuffix!(label) : '';
  }

  bool _validateChange(String label, String value) {
    return widget.validateChange != null ? widget.validateChange!(label, value) : true;
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.textFieldCount, (index) {
      return TextEditingController(text: '0');
    });
    _previousValues = List.generate(widget.textFieldCount, (index) {
      return '0';
    });

    _focusNodes = List.generate(widget.textFieldCount, (index) {
      return FocusNode();
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
    return SizedBox(
      width: double.infinity, // Ensures the Row takes up the full width
      child: Row(
        children: List.generate(widget.textFieldCount, (index) {
          if (!_focusNodes[index].hasFocus || widget.readOnly) {
            _controllers[index].text = widget.getValue(widget.labels[index]);
          }
          return Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              decoration: InputDecoration(
                filled: true,
                fillColor: purple40.withOpacity(0.1),
                labelText: widget.labels[index],
                suffixText: _getSuffix(widget.labels[index]),
                prefixText: _getPrefix(widget.labels[index]),
              ),
              style: widget.style,
              readOnly: widget.readOnly,
              onChanged: (value) {
                if (_validateChange(widget.labels[index], value)) {
                  var toPass = value.isEmpty ? '0' : value;
                  widget.onValueChange!(widget.labels[index], toPass);
                  _controllers[index].text = value;
                  _previousValues[index] = value;
                } else {
                  _controllers[index].text = _previousValues[index];
                }
              },
            ),
          ));
        }),
      ),
    );
  }
}
