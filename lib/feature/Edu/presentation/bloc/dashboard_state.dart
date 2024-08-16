import '../../data/content_model.dart';

sealed class ContentState {}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentModel content;
  ContentLoaded({required this.content});
}

class ContentError extends ContentState {
  final String message;
  ContentError(this.message);
}
