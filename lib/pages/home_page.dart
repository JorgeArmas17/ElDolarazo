import 'package:firebase_auth/firebase_auth.dart';
import 'package:el_dolarazo/pages/formulario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text("Logged in")),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormularioPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Cambia el valor para ajustar la curvatura
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Formulario",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
