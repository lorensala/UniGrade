import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mis_notas/data/statistics_dao.dart';
import 'package:mis_notas/data/student_dao.dart';

import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/university.dart';

import 'package:mis_notas/pages/home_page.dart';
import 'package:mis_notas/pages/login/login_page.dart';
import 'package:mis_notas/pages/mis_estadistica.dart';
import 'package:mis_notas/pages/mis_materias.dart';
import 'package:mis_notas/pages/mis_notas.dart';
import 'package:mis_notas/pages/testPage.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:mis_notas/services/statistics.dart';

import 'package:mis_notas/widgets/colors.dart';

import 'package:provider/provider.dart';

import 'entities/student.dart';

Future<void> main() async {
  final StudentDao _studentDao = new StudentDao();
  bool _isLoggedIn = false;

  Student _activeStudent = Student(
      '',
      '',
      [],
      '',
      University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
      [''],
      '');

  //var _statisticsDao = new StatisticsDao();

  // Wait for Firebase to load in...

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser != null) {
    _isLoggedIn = true;

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<Student>(create: (context) => _activeStudent),
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
          initialRoute: _isLoggedIn ? '/homepage' : '/login',
          routes: {
            '/login': (context) => LoginPage(),
            '/homepage': (context) => HomePage(),
            '/mismaterias': (context) => MisMaterias(),
            '/misnotas': (context) => MisNotas(),
            '/estadisticas': (context) => MisEstadisticas(),
          },
          debugShowCheckedModeBanner: false),
    ));
  }
}
