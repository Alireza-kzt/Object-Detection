import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class MyPainter extends CustomPainter {
  final ui.Image image;
  final dynamic recognitions;

  MyPainter({
    this.image,
    this.recognitions,
  });

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final colorsList = [
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.cyan,
      Colors.purple,
      Colors.brown,
      Colors.pink,
      Colors.amber,
      Colors.indigo,
      Colors.lime,
      Colors.teal,
    ];
    int colorsListIndex = 0;

    canvas.drawImage(image, Offset(0, 0), Paint());

    (recognitions as List).forEach((r) {
      if (r['confidenceInClass'] < 0.5) {
        return;
      }

      double x = r['rect']['x'] * image.width;
      double y = r['rect']['y'] * image.height;
      double w = r['rect']['w'] * image.width;
      double h = r['rect']['h'] * image.height;

      canvas.drawRect(
          Rect.fromLTWH(
            x,
            y,
            w,
            h,
          ),
          Paint()
            ..color = colorsList[colorsListIndex]
            ..strokeWidth = 3.0
            ..style = PaintingStyle.stroke);

      final tp = TextPainter(
        text: TextSpan(
          text: r['detectedClass'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            backgroundColor: colorsList[colorsListIndex],
          ),
        ),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x, y));

      colorsListIndex = (colorsListIndex + 1) % colorsList.length;
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
