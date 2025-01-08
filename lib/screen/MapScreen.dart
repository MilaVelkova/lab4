import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/Event.dart';

class MapScreen extends StatelessWidget {
  final Event event;

  MapScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(42.0041, 21.4095),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('event_location'),
            position: LatLng(42.0041, 21.4095),
            infoWindow: InfoWindow(
              title: event.title,
              snippet: event.location,
            ),
          ),
        },
      ),
    );
  }
}
