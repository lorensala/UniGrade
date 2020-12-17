import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mis_notas/data/student_dao.dart';
import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/pages/home_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var _studentDao = StudentDao();

  Future<void> addStudent() async {
    User _user = FirebaseAuth.instance.currentUser;
    String _userId = _user.uid;

    Student _student = Student(
        _user.displayName,
        _user.photoURL,
        [],
        _userId,
        University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
        [''],
        '');

    await _studentDao.addNewStudent(_student);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: addStudent(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator());
              }
            default:
              Navigator.popAndPushNamed(context, '/homepage');
          }
        });
  }
}
