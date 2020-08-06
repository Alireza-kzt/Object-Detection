part of 'object_detection_bloc.dart';

@immutable
abstract class ObjectDetectionState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ObjectDetectionState {}

class Loading extends ObjectDetectionState {}

class Loaded extends ObjectDetectionState {
  var image;
  dynamic recognitions;

  Loaded({this.image, this.recognitions});
  @override
  List<Object> get props => [image, recognitions];
}
