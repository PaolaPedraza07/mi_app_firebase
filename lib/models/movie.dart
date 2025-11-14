class Movie {
  final String id;
  final String titulo;
  final int anio;
  final String director;
  final String genero;
  final String sinopsis;
  final String imagenUrl;

  Movie({
    required this.id,
    required this.titulo,
    required this.anio,
    required this.director,
    required this.genero,
    required this.sinopsis,
  required this.imagenUrl,
  });

  factory Movie.fromMap(String id, Map<String,dynamic> map) {
    return Movie(
      id: id,
      titulo: map['titulo'] ?? '',
      anio: map['anio'] is int ? map['anio'] : int.tryParse('${map['anio']}') ?? 0,
      director: map['director'] ?? '',
      genero: map['genero'] ?? '',
      sinopsis: map['sinopsis'] ?? '',
      imagenUrl: map['image'] ?? map['imagenUrl'] ?? map['imagen'] ?? '',
    );
  }

  Map<String,dynamic> toMap() => {
    'titulo': titulo,
    'anio': anio,
    'director': director,
    'genero': genero,
    'sinopsis': sinopsis,
    // Guardamos varias claves para mantener compatibilidad con distintas versiones
    'imagenUrl': imagenUrl,
    'imagen': imagenUrl,
    'image': imagenUrl,
    'creadoEn': DateTime.now(),
  };
}
