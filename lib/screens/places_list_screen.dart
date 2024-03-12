import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/providers/great_places.dart';
import 'package:flutter_app_great_places/routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GreatPlaces greatPlaces = Provider.of<GreatPlaces>(context);
    final items = greatPlaces.items;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: const Text(
            'Lugares',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.placeForm);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: greatPlaces.itemsCount,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              leading: Image.file(items[index].image),
              title: Text(items[index].title),
              subtitle: Text(
                  '${items[index].location.latitude} - ${items[index].location.longitude}, ${items[index].location.address}'),
            );
          },
        ));
  }
}
