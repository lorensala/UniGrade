import 'package:flutter/material.dart';
import 'package:mis_notas/data/student_dao.dart';
import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/university.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class NewUserLogin extends StatefulWidget {
  @override
  _NewUserLoginState createState() => _NewUserLoginState();
}

class _NewUserLoginState extends State<NewUserLogin> {
  var _studentDao = StudentDao();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Student _newStudent = Provider.of<Student>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              Text(
                'UniGrade',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 50,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '¡Organiza tu carrera!',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 25,
                  color: const Color(0xff7c7979),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<ValueNotifier<bool>>(
                builder: (context, isNew, child) => Column(
                  children: <Widget>[
                    Text(
                      'Selecciona tu Universidad:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 16,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 288.0,
                      height: 37.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: const Color(0xfff7f7f7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: 'Universidad Tecnologica Nacional',
                              onChanged: (value) => {value},
                              //hint: new Text('Materia'),
                              items: [
                                DropdownMenuItem(
                                  child: Text('UTN-FRC'),
                                  value: 'Universidad Tecnologica Nacional',
                                )
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Selecciona tu carrera:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 16,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 288.0,
                      height: 37.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: const Color(0xfff7f7f7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isExpanded: true,
                              value: 'Ingeniería en Sistemas de Información',
                              onChanged: (value) => {value},
                              //hint: new Text('Materia'),
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                      'Ingeniería en Sistemas de Información'),
                                  value:
                                      'Ingeniería en Sistemas de Información',
                                )
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<Student>(
                      builder: (context, _student, child) => InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: isPressed
                            ? null
                            : () async {
                                setState(() {
                                  isPressed = true;
                                });
                                User _user = FirebaseAuth.instance.currentUser;
                                String _userId = _user.uid;

                                Student _student = Student(
                                    _user.displayName,
                                    _user.photoURL,
                                    [],
                                    _userId,
                                    University(
                                        [Career('Ingeniería en Sistemas')],
                                        'UTN',
                                        'UTN-FRC'),
                                    [''],
                                    '');

                                await _studentDao.addNewStudent(_student);

                                Navigator.of(context).pushNamed('/homepage');
                              },
                        child: Container(
                          width: 129.0,
                          height: 37.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.0),
                            color: const Color(0xffA7FFAD),
                          ),
                          child: Center(
                            child: Text(
                              'Confirmar',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 16,
                                color: const Color(0xff000000),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
