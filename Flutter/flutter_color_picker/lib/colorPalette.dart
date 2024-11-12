import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:provider/provider.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key});

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 50, bottom: 50), // Set top and bottom margins
      child: Image.asset(
        'lib/images/color_wheel.png', // The image path as declared in pubspec.yaml
        fit: BoxFit.cover, // Optional: Ensures image scales to cover the area
      ),
    );
  }
}
