import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
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

    Color squareColor = Color.fromRGBO(
      int.parse(colorModel.rgb[0].isNotEmpty ? colorModel.rgb[0] : '0'),
      int.parse(colorModel.rgb[1].isNotEmpty ? colorModel.rgb[1] : '0'), 
      int.parse(colorModel.rgb[2].isNotEmpty ? colorModel.rgb[2] : '0'), 
      1.0
    );
    return Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
            aspectRatio: 1.0,
            child: Card(
                color: squareColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ))));
  }
}
