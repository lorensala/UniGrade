import 'package:flutter/material.dart';
import 'package:mis_notas/gui/home_page.dart';
import 'package:mis_notas/gui/mis_estadistica.dart';
import 'package:mis_notas/gui/mis_materias.dart';
import 'package:mis_notas/gui/mis_notas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'business/student.dart';
import 'business/subject.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Student>(
        create: (context) => Student('Lorenzo Sala', 7.45),
      ),
      ChangeNotifierProvider<Subject>(
        create: (context) => Subject('aasud', 1, 'AED', 'asgds', '173'),
      )
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
