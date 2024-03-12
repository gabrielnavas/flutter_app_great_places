import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/models/place.dart';
import 'package:flutter_app_great_places/models/place_location.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlaces(String place, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: place,
      location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
