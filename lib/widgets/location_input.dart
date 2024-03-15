import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/models/place_location.dart';
import 'package:flutter_app_great_places/models/place_location_map.dart';
import 'package:flutter_app_great_places/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  LatLng? _latLngSelected;

  _LocationInputState() {
    _getCurrentUserLocation().catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível carregar sua localização atual.'),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final LocationData location = await Location().getLocation();
    if (location.latitude == null || location.longitude == null) {
      return;
    }
    final PlaceLocationMap placeLocationMap = PlaceLocationMap(
      placeLocation: PlaceLocation(
          latitude: location.latitude!,
          longitude: location.longitude!,
          address: ''),
    );

    setState(() {
      _previewImageUrl = placeLocationMap.generateLocationPreviewImage();
    });
  }

  Future<void> _selectOnMap() async {
    Widget builder = _latLngSelected != null
        ? MapScreen(
            inititalPlacelocationMap: PlaceLocationMap(
              placeLocation: PlaceLocation.withoutAddress(
                _latLngSelected!.latitude,
                _latLngSelected!.longitude,
              ),
            ),
          )
        : MapScreen();

    final LatLng? latLngSelected = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => builder,
      ),
    );

    if (latLngSelected == null) {
      return;
    } else {
      setState(() {
        _latLngSelected = latLngSelected;
        final PlaceLocationMap placeLocationMap = PlaceLocationMap(
          placeLocation: PlaceLocation.withoutAddress(
            latLngSelected.latitude,
            latLngSelected.longitude,
          ),
        );
        _previewImageUrl = placeLocationMap.generateLocationPreviewImage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.red),
          ),
          child: _previewImageUrl == null
              ? const CircularProgressIndicator()
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _getCurrentUserLocation,
              icon: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text('Localização Atual'),
                ],
              ),
            ),
            IconButton(
              onPressed: _selectOnMap,
              icon: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map),
                  SizedBox(width: 10),
                  Text('Selecione no mapa'),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
