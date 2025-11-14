import 'package:flutter/material.dart';

class PantallaDetalle extends StatelessWidget {
  final Map<String, dynamic> pelicula;

  const PantallaDetalle({required this.pelicula, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pelicula['titulo'])),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leer la imagen desde cualquiera de las claves posibles
              Builder(builder: (_) {
                final img = (pelicula['image'] ?? pelicula['imagenUrl'] ?? pelicula['imagen'] ?? '') as String;
                if (img.isNotEmpty) return Image.network(img);
                return const SizedBox.shrink();
              }),
              SizedBox(height: 20),
              Text("Título: ${pelicula['titulo']}", style: TextStyle(fontSize: 20)),
              Text("Año: ${pelicula['anio']}"),
              Text("Director: ${pelicula['director']}"),
              Text("Género: ${pelicula['genero']}"),
              SizedBox(height: 10),
              Text("Sinopsis:\n${pelicula['sinopsis']}"),
            ],
          ),
        ),
      ),
    );
  }
}
