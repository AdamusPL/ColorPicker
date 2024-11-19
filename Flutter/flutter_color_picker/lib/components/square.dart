import 'package:flutter/material.dart';
import 'package:flutter_color_picker/models/color_model.dart';
import 'package:provider/provider.dart';

class Square extends StatefulWidget {
  const Square({super.key});

  @override
  State<Square> createState() => _SquareState();
}

class _SquareState extends State<Square> {
  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);

    Color squareColor = colorModel.rgb;
    return Padding(
        padding: const EdgeInsets.all(12),
        child: AspectRatio(
            aspectRatio: 1.0,
            child: Card(
                color: squareColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ))));
  }
}
