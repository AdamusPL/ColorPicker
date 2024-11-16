import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:provider/provider.dart';

class SquareSecondScreen extends StatefulWidget {
  const SquareSecondScreen({super.key});

  @override
  State<SquareSecondScreen> createState() => _SquareSecondScreenState();
}

class _SquareSecondScreenState extends State<SquareSecondScreen> {
  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);

    Color squareColor = colorModel.rgb;
    return Center(
      child: Container(
        width: 100/MediaQuery.of(context).devicePixelRatio,
        height: 100/MediaQuery.of(context).devicePixelRatio,
        margin: const EdgeInsets.only(bottom: 15, top: 50),
        decoration: BoxDecoration(
          color: squareColor,
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
