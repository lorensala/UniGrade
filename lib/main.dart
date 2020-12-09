import 'package:flutter/material.dart';
import 'package:mis_notas/gui/home_page.dart';
import 'package:mis_notas/gui/mis_estadistica.dart';
import 'package:mis_notas/gui/mis_materias.dart';
import 'package:mis_notas/gui/mis_notas.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/mismaterias': (context) => MisMaterias(),
        '/misnotas': (context) => MisNotas(),
        '/estadisticas': (context) => MisEstadisticas(),
      },
      debugShowCheckedModeBanner: false));
}
