import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/pages/home_page.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  final Function() toProcess;
  final Widget child;
  final Color backgroundColor;

  SplashScreen(this.child, this.toProcess, {this.backgroundColor});
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.lightBlue,
      ),
    );
  }
}
