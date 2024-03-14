import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/models/place_location.dart';
import 'package:flutter_app_great_places/models/place_location_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocationMap inititalPlacelocationMap;

  /*  = PlaceLocation(
      latitude: 37.422131,
      longitude: -122.084801,
      address: '',
  ) */

  const MapScreen({
    this.inititalPlacelocationMap = const PlaceLocationMap(
      placeLocation: PlaceLocation(
        latitude: 37.422131,
        longitude: -122.084801,
        address: '',
      ),
    ),
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a posição'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.inititalPlacelocationMap.placeLocation.latitude,
            widget.inititalPlacelocationMap.placeLocation.longitude,
          ),
          zoom: widget.inititalPlacelocationMap.zoom,
        ),
        onTap: (argument) {
          final PlaceLocation placeLocation = PlaceLocation(
              latitude: argument.latitude,
              longitude: argument.longitude,
              address: '');
          Navigator.of(context).pop(placeLocation);
        },
      ),
    );
  }
}
