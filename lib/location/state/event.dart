import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestLocation extends LocationEvent {}

class UpdateLocation extends LocationEvent {
  final double latitude;
  final double longitude;
  final String administrativeDistrict;

  UpdateLocation(this.latitude, this.longitude, this.administrativeDistrict);

  @override
  List<Object> get props => [latitude, longitude];
}
