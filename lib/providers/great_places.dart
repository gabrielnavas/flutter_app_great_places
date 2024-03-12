import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  int get itemsCount => _places.length;

  Place itemByIndex(int index) {
    return _places[index];
  }
}
