import 'package:el_dolarazo/pages/formulario.dart';
import 'package:el_dolarazo/pages/login_page.dart';
import 'package:el_dolarazo/pages/menu.dart';
import 'package:el_dolarazo/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la página del menú cuando se presione el botón "Menú"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPlatos()),
                );
              },
              child: Text('Ver Menú de Comida'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a otra página (puedes reemplazar `OtherPage` con tu propia página)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OtherPage()),
                );
              },
              child: Text('Ir a otro formulario'),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otro Formulario'),
      ),
      body: Center(
        child: Text('Contenido del otro formulario'),
      ),
    );
  }
}
