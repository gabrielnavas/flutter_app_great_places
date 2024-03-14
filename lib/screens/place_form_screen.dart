import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_great_places/providers/great_places.dart';
import 'package:flutter_app_great_places/widgets/image_input.dart';
import 'package:flutter_app_great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();

  File? _pickedImage;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _submitForm() {
    String message = "";

    if (_titleController.text.isEmpty) {
      message = "Adicione um título!";
    } else if (_pickedImage == null) {
      message = "Adicione um imagem!";
    }

    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlaces(
      _titleController.text,
      _pickedImage!,
    );

    Navigator.of(context).pop();
  }

  void _selectImage(File? pickedImage) {
    setState(() => _pickedImage = pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Novo Lugar!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              controller: _titleController,
              autofocus: true,
            ),
          ),
          ImageInput(selectImage: _selectImage),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: LocationInput(),
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
            ),
            onPressed: _submitForm,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
