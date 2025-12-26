import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Comentariosscreen extends StatelessWidget {
  const Comentariosscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comentarios")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Series"),
              onTap: () => Navigator.pushNamed(context, '/series'),
            ),
            ListTile(
              title: const Text("Comentarios"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: comentarios(context),
    );
  }
}

Widget comentarios(BuildContext context) {

  TextEditingController id = TextEditingController();
  TextEditingController serie = TextEditingController();
  TextEditingController comentario = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: id,
        decoration: InputDecoration(labelText: "ID Comentario"),
        style: TextStyle(fontSize: 20),
        
      ),
      TextField(
        controller: serie,
        decoration: InputDecoration(labelText: "Serie"),
        style: TextStyle(fontSize: 20),

      ),
      TextField(
        controller: comentario,
        decoration: InputDecoration(labelText: "Comentario"),
        style: TextStyle(fontSize: 20),


      ),
      ElevatedButton(onPressed: () => guardarCoemntario(id.text, serie.text, comentario.text),child: const Text("Guardar Comentario"),)
    ],
  );
}

Future<void> guardarCoemntario(id, serie, comentario) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("comentarios/$id");

  await ref.set({
    "id": id,
    "serie": serie,
    "comentario": comentario,
  });
}
