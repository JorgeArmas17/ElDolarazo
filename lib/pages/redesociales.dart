import 'package:flutter/material.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:social_media_flutter/widgets/icons.dart';
import 'package:social_media_flutter/widgets/text.dart';

import '../services/firebase_services.dart';

class SocialMediaPage extends StatelessWidget {
  TextEditingController dishComentController = TextEditingController(text: "");

  void _resetForm() {
    dishComentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Desarrolladores'),
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
        padding: EdgeInsets.all(35),
        child: Column(
          children: [
            SizedBox(height: 25),

            Container(
              margin: EdgeInsets.only(top: 15), // Espacio entre filas
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
            // Nuevo apartado para agregar comentarios
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 55), // Espacio entre el apartado anterior
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agregar Comentario',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: dishComentController,
                    decoration: InputDecoration(
                      labelText: 'Escribe tu comentario aquí...',
                      prefixIcon: Icon(
                        Icons.comment,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await addComentario(dishComentController.text);

                      _resetForm();
                    },
                    label: Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    icon: Icon(Icons.arrow_forward_sharp),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 108, 165, 218),
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
