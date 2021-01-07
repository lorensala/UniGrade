import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/entities/student.dart';

import 'package:mis_notas/pages/main/home.dart';
import 'package:mis_notas/pages/login/login_page.dart';
import 'package:mis_notas/pages/pages/mis_estadistica.dart';
import 'package:mis_notas/pages/pages/mis_materias.dart';
import 'package:mis_notas/pages/pages/mis_notas.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mis_notas/pages/login/new_user_login.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'entities/statistics.dart';

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

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizerUtil().init(constraints, orientation);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<Student>(
                  create: (context) => _activeStudent),
              ChangeNotifierProvider<Statistics>(
                  create: (context) => Statistics(0, 0, 0, 0, 0, 0, 0, 0, [])),
              ChangeNotifierProvider<ValueNotifier<bool>>(
                create: (context) => ValueNotifier<bool>(false),
              ),
              ChangeNotifierProvider<ValueNotifier<int>>(
                create: (context) => ValueNotifier<int>(1),
              ),
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
          );
        });
      }),
    ),
  );
}
