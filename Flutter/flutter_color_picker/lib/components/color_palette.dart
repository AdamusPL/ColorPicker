import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_color_picker/models/color_model.dart';
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
  Offset? _lastValidPosition;

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
              setLastValidPosition: (position) {
                _lastValidPosition = position;
              },
              getLastValidPosition: () => _lastValidPosition,
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
  final void Function(Offset position) setLastValidPosition;
  final Offset? Function() getLastValidPosition;

  ColorWheelPainter({
    required this.position,
    required this.image,
    required this.wheelSize,
    required this.onColorSelected,
    required this.setLastValidPosition,
    required this.getLastValidPosition,
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
      setLastValidPosition(position);
      _updateColorModel(position);
    } else if (getLastValidPosition() != null) {
      canvas.drawCircle(
        getLastValidPosition()!,
        10,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
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
