import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
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
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Square(),
          TextFieldRow(
            values: ['R', 'G', 'B'],
            style: TextStyle(fontSize: 20),
            textFieldCount: 3,
          ),
          TextFieldRow(
            values: ['H', 'S', 'V'],
            style: TextStyle(fontSize: 20),
            textFieldCount: 3,
          ),
          TextFieldRow(
            values: ['C', 'M', 'Y', 'K'],
            style: TextStyle(fontSize: 20),
            textFieldCount: 4,
          ),
          TextFieldRow(
            values: ['HEX'],
            style: TextStyle(fontSize: 20),
            textFieldCount: 1,
          ),
        ],
      ),
    ));
  }
}
