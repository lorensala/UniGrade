import 'package:flutter/material.dart';
import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/university.dart';

import 'package:mis_notas/pages/home_page.dart';
import 'package:mis_notas/pages/mis_estadistica.dart';
import 'package:mis_notas/pages/mis_materias.dart';
import 'package:mis_notas/pages/mis_notas.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'entities/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Student('Lorenzo Sala', '', [], '',
      University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Student>(
          create: (context) => Student(
              'Lorenzo\nSala',
              '',
              [],
              '',
              University(
                  [Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'))),
    ],
    child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/mismaterias': (context) => MisMaterias(),
          '/misnotas': (context) => MisNotas(),
          '/estadisticas': (context) => MisEstadisticas(),
        },
        debugShowCheckedModeBanner: false),
  ));
}
