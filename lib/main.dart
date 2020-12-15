import 'package:flutter/material.dart';
import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/university.dart';

import 'package:mis_notas/pages/home_page.dart';
import 'package:mis_notas/pages/login/login_page.dart';
import 'package:mis_notas/pages/mis_estadistica.dart';
import 'package:mis_notas/pages/mis_materias.dart';
import 'package:mis_notas/pages/mis_notas.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mis_notas/pages/testPage.dart';
import 'package:mis_notas/services/statistics.dart';
import 'package:mis_notas/widgets/colors.dart';

import 'package:provider/provider.dart';

import 'entities/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Student>(
          create: (context) => Student(
              'Lorenzo Sala',
              '',
              [],
              '',
              University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
              ['sw98JGNJh4XL9WRVVzBN'],
              'Kynm7JSEA7ZyPpgyD9jp')),
      ChangeNotifierProvider<StatisticsService>(
          create: (context) => StatisticsService()),
    ],
    child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Avenir LT Std',
            textTheme: TextTheme(
              headline1: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 30,
                color: textColor,
                fontWeight: FontWeight.w800,
              ),
              headline2: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 18,
                color: textColor2,
                fontWeight: FontWeight.w800,
              ),
              headline3: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 14,
                color: const Color(0xff9a9a9a),
                fontWeight: FontWeight.w300,
              ),
              headline4: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 22,
                color: const Color(0xff484848),
                fontWeight: FontWeight.w900,
              ),
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/homepage': (context) => HomePage(),
          '/mismaterias': (context) => MisMaterias(),
          '/misnotas': (context) => MisNotas(),
          '/estadisticas': (context) => MisEstadisticas(),
        },
        debugShowCheckedModeBanner: false),
  ));
}
