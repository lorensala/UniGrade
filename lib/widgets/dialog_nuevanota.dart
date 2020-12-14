import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/student.dart';

import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/university.dart';

class DialogNuevaNota extends StatefulWidget {
  @override
  _DialogNuevaNotaState createState() => _DialogNuevaNotaState();
}

class _DialogNuevaNotaState extends State<DialogNuevaNota> {
  var _selectedSubject;
  var _selectedType;

  TextEditingController _nota = new TextEditingController();

  SubjectDao _subjectDao = new SubjectDao();

  var _types = ['Práctico', 'Teórico', 'TP', 'Final'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
        child: Container(
          width: 338.0,
          height: 250.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nueva Nota',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 22,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w900,
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
                    child: FutureBuilder(
                        future: _subjectDao.getAllSubjectsByUser(Student(
                            'Lorenzo Sala',
                            '',
                            [],
                            '',
                            University([Career('Ingeniería en Sistemas')],
                                'UTN', 'UTN-FRC'))),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());

                            default:
                              if (snapshot.hasError)
                                return Text('Unable to grab data');
                              else
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: _selectedSubject,
                                    hint: new Text('Materia'),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedSubject = newValue;
                                      });
                                    },
                                    items: snapshot.data
                                        .map<DropdownMenuItem<Subject>>(
                                            (Subject sub) {
                                      return DropdownMenuItem<Subject>(
                                        value: sub,
                                        child: Text(sub.getName()),
                                      );
                                    }).toList(),
                                  ),
                                );
                          }
                        }),
                  ),
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
                          value: _selectedType,
                          hint: new Text('Tipo de Nota'),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedType = newValue;
                            });
                          },
                          items: _types
                              .map((type) => DropdownMenuItem(
                                  child: Text(type), value: type))
                              .toList()),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Nota:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 16,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      width: 76.0,
                      height: 37.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: const Color(0xfff7f7f7),
                      ),
                      child: TextField(
                        controller: _nota,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(
                              RegExp(r'^(?:[1-9]|0[1-9]|10)$')),
                          LengthLimitingTextInputFormatter(2),
                          //BlacklistingTextInputFormatter(RegExp(''))
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10)),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        _subjectDao.addGrade(int.parse(_nota.text),
                            _selectedSubject, _selectedType);
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
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
