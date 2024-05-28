import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationDenied extends LocationState {}

class LocationLoaded extends LocationState {
  final double latitude;
  final double longitude;
  final String administrativeDistrict;

  LocationLoaded(this.latitude, this.longitude, this.administrativeDistrict);

  @override
  List<Object> get props => [latitude, longitude];
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object> get props => [message];
}
