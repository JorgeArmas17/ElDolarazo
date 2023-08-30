import 'package:flutter/material.dart';

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
        child: Column(
          // Envolver el Container en un Column
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 55),
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
                      // Simulando la función addComentario
                      //await addComentario(dishComentController.text);

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
