import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:object_detection/features/object_detection/presentation/bloc/object_detection_bloc.dart';
import 'package:object_detection/features/object_detection/presentation/widgets/custom_paint.dart';
import 'package:tflite/tflite.dart';

class ObjectDetectionPage extends StatelessWidget {
  var bloc = ObjectDetectionBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object detection'),
      ),
      floatingActionButton: Row(
        textDirection: TextDirection.rtl,
        children: [
          FloatingActionButton(
            child: Icon(Icons.image),
            onPressed: () {
              bloc.add(GetImageFromGallery());
            },
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: () {
              bloc.add(GetImageFromCamera());
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (_) => bloc,
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: BlocBuilder(
            cubit: bloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is Empty) {
                fitModel();
                return Text('No image selected!');
              } else if (state is Loading) {
                return CircularProgressIndicator();
              } else if (state is Loaded) {
                return CustomPaint(
                  size: Size(state.image.width.toDouble(),
                      state.image.height.toDouble()),
                  painter: MyPainter(
                    recognitions: state.recognitions,
                    image: state.image,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void fitModel() async {
    Tflite.loadModel(
      model: 'assets/detect.tflite',
      labels: 'assets/labelmap.txt',
      numThreads: 1, // defaults to 1
    );
  }
}
