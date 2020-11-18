import 'package:flutter/material.dart';
import 'package:mis_notas/interface/homepage.dart';
import 'package:mis_notas/interface/login.dart';
import 'package:mis_notas/interface/navegation.dart';
import 'package:mis_notas/interface/profile.dart';
import 'package:mis_notas/interface/statspage.dart';

void main() => runApp(MaterialApp(        
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/nav': (context) => Navegation(),
      '/homepage': (context) => HomePage(),
      '/statspage': (context) => ChartApp(),
      '/profilepage': (context) => ProfilePage()
    },
    debugShowCheckedModeBanner: false));
