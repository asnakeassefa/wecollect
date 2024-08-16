import '../../data/userModel.dart';

sealed class MapState{}

class MapInitial extends MapState{}

class MapLoading extends MapState{}

class MapRejectLoading extends MapState{}

class MapSuccess extends MapState{
  final String message;
  MapSuccess({required this.message});
}

class MapError extends MapState{
  final String message;
  MapError({required this.message});
}

class MapLoaded extends MapState{
  final UserModel userData;
  MapLoaded({required this.userData});
}