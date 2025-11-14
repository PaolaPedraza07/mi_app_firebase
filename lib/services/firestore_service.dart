import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/movie.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<List<Movie>> streamMovies() {
    return _db.collection('peliculas')
      .orderBy('creadoEn', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => Movie.fromMap(d.id, d.data())).toList());
  }

  Future<void> addMovie(Movie movie) async {
    await _db.collection('peliculas').add(movie.toMap());
  }

  Future<void> deleteMovie(String id) async {
    await _db.collection('peliculas').doc(id).delete();
  }

  Future<String> uploadImage(File file, String filename) async {
    final ref = _storage.ref().child('peliculas/$filename');
    final task = await ref.putFile(file);
    return await task.ref.getDownloadURL();
  }
}
