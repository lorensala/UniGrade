import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/university.dart';

import 'package:mis_notas/pages/home_page.dart';
import 'package:mis_notas/pages/loading_screen.dart';
import 'package:mis_notas/pages/login/login_page.dart';
import 'package:mis_notas/pages/mis_estadistica.dart';
import 'package:mis_notas/pages/mis_materias.dart';
import 'package:mis_notas/pages/mis_notas.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:mis_notas/services/statistics.dart';
import 'package:mis_notas/pages/login/new_user_login.dart';

import 'package:provider/provider.dart';

import 'entities/student.dart';

void main() async {
  bool _isLoggedIn = false;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Student _activeStudent = Student(
      '',
      '',
      [],
      '',
      University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
      [''],
      '');

  // Wait for Firebase to load in...

  if (FirebaseAuth.instance.currentUser != null) _isLoggedIn = true;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Student>(create: (context) => _activeStudent),
      ChangeNotifierProvider<StatisticsService>(
          create: (context) => StatisticsService()),
      ChangeNotifierProvider<ValueNotifier<bool>>(
        create: (context) => ValueNotifier<bool>(false),
      )
    ],
    child: MaterialApp(
        initialRoute: _isLoggedIn ? '/homepage' : '/login',
        routes: {
          '/': (context) => NewUserLogin(),
          '/login': (context) => LoginPage(),
          '/homepage': (context) => HomePage(),
          '/mismaterias': (context) => MisMaterias(),
          '/misnotas': (context) => MisNotas(),
          '/estadisticas': (context) => MisEstadisticas(),
        },
        debugShowCheckedModeBanner: false),
  ));
}
