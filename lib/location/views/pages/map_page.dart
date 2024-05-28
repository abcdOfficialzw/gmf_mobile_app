import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/geodatic_points_model.dart';

class MapPage extends StatefulWidget {
  const MapPage(
      {super.key,
      required this.longitude,
      required this.latitude,
      required this.locationName,
      required this.cases,
      required this.markers});
  final String locationName;
  final String longitude;
  final String latitude;
  final int cases;
  final List<GeodaticPoint> markers;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final Map<int, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    print("Map Loaded");
    mapController = controller;
    setState(() {
      _markers.clear();
      for (final point in widget.markers) {
        final marker = Marker(
          markerId: MarkerId(point.id.toString()),
          position: LatLng(double.tryParse(point.wgs84points!.wgs84Lat!)!,
              double.tryParse(point.wgs84points!.wgs84Lon!)!),
          infoWindow: InfoWindow(
            title: point.monumentName!,
            snippet: 'Condition: ${point.condition}',
          ),
        );
        _markers[point.id!] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(
        double.tryParse(widget.latitude)!, double.tryParse(widget.longitude)!);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('(${widget.cases.toString()} Monuments)'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 10.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
