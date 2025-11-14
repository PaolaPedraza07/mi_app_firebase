import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final TextEditingController nombreCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro de Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection("usuarios").add({
                  "nombre": nombreCtrl.text,
                  "fecha": DateTime.now(),
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Usuario registrado"))
                );
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
