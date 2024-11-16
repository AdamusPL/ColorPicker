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
          child: SizedBox(
              width: 200,
              height: 200,
              child: ClipRect(

              child: ImagePixels(
            imageProvider: myImageProvider,
            builder: (BuildContext context, ImgDetails img) {
              if (localPosition.dx >= 0 && localPosition.dy >= 0) {
                double scaleX = img.width! / 200;
                double scaleY = img.height! / 200;

                final color = img.pixelColorAt!(
                  (localPosition.dx * scaleX).toInt(),
                  (localPosition.dy * scaleY).toInt(),
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
          ))),
        ));
  }
}
