import 'package:flutter/material.dart';
import 'package:flutter_color_picker/colorModel.dart';
import 'package:provider/provider.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:flutter_color_picker/circlePainter.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key});

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  final AssetImage myImageProvider = AssetImage('lib/images/color_wheel.png');

  // This will hold the image dimensions
  Map<String, double> imageDimensions = {'width': 0.0, 'height': 0.0};

  // Load image and get its dimensions
  Future<Map<String, double>> getImageDimensions(String assetPath) async {
    // Load the image bytes
    ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();

    // Decode the image to get its dimensions
    final ui.Image image = await decodeImageFromList(bytes);

    // Return the dimensions as a map
    return {
      'width': image.width.toDouble(),
      'height': image.height.toDouble(),
    };
  }

  @override
  void initState() {
    super.initState();

    // Call the method to get image dimensions when the widget is initialized
    _loadImageDimensions();
  }

  // Function to call the async method and set state
  Future<void> _loadImageDimensions() async {
    Map<String, double> dimensions = await getImageDimensions('lib/images/color_wheel.png');
    setState(() {
      imageDimensions = dimensions;  // Update state with new dimensions
    });
  }

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
              width: imageDimensions['width'],
              height: imageDimensions['height'],
              child: ClipOval(
                  child: ImagePixels(
                imageProvider: myImageProvider,
                builder: (BuildContext context, ImgDetails img) {
                  if (localPosition.dx >= 0 && localPosition.dy >= 0) {
                    final double centerX = img.width! / 2;
                    final double centerY = img.height! / 2;
                    final double radius = img.width! / 2;

                    print(localPosition.dx);
                    print(localPosition.dy);

                    double distance = sqrt(pow(localPosition.dx - centerX, 2) +
                        pow(localPosition.dy - centerY, 2));

                    if (distance <= radius) {
                      double scaleX = img.width! / imageDimensions['width']!;
                      double scaleY = img.height! / imageDimensions['height']!;

                      int imgX = (localPosition.dx * scaleX).toInt();
                      int imgY = (localPosition.dy * scaleY).toInt();

                      final color = img.pixelColorAt!(
                        imgX, imgY
                      );

                      if (imgX >= 0 &&
                          imgX < img.width! &&
                          imgY >= 0 &&
                          imgY < img.height!) {
                        localPositionX = localPosition.dx;
                        localPositionY = localPosition.dy;
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        colorModel.setRGB(color);
                      });
                    }
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
