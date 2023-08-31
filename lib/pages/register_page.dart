import 'package:dgs/common/enums.dart';
import 'package:dgs/components/my_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  GlobalKey<FormState> keyFrom = GlobalKey<FormState>();
  //sign user up method
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //Creacion de nuevo usuario
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userNameController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Contraseña no Coincide");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      body: SafeArea(
        child: Center(
          child: Form(
            key: keyFrom,
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 25),
                //logo
                const Icon(
                  Icons.app_registration,
                  size: 150,
                ),

                const SizedBox(height: 10),
                //welcome back, you've been mised
                Text(
                  'Forma parte de esta Comunidad',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //username textfield
                MyTextFormField(
                  userNameController,
                  'Email',
                  false,
                  validateText: ValidateText.email,
                ),

                const SizedBox(height: 10),

                MyTextFormField(
                  passwordController,
                  'Contraseña',
                  true,
                  validateText: ValidateText.password,
                ),

                const SizedBox(height: 10),
                //password textfield
                MyTextFormField(
                  passwordController,
                  'Contraseña',
                  true,
                  validateText: ValidateText.password,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  onTap: () {
                    if (keyFrom.currentState!.validate()) {
                      signUserUp();
                    }
                  },
                  text: 'Registrate',
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ya tienes cuenta?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )

                //not a member? register now
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
