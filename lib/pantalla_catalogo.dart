import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pantalla_detalle.dart';
import 'pantalla_admin.dart';

class PantallaCatalogo extends StatelessWidget {
  const PantallaCatalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catálogo de Películas"),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => PantallaAdmin()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("peliculas").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final peliculas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (_, i) {
              var doc = peliculas[i];
              final data = doc.data();
              final imagen = (data['image'] ?? data['imagen'] ?? data['imagenUrl'] ?? '') as String;
              return ListTile(
                leading: imagen.isNotEmpty
                    ? Image.network(imagen, width: 60, fit: BoxFit.cover)
                    : Container(width: 60, height: 80, color: Colors.grey),
                title: Text(data['titulo'] ?? ''),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => PantallaDetalle(pelicula: data),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
