import 'package:flutter/material.dart';

import 'features/object_detection/presentation/pages/object_detection_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Object detection',

        debugShowCheckedModeBanner: false, color: Colors.amberAccent,
        home: ObjectDetectionPage());
  }
}
