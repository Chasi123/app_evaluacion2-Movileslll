import 'package:app_evaluacion2/screens/ComentariosScreen.dart';
import 'package:app_evaluacion2/screens/LoginScreen.dart';
import 'package:app_evaluacion2/screens/RegisterScreen.dart';
import 'package:app_evaluacion2/screens/SeriesScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => Loginscreen(),
        '/register': (context) => Registerscreen(),
        '/comentarios': (context) => Comentariosscreen(),
        '/series': (context) => Seriesscreen(),
      },
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome")),
      body: Column(
        children: [
          Text(
            "Desarrollador: Chrsitopher Chasiloa \n Usuario git: chasi123",
            style: TextStyle(fontSize: 20),
          ),
          FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: Text("Iniciar Sesión"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: Text("Registrarse"),
          ),
        ],
      ),
    );
  }
}
