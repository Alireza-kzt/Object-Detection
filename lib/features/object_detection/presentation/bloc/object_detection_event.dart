part of 'object_detection_bloc.dart';

@immutable
abstract class ObjectDetectionEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetImageFromGallery extends ObjectDetectionEvent {}

class GetImageFromCamera extends ObjectDetectionEvent {}
