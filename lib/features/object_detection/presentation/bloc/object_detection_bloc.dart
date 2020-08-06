import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tflite/tflite.dart';

part 'object_detection_event.dart';
part 'object_detection_state.dart';

class ObjectDetectionBloc
    extends Bloc<ObjectDetectionEvent, ObjectDetectionState> {
  ObjectDetectionBloc() : super(Empty());

  @override
  Stream<ObjectDetectionState> mapEventToState(
    ObjectDetectionEvent event,
  ) async* {
    if (event is GetImageFromGallery) {
      yield Loading();
      final imageFile =await getFromGallery();
      final recognition = await recognitions(imageFile);
      final loadedImage=await loadImage(imageFile);
      yield Loaded(recognitions: recognition, image: loadedImage);
    }else if (event is GetImageFromCamera) {
      yield Loading();
      final imageFile = await getFromCamera();
      final recognition = await recognitions(imageFile);
      final loadedImage=await loadImage(imageFile);
      yield Loaded(recognitions: recognition, image: loadedImage);
    }
  }

  getFromGallery() async {
    return await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
        maxWidth: 420
    );
  }

  getFromCamera() async {
    return await ImagePicker.pickImage(
      source: ImageSource.camera,
        maxHeight: 400,
        maxWidth: 400
    );
  }


  Future<ui.Image> loadImage(File f) async {
    var bytes = await f.readAsBytes();
    var codec = await ui.instantiateImageCodec(bytes);
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  recognitions(imageFile) async {

    return await Tflite.detectObjectOnImage(
      path: imageFile.path, // required
      model: "SSDMobileNet",
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.4, // defaults to 0.1
      numResultsPerClass: 2, // defaults to 5
      asynch: true, // defaults to true
    );
  }
}
