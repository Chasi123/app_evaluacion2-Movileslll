import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Formulario(context),
    );
  }
}
Widget Formulario (context){
    TextEditingController correo = TextEditingController();
    TextEditingController contrasena = TextEditingController();

    return Column(children: [
Icon(Icons.login, size: 80),
        SizedBox(height: 20),
        TextField(
          controller: correo,
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: contrasena,
          obscureText: true,
          decoration:InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 20),
       FilledButton(onPressed: () => login(correo.text, contrasena.text, context), child: Text("Iniciar sescion"))
      ],  );
}

Future<void> login(correo, contrasena, context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
    Navigator.pushNamed(context, '/comentarios');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text("Usuario no encontrado.")),
      );
    } else if (e.code == 'wrong-password') {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text("Contraseña incorrecta.")),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text("Error: ${e.message}")),
      );
    }
  } catch (e) { showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text("${e}")),
      );
  }
}