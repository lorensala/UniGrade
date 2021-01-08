import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';

import 'package:cool_alert/cool_alert.dart';

class DialogActualizarMateria extends StatefulWidget {
  final Student _student;

  DialogActualizarMateria(this._student);
  @override
  _DialogActualizarMateriaState createState() =>
      _DialogActualizarMateriaState();
}

class _DialogActualizarMateriaState extends State<DialogActualizarMateria> {
  //var db = DataManager();

  bool _hasSelectedData = true;
  bool _isEmpty = false;

  SubjectsDao _subjectDao = SubjectsDao();

  List<String> _conditions = [
    'Regular',
    'Promoción Teórica',
    'Promoción Práctica',
    'Aprobación Directa',
    'Libre',
    'Abandonada'
  ];
  List<String> _conditionsEmpty = ['Libre', 'Abandonada', 'Aprobación Directa'];

  Subject _selectedSubject;
  String _selectedCondition;

  Future<List<Subject>> _subjects;

  @override
  void initState() {
    _subjects =
        _subjectDao.getAllSubjectsByUserCondition(widget._student, 'Cursando');
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
                  'Actualizar Materia',
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
                              return Center(
                                  child: Lottie.asset(
                                      'assets/lottie/loading.json'));

                            default:
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedSubject,
                                  onChanged: (Subject newValue) {
                                    setState(() {
                                      _selectedSubject = newValue;
                                      if (newValue.getGradesP().isEmpty &&
                                          newValue.getGradesT().isEmpty &&
                                          newValue.getGradesTP().isEmpty)
                                        _isEmpty = true;
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
                            _hasSelectedData = true;
                          });
                        },
                        items: _isEmpty
                            ? _conditionsEmpty
                                .map((String action) => DropdownMenuItem(
                                    value: action, child: Text(action)))
                                .toList()
                            : _conditions
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
                          setState(() {
                            _hasSelectedData = true;
                          });
                          bool isDone =
                              await _subjectDao.updateSubjectCondition(
                                  widget._student,
                                  _selectedSubject,
                                  _selectedCondition);
                          if (isDone) {
                            await CoolAlert.show(
                                borderRadius: 26,
                                title: 'Éxito',
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.success,
                                text: '¡Materia actualizada con exito!');

                            Navigator.pop(context);
                          } else {
                            CoolAlert.show(
                                borderRadius: 26,
                                title: 'Error',
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.error,
                                text: 'Error al actualizar la materia');
                          }

                          //Navigator.pop(context);
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
