import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/models/place.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  const PlaceItem({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(backgroundImage: FileImage(place.image)),
      title: Text(place.title),
      subtitle: Text(
          '${place.location.latitude} - ${place.location.longitude}, ${place.location.address}'),
    );
  }
}