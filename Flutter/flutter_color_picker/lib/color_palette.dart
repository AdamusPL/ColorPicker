// import 'package:flutter/material.dart';
// import 'package:flutter_color_picker/color_model.dart';
// import 'package:provider/provider.dart';
// import 'package:image_pixels/image_pixels.dart';
// import 'package:flutter_color_picker/circle_painter.dart';
// import 'dart:math';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';

// class ColorPalette extends StatefulWidget {
//   const ColorPalette({super.key});
//   @override
//   State<ColorPalette> createState() => _ColorPaletteState();
// }

// class _ColorPaletteState extends State<ColorPalette> {
//   final AssetImage myImageProvider =
//       const AssetImage('lib/images/color_wheel.png');

//   // This will hold the image dimensions
//   // Map<String, double> imageDimensions = {'width': 0.0, 'height': 0.0};

//   // // Load image and get its dimensions
//   // Future<Map<String, double>> getImageDimensions(String assetPath) async {
//   //   // Load the image bytes
//   //   ByteData data = await rootBundle.load(assetPath);
//   //   final Uint8List bytes = data.buffer.asUint8List();

//   //   // Decode the image to get its dimensions
//   //   final ui.Image image = await decodeImageFromList(bytes);

//   //   // Return the dimensions as a map
//   //   return {
//   //     'width': image.width.toDouble(),
//   //     'height': image.height.toDouble(),
//   //   };
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   // Call the method to get image dimensions when the widget is initialized
//   //   _loadImageDimensions();
//   // }

//   // Function to call the async method and set state
//   // Future<void> _loadImageDimensions() async {
//   //   Map<String, double> dimensions = await getImageDimensions('lib/images/color_wheel.png');
//   //   setState(() {
//   //     imageDimensions = dimensions;  // Update state with new dimensions
//   //   });
//   // }

//   Offset localPosition = const Offset(-1, -1);

//   double localPositionX = 0;
//   double localPositionY = 0;

//   @override
//   Widget build(BuildContext context) {
//     ColorModel colorModel = Provider.of<ColorModel>(context);

//     return Container(
//       child: GestureDetector(
//         child: Image.asset('lib/images/color_wheel.png'),
//         onPanStart: (details) {
//           setState(() {
//             localPosition = details.localPosition;
//           });
//           print(localPosition);
//         },
//         onPanUpdate: (details) {
//           setState(() {
//             localPosition = details.localPosition;
//           });
//           print(localPosition);
//         },
//         onPanEnd: (details) {
//           setState(() {
//             localPosition = const Offset(-1, -1);
//           });
//         },
//       ),

//   //     child: SizedBox(
//   //         width: 300.0,
//   //         height: 300.0,
//   //         child: ImagePixels(
//   //           imageProvider: myImageProvider,
//   //           builder: (BuildContext context, ImgDetails img) {
//   //             if (localPosition.dx >= 0 &&
//   //                 localPosition.dy >= 0 &&
//   //                 img.width != null &&
//   //                 img.height != null) {
//   //               final double centerX = img.width! / 2;
//   //               final double centerY = img.height! / 2;
//   //               final double radius = img.width! / 2;

//   //               double distance = sqrt(pow(localPosition.dx - centerX, 2) +
//   //                   pow(localPosition.dy - centerY, 2));

//   //               if (distance <= radius) {
//   //                 // double scaleX = img.width! / imageDimensions['width']!;
//   //                 // double scaleY = img.height! / imageDimensions['height']!;

//   //                 int imgX = localPosition.dx.toInt();
//   //                 int imgY = localPosition.dy.toInt();

//   //                 final color = img.pixelColorAt!(imgX, imgY);

//   //                 if (imgX >= 0 &&
//   //                     imgX < img.width! &&
//   //                     imgY >= 0 &&
//   //                     imgY < img.height!) {
//   //                   localPositionX = localPosition.dx;
//   //                   localPositionY = localPosition.dy;
//   //                 }

//   //                 WidgetsBinding.instance.addPostFrameCallback((_) {
//   //                   colorModel.setRGB(color);
//   //                 });
//   //               }
//   //             }

//   //             return Stack(children: [
//   //               Container(
//   //                   child: Image.asset(
//   //                 'lib/images/color_wheel.png',
//   //                 width: 300.0,
//   //                 height: 300.0,
//   //               )),
//   //               CustomPaint(
//   //                 size: const Size(20, 20),
//   //                 painter: CirclePainter(localPositionX, localPositionY),
//   //               )
//   //             ]);
//   //           },
//   //         )),
//   //   );
//   // }
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_color_picker/color_model.dart';
import 'package:provider/provider.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key, required this.width});

  final double width;

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  Offset localPosition = const Offset(-1, -1);
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final data =
        await DefaultAssetBundle.of(context).load('lib/images/color_wheel.png');
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    setState(() {
      image = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorModel colorModel = Provider.of<ColorModel>(context);
    double paddedWidth = widget.width - 32;
    return GestureDetector(
        onPanStart: (details) {
          setState(() {
            localPosition = details.localPosition;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            localPosition = details.localPosition;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomPaint(
            size: Size(paddedWidth, paddedWidth),
            painter: ColorWheelPainter(
              position: localPosition - const Offset(16, 16),
              image: image,
              wheelSize: paddedWidth,
              onColorSelected: (color) {
                colorModel.setRGB(color);
              },
            ),
          ),
        ));
  }
}

class ColorWheelPainter extends CustomPainter {
  final Offset position;
  final ui.Image? image;
  final double wheelSize;
  final void Function(dynamic color) onColorSelected;

  ColorWheelPainter({
    required this.position,
    required this.image,
    required this.wheelSize,
    required this.onColorSelected,
  });

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    // Draw the color wheel
    if (image != null) {
      paintImage(
        canvas: canvas,
        image: image!,
        rect: Rect.fromLTWH(0, 0, wheelSize, wheelSize),
        fit: BoxFit.cover,
      );
    }

    // Check if the touch is within the circle
    final center = Offset(wheelSize / 2, wheelSize / 2);
    final distanceFromCenter = (position - center).distance;

    if (distanceFromCenter <= wheelSize / 2) {
      // Draw the circle at the touch position
      canvas.drawCircle(
        position,
        10,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      _updateColorModel(position);
    }
  }

  void _updateColorModel(Offset position) async {
  if (image != null && position.dx >= 0 && position.dy >= 0) {
    // Adjust for the padding
    double adjustedX = position.dx;
    double adjustedY = position.dy;

    // Scale the touch position to the actual image size
    double scaleX = image!.width / wheelSize;
    double scaleY = image!.height / wheelSize;

    int imgX = (adjustedX * scaleX).toInt();
    int imgY = (adjustedY * scaleY).toInt();

    if (imgX >= 0 &&
        imgX < image!.width &&
        imgY >= 0 &&
        imgY < image!.height) {
      final color = await _getPixelColor(image!, imgX, imgY);
      print(color);
      onColorSelected(color);
    }
  }
}

  Future<Color> _getPixelColor(ui.Image image, int x, int y) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) {
      return Colors.transparent;
    }

    final bytes = byteData.buffer.asUint8List();
    final offset = (y * image.width + x) * 4;
    final r = bytes[offset];
    final g = bytes[offset + 1];
    final b = bytes[offset + 2];
    const a = 255;
    return Color.fromARGB(a, r, g, b);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
