import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/screens/place_form_screen.dart';

class Routes {
  static const String placeForm = '/place-form';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      Routes.placeForm: (_) => const PlaceFormScreen(),
    };
  }
}
