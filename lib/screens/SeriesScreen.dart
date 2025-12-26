import 'package:flutter/material.dart';
import 'dart:convert';

class Seriesscreen extends StatelessWidget {
  const Seriesscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("Series"),),
       drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Series"),
              onTap: () => Navigator.pushNamed(context, '/series'),
            ),
            ListTile(
              title: const Text("Comentarios"),
              onTap: () => Navigator.pushNamed(context, '/comentarios'),
            ),
          ],
        ),
      ),
      body: Listar(context),
    );
  }
}

Future<List> leerLista(context) async {
  final jsonString = await DefaultAssetBundle.of(context).loadString("assets/data/series.json");
  return json.decode(jsonString)['series'];
}

Widget Listar (context){
return FutureBuilder(future: leerLista(context), builder: (context, snapshot) {
    if(snapshot.hasData){
      List data = snapshot.data!;

      return ListView.builder( itemCount: data.length, itemBuilder:(context, index) {
        final item = data[index];

void detalles (context){
   showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Column(children: [
          Text(item['titulo'], style: TextStyle(fontSize: 28, color: Color.fromRGBO(214, 31, 31, 1)), ), 
          Image.network(item['info']['imagen'], width: 300, height: 300, fit: BoxFit.cover,),
          Text("Creador: ${item['metadata']['creador']}", style: TextStyle(fontSize: 25)),
          Text("Url de la pelicula: ${item['info']['url']}",),
          Text("año: ${item['anio']} ", style: TextStyle(fontSize: 30, color: Color.fromARGB(164, 88, 119, 204)),)
        ],)),
      );
}
        return Card(
          child: ListTile(
            title: Text(item['titulo'], style: TextStyle(fontSize: 25)),
            onTap: () =>detalles(context) ,
            subtitle: Column(children: [
              Text("Descripcion: ${item['descripcion']}",),
              Image.network(item['info']['imagen'], fit: BoxFit.cover,),

              ],) 
            ),
        );
      }, );

    }else{
      return CircularProgressIndicator();
    }
  }, );
}



