import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/models/place.dart';
import 'package:flutter_app_great_places/models/place_location.dart';
import 'package:flutter_app_great_places/repositories/places_sqlite.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  loadPlaces() async {
    final placesList = await PlacesSqlite.getData();
    _items = placesList
        .map((place) => Place.withoutLocation(
              place['id'] as String,
              place['title'] as String,
              File(place['image'] as String),
            ))
        .toList();
    notifyListeners();
  }

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
    PlacesSqlite.insert({
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    }).then((value) {
      notifyListeners();
    });
  }
}
