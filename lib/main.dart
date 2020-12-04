import 'package:flutter/material.dart';
import 'package:mis_notas/gui/home_page.dart';
import 'package:mis_notas/gui/mis_estadistica.dart';
import 'package:mis_notas/gui/mis_materias.dart';
import 'package:mis_notas/gui/mis_notas.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Avenir LT Std'),
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/mismaterias': (context) => MisMaterias(),
      '/misnotas': (context) => MisNotas(),
      '/estadisticas': (context) => MisEstadisticas(),
    },
    debugShowCheckedModeBanner: false));
