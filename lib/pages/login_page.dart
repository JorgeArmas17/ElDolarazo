import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: const Column(
            children: [
              SizedBox(height: 50),

              //logo
              Icon(
                Icons.lock,
                size: 100,
              ),

              SizedBox(height: 50),

              //Welcome back,
              Text('Bienvenidos, te hemos extrañado'),

              //username textfiedl

              //AÑADIR tus demas campos
            ],
          ),
        ),
      ),
    );
  }
}
