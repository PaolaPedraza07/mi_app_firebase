import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      home: AgregarDatosPage(),
    );
  }
}

class AgregarDatosPage extends StatelessWidget {
  AgregarDatosPage({super.key});

  final TextEditingController nombreController = TextEditingController();

  Future<void> guardarNombre() async {
    await FirebaseFirestore.instance.collection('usuarios').add({
      'nombre': nombreController.text,
      'fecha': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar datos a Firebase')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Escribe un nombre',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: guardarNombre,
              child: const Text('Guardar en Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
