import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/routes.dart';
import 'package:flutter_app_great_places/screens/place_form_screen.dart';
import 'package:flutter_app_great_places/screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greate Places',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        useMaterial3: true,
      ),
      routes: Routes.getRoutes(),
      home: const PlacesListScreen(),
    );
  }
}
