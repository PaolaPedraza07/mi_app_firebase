import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PantallaAdmin extends StatefulWidget {
  const PantallaAdmin({super.key});

  @override
  State<PantallaAdmin> createState() => _PantallaAdminState();
}

class _PantallaAdminState extends State<PantallaAdmin> {
  final TextEditingController titulo = TextEditingController();
  final TextEditingController anio = TextEditingController();
  final TextEditingController director = TextEditingController();
  final TextEditingController genero = TextEditingController();
  final TextEditingController sinopsis = TextEditingController();
  final TextEditingController imagen = TextEditingController();

  void agregarPelicula() {
    FirebaseFirestore.instance.collection("peliculas").add({
      "titulo": titulo.text,
      "anio": int.tryParse(anio.text) ?? 0,
      "director": director.text,
      "genero": genero.text,
      "sinopsis": sinopsis.text,
      // Guardar en varias claves para compatibilidad
      "imagen": imagen.text,
      "imagenUrl": imagen.text,
      "image": imagen.text,
    });

    titulo.clear();
    anio.clear();
    director.clear();
    genero.clear();
    sinopsis.clear();
    imagen.clear();
  }

  void eliminarPelicula(String id) {
    FirebaseFirestore.instance.collection("peliculas").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Administración de Películas")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text("Agregar nueva película", style: TextStyle(fontSize: 18)),
          TextField(controller: titulo, decoration: InputDecoration(labelText: "Título")),
          TextField(controller: anio, decoration: InputDecoration(labelText: "Año")),
          TextField(controller: director, decoration: InputDecoration(labelText: "Director")),
          TextField(controller: genero, decoration: InputDecoration(labelText: "Género")),
          TextField(controller: sinopsis, decoration: InputDecoration(labelText: "Sinopsis")),
          TextField(controller: imagen, decoration: InputDecoration(labelText: "URL de imagen")),
          SizedBox(height: 20),
          ElevatedButton(onPressed: agregarPelicula, child: Text("Guardar")),
          Divider(),
          Text("Películas actuales", style: TextStyle(fontSize: 18)),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("peliculas").snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              final docs = snapshot.data!.docs;

              return Column(
                children: docs.map((p) {
                  return ListTile(
                    title: Text(p['titulo']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => eliminarPelicula(p.id),
                    ),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
