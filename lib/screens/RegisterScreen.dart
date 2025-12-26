import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: formularioRegister(context));
  }
}

Widget formularioRegister(BuildContext context) {
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasena = TextEditingController();

  return Column(
    children: [
      const Icon(Icons.app_registration, size: 80),
      SizedBox(height: 20),
      TextField(
        controller: correo,
        decoration: const InputDecoration(
          labelText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
      ),
      SizedBox(height: 15),
      TextField(
        controller: contrasena,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(Icons.lock),
        ),
      ),
      SizedBox(height: 20),
      FilledButton(
        onPressed: () {
          registrarUsuario(correo.text, contrasena.text, context);
        },
        child: const Text("Registrar"),
      ),
    ],
  );
}

Future<void> registrarUsuario(correo, contrasena, context) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
    Navigator.pushNamed(context, '/login');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(content: Text("La contraseña es muy débil.")),
      );
    } else if (e.code == 'email-already-in-use') {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(content: Text("El correo ya está registrado.")),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text("Error: ${e.message}")),
      );
    }
  } catch (e) {
    print(e);
  }
}
