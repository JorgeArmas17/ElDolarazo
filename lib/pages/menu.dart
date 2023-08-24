import 'package:flutter/material.dart';

class MenuPlatos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de Comida'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Plato 1'),
              subtitle: Text('Descripción del plato 1.'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Plato 2'),
              subtitle: Text('Descripción del plato 2.'),
            ),
          ),
          // Agrega más elementos de menú aquí...
        ],
      ),
    );
  }
}