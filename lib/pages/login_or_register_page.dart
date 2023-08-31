import "package:dgs/pages/register_page.dart";
import "package:flutter/material.dart";

import "login_page.dart";

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLogingPage = true;

  void togglePages() {
    setState(() {
      showLogingPage = !showLogingPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogingPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
