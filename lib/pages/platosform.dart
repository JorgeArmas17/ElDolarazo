import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import '../services/firebase_services.dart';

class DishForm extends StatefulWidget {
  @override
  _DishFormState createState() => _DishFormState();
}

class _DishFormState extends State<DishForm> {
  List<dynamic> restauranList = [];

  String selectedRestaurantId = '';
  TextEditingController dishNameController = TextEditingController(text: "");
  TextEditingController dishDescriptionController =
      TextEditingController(text: "");
  TextEditingController dishEstrellasController =
      TextEditingController(text: "");
  TextEditingController dishPriceController = TextEditingController(text: "");
  TextEditingController dishIngredientsController =
      TextEditingController(text: "");
  String imageUrl = "";

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('dish_images/${DateTime.now().millisecondsSinceEpoch}');

      final taskSnapshot = await storageRef.putFile(File(pickedFile.path));
      final imageUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        this.imageUrl = imageUrl;
      });
    }
  }

  void _resetForm() {
    dishNameController.clear();
    imageUrl = "";
    dishDescriptionController.clear();
    dishPriceController.clear();
    dishEstrellasController.clear();
    dishIngredientsController.clear();
    selectedRestaurantId = '';
  }

  @override
  void initState() {
    super.initState();
    fetchPeople(); // Llamar a la función para obtener los datos al inicializar
  }

  Future<void> fetchPeople() async {
    List<Map<String, dynamic>> fetchedList = await fetchRestaurants();
    if (mounted) {
      setState(() {
        restauranList = fetchedList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _formSubmitted = false;
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Agregar Plato'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 47, 47, 41),
                Color.fromARGB(255, 108, 165, 218),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton(
              items: restauranList.map((restaurant) {
                return DropdownMenuItem(
                  value: restaurant[
                      'id'], // Utiliza el ID del documento como valor
                  child: Text(restaurant['nombre']),
                );
              }).toList(),
              onChanged: (selectedRestaurant) {
                setState(() {
                  selectedRestaurantId = selectedRestaurant as String;
                  print(selectedRestaurantId);
                });
              },
              hint: Text('Seleccionar Restaurante'),
            ),
            TextFormField(
              controller: dishNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Plato',
                prefixIcon: Icon(
                  Icons.local_dining_sharp,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _selectImage,
              label: Text("Imagen"),
              icon: Icon(Icons.add_photo_alternate_rounded),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 108, 165, 218),
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishDescriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Plato',
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishEstrellasController,
              decoration: InputDecoration(
                labelText: 'Estrellas ',
                prefixIcon: Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishPriceController,
              decoration: InputDecoration(
                labelText: 'Precio del Plato',
                prefixIcon: Icon(
                  Icons.monetization_on,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dishIngredientsController,
              decoration: InputDecoration(
                labelText: 'Detalles del Plato',
                prefixIcon: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await addDish(
                    selectedRestaurantId,
                    dishNameController.text,
                    imageUrl,
                    dishDescriptionController.text,
                    dishEstrellasController.text,
                    dishPriceController.text,
                    dishIngredientsController.text);
                setState(() {
                  _formSubmitted = true;
                });
                _resetForm();
              },
              label: Text('Guardar'),
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 144, 33, 25),
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
