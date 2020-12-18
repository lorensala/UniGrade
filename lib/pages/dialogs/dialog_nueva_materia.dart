import 'package:flutter/material.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';

import 'package:cool_alert/cool_alert.dart';

class DialogNuevaMateria extends StatefulWidget {
  final Student _student;

  DialogNuevaMateria(this._student);
  @override
  _DialogNuevaMateriaState createState() => _DialogNuevaMateriaState();
}

class _DialogNuevaMateriaState extends State<DialogNuevaMateria> {
  //var db = DataManager();

  bool _hasSelectedData = true;
  bool _habilitarRecursado = false;

  SubjectDao _subjectDao = SubjectDao();

  Subject _selectedSubject;

  Future<List<Subject>> _subjectsNoCondition;

  @override
  void initState() {
    _subjectsNoCondition =
        _subjectDao.getAllSubjectsWithNoCondition(widget._student);
    //Este trae de todas las materias sin condicion.

    super.initState();
  }

  List<Subject> getSubjectsRecursar(List<Subject> _subjectsList) {
    List<Subject> _aux = new List<Subject>();
    _subjectsList.forEach((subject) {
      if (subject.getState().getState().getName() == 'Libre' ||
          subject.getState().getState().getName() == 'Abandonada') {
        _aux.add(subject);
      }
    });

    return _aux;
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
                  'Nueva Materia',
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
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _habilitarRecursado,
                      onChanged: (value) {
                        setState(() {
                          _habilitarRecursado = value;
                        });
                      },
                    ),
                    Text(
                      'Habilitar recursada',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 16,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
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
                        future: _habilitarRecursado
                            ? _subjectDao
                                .getAllSubjectsByUser(widget._student)
                                .then((_list) {
                                return getSubjectsRecursar(_list);
                              })
                            : _subjectsNoCondition,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());

                            default:
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedSubject,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSubject = newValue;
                                    });
                                  },
                                  hint: new Text('Materia'),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () async {
                        if (_selectedSubject != null) {
                          setState(() {
                            _hasSelectedData = true;
                          });

                          bool isDone = false;

                          if (!_habilitarRecursado)
                            isDone = await _subjectDao.updateSubjectCondition(
                                widget._student, _selectedSubject, 'Cursando');
                          else {
                            isDone = await _subjectDao.addSubject(
                                widget._student, _selectedSubject);
                          }

                          isDone
                              ? CoolAlert.show(
                                  borderRadius: 26,
                                  title: 'Éxito',
                                  backgroundColor: Colors.white,
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: '¡Materia actualizada con exito!')
                              : CoolAlert.show(
                                  borderRadius: 26,
                                  title: 'Error',
                                  backgroundColor: Colors.white,
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: 'Error al actualizar la nota');
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
  //});
}
