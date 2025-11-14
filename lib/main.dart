import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
// Usar los archivos reales en `lib/` (nombres en español)
import 'pantalla_inicio.dart';
import 'pantalla_catalogo.dart';
import 'pantalla_admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Pantalla inicial
      home: const PantallaInicio(),

      // Rutas
      routes: {
        '/catalogo': (_) => const PantallaCatalogo(),
        '/admin': (_) => const PantallaAdmin(),
      },
    );
  }
}
