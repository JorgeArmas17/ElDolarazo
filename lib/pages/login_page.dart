import 'package:dgs/components/my_button.dart';
import 'package:dgs/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_you_password.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      if (e.code == "user-not-found") {
        wrongEmailMessage();
      } else if (e.code == "wrong-password") {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                //Logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),

                //Welcome back
                Text(
                  'Welcome back, you have been missed',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //username textfield

                MyTextField(
                  controller: emailcontroller,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordcontroller,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      // Aquí rediriges a la otra pantalla
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Recuperar Contraseña',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //sign in button
                MyButton(
                  onTap: signUserIn,
                  text: 'Iniciar Sesión',
                ),

                const SizedBox(height: 10),
                //not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No tienes cuenta?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Registrate',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
