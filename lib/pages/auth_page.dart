import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dgs/pages/platosform.dart';
import 'package:dgs/pages/platosview.dart';
import 'package:dgs/pages/redesociales.dart';
import 'package:dgs/pages/restaurantform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_or_register_page.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return BottomNavigation();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    RestauranteForm(),
    DishForm(),
    Dish(),
    SocialMediaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xffD6E2EA),
        color: Color.fromARGB(255, 108, 165, 218),
        animationDuration: Duration(milliseconds: 300),
        items: const [
          Icon(Icons.restaurant, color: Color.fromARGB(255, 0, 0, 0)),
          Icon(Icons.fastfood, color: Color.fromARGB(255, 0, 0, 0)),
          Icon(Icons.mode_edit_outline_rounded,
              color: Color.fromARGB(255, 0, 0, 0)),
          Icon(Icons.alternate_email_rounded,
              color: Color.fromARGB(255, 0, 0, 0)),
        ],
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
