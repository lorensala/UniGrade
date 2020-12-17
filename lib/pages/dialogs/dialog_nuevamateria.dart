import 'package:flutter/material.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/datamanager.dart';
import 'package:mis_notas/data/subject_dao.dart';

import 'package:cool_alert/cool_alert.dart';

class DialogNuevaMateria extends StatefulWidget {
  final Student _student;
  final BuildContext context;

  DialogNuevaMateria(this._student, this.context);
  @override
  _DialogNuevaMateriaState createState() => _DialogNuevaMateriaState();
}

class _DialogNuevaMateriaState extends State<DialogNuevaMateria> {
  //TODO: Hay que traer las materias que no tengan estado,o esten libres/abandonas.

  var db = DataManager();

  SubjectDao _subjectDao = SubjectDao();

  List<String> _conditions = [
    'Cursando',
    'Aprobada',
    'Promoción Teórica',
    'Promoción Práctica',
    'Aprobación Directa',
  ];

  Subject _selectedSubject;
  String _selectedCondition;

  Future<List<Subject>> _subjects;

  @override
  void initState() {
    _subjects = _subjectDao.getAllSubjectsByUser(widget._student);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget._student.getFullname());

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
                        future: _subjects,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());

                            default:
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
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
                Container(
                  width: 288.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(26.0),
                    color: const Color(0xfff7f7f7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _selectedCondition,
                        hint: new Text('Condicion'),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCondition = newValue;
                          });
                        },
                        items: _conditions
                            .map((String action) => DropdownMenuItem(
                                value: action, child: Text(action)))
                            .toList(),
                      ),
                    ),
                  ),
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
                        if (_selectedCondition != null &&
                            _selectedSubject != null) {
                          bool isDone =
                              await _subjectDao.updateSubjectCondition(
                                  widget._student,
                                  _selectedSubject,
                                  _selectedCondition);
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

                          //Navigator.pop(context);
                        } else {
                          //TODO: mostrar que hay que ingresar los datos.
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
              ],
            ),
          ),
        ));
  }
  //});
}
