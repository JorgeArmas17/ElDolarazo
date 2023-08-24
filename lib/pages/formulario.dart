import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RestauranteForm extends StatefulWidget {
  @override
  _RestauranteFormState createState() => _RestauranteFormState();
}

class _RestauranteFormState extends State<RestauranteForm> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController locationController = TextEditingController(text: "");
  String imageUrl = "";
  final user = FirebaseAuth.instance.currentUser;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Subir la imagen al Firebase Storage
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('restaurant_images/${DateTime.now().millisecondsSinceEpoch}');

      final taskSnapshot = await storageRef.putFile(File(pickedFile.path));
      final imageUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        this.imageUrl =
            imageUrl; // Actualizar la imageUrl en el estado del widget
      });
    }
  }

  void _resetForm() {
    nameController.clear();
    descriptionController.clear();
    locationController.clear();
    imageUrl = "";
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    bool _formSubmitted = false;
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Agregar Restaurante'),
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout_outlined))
        ],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 47, 47, 41),
                Color.fromARGB(255, 108, 165, 218)
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
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ), // Icono para el campo Nombre
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Descripción',
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.black,
                ), // Icono para el campo Descripción
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Ubicación',
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ), // Icono para el campo Ubicación
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _selectImage,
              label: Text("Imagen"),
              icon: Icon(Icons.add_photo_alternate_rounded),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 108, 165, 218),
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            imageUrl.isNotEmpty && !_formSubmitted
                ? Image.network(
                    imageUrl,
                    height: 200,
                  )
                : SizedBox(),
            ElevatedButton.icon(
              onPressed: () async {},
              label: Text("Guardar"),
              icon: Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 144, 33, 25),
                onPrimary: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
