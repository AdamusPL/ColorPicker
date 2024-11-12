import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:provider/provider.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:flutter_color_picker/circlePainter.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key});

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  final AssetImage myImageProvider = AssetImage('lib/images/color_wheel.png');

  Offset localPosition = const Offset(-1, -1);

  double localPositionX = 0;
  double localPositionY = 0;

  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);

    return Container(
        margin: EdgeInsets.only(top: 50),
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              localPosition = details.localPosition;
            });
          },
          child: ImagePixels(
            imageProvider: myImageProvider,
            builder: (BuildContext context, ImgDetails img) {
              if (localPosition.dx >= 0 && localPosition.dy >= 0) {
                final color = img.pixelColorAt!(
                  localPosition.dx.toInt(),
                  localPosition.dy.toInt(),
                );

                localPositionX = localPosition.dx;
                localPositionY = localPosition.dy;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  colorModel.setRGB(color);
                });
              }

              return Stack(children: [
                Container(
                    child: Image.asset(
                  'lib/images/color_wheel.png',
                  fit: BoxFit.cover,
                )),
                CustomPaint(
                  size: Size(20, 20),
                  painter: CirclePainter(localPositionX, localPositionY),
                )
              ]);
            },
          ),
        ));
  }
}
