import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'package:mis_notas/entities/student.dart';

import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';

class DialogNuevaNota extends StatefulWidget {
  final Student _student;

  DialogNuevaNota(this._student);

  @override
  _DialogNuevaNotaState createState() => _DialogNuevaNotaState();
}

class _DialogNuevaNotaState extends State<DialogNuevaNota> {
  var _selectedSubject;
  var _selectedType;
  Future<List<Subject>> _subjects;
  bool _hasSelectedData = true;

  TextEditingController _nota = new TextEditingController();

  SubjectDao _subjectDao = new SubjectDao();

  var _types = ['Práctico', 'Teórico', 'TP', 'Final'];

  @override
  void initState() {
    _subjects = _subjectDao.getAllSubjectsWithCondition(widget._student);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
        child: Container(
          width: 338.0,
          height: 250.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nueva Nota',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 22,
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
                    child: FutureBuilder(future: _subjects.then((_list) {
                      List<Subject> _aux = new List<Subject>();
                      _list.forEach((subject) {
                        if (subject.getState().getState().getName() !=
                                'Libre' &&
                            subject.getState().getState().getName() !=
                                'Abandonada' &&
                            subject.getNf() == -1) _aux.add(subject);
                      });
                      return _aux;
                    }), builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                              child:
                                  Lottie.asset('assets/lottie/loading.json'));

                        default:
                          if (snapshot.hasError)
                            return Text('Unable to grab data');
                          else
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
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
                              _hasSelectedData = true;
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
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 10)),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () async {
                        if (_selectedSubject != null &&
                            _selectedType != null &&
                            _nota.text != '' &&
                            1 < int.parse(_nota.text) &&
                            int.parse(_nota.text) < 11) {
                          setState(() {
                            _hasSelectedData = true;
                          });

                          bool isDone = await _subjectDao.addGrade(
                              widget._student,
                              int.parse(_nota.text),
                              _selectedSubject,
                              _selectedType);

                          if (isDone) {
                            await CoolAlert.show(
                                borderRadius: 26,
                                title: 'Éxito',
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.success,
                                text: 'Nota añadida con exito!');

                            if (_selectedType == 'Final')
                              Navigator.pop(context);

                            _nota.text = '';
                          } else {
                            CoolAlert.show(
                                borderRadius: 26,
                                title: 'Error',
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.error,
                                text: 'Error al añadir la nota');
                          }
                        } else {
                          setState(() {
                            _hasSelectedData = false;
                          });
                        }
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
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !_hasSelectedData,
                  child: Center(
                    child: Text(
                      '¡No se seleccionaron datos!',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
