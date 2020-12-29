import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mis_notas/entities/student.dart';

import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';

class DialogModificarNota extends StatefulWidget {
  final Student _student;

  DialogModificarNota(this._student);

  @override
  _DialogModificarNotaState createState() => _DialogModificarNotaState();
}

class _DialogModificarNotaState extends State<DialogModificarNota> {
  var _selectedSubject;
  var _selectedType;
  int _selectedNota;
  var _subjects;

  bool _hasSelectedData = true;
  bool _hasSelectedNota = false;

  TextEditingController _nota = new TextEditingController();

  SubjectDao _subjectDao = new SubjectDao();
  List<Subject> _auxNotas = new List<Subject>();

  var _types = ['Práctico', 'Teórico', 'TP', 'Final'];

  @override
  void initState() {
    _subjects = _subjectDao.getAllSubjectsWithCondition(widget._student);

    super.initState();
  }

  //TODO: Falta eliminar nota.

  List<int> getGrades(Subject sub, String selectedType) {
    List<int> notas = new List<int>();

    switch (selectedType) {
      case 'Práctico':
        {
          sub.getGradesP().forEach((nota) {
            if (nota != null && notas.contains(nota))
              notas.add(nota + 10);
            else
              notas.add(nota);
          });
          return notas;
        }

      case 'Teórico':
        {
          sub.getGradesT().forEach((nota) {
            if (nota != null && notas.contains(nota))
              notas.add(nota + 10);
            else
              notas.add(nota);
          });
          return notas;
        }
      case 'TP':
        {
          sub.getGradesTP().forEach((nota) {
            if (nota != null && notas.contains(nota))
              notas.add(nota + 10);
            else
              notas.add(nota);
          });
          return notas;
        }
      case 'Final':
        {
          if (sub.getAplazos().isNotEmpty)
            sub.getAplazos().forEach((nota) {
              if (nota != null && notas.contains(nota))
                notas.add(nota + 10);
              else
                notas.add(nota);
            });

          if (sub.getNf() != -1) notas.add(sub.getNf());

          return notas;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
        child: Container(
          width: 338.0,
          height: 320.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Modificar Nota',
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
                              List<Subject> _aux = new List<Subject>();
                              if (snapshot.hasError)
                                return Text('Unable to grab data');
                              else
                                snapshot.data.forEach((Subject sub) {
                                  if (sub.getGradesP().isNotEmpty ||
                                      sub.getGradesT().isNotEmpty ||
                                      sub.getGradesTP().isNotEmpty)
                                    _aux.add(sub);
                                });

                              _auxNotas = _aux;

                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: _selectedSubject,
                                  hint: new Text('Materia'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSubject = newValue;
                                      _selectedNota = null;
                                      //_selectedType = null;
                                      _nota.text = '';
                                    });
                                  },
                                  items: _aux.map<DropdownMenuItem<Subject>>(
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
                    color: Color(0xfff7f7f7),
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
                              _hasSelectedNota = true;
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

                                //isExpanded: true,
                                value: _selectedNota,
                                hint: new Text('Nota'),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedNota = newValue;
                                  });
                                },
                                items: (_hasSelectedNota)
                                    ? getGrades(_selectedSubject, _selectedType)
                                        .map(
                                            (int nota) => DropdownMenuItem<int>(
                                                  value: nota,
                                                  child: Text(nota > 10
                                                      ? (nota - 10).toString()
                                                      : nota.toString()),
                                                ))
                                        .toList()
                                    : null)))),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(26),
                  onTap: () async {
                    if (_selectedSubject != null &&
                        _selectedType != null &&
                        _selectedNota != null) {
                      setState(() {
                        _hasSelectedData = true;
                      });

                      bool isDone = await _subjectDao.deleteGrade(
                        widget._student,
                        _selectedNota,
                        _selectedSubject,
                        _selectedType,
                      );

                      if (isDone) {
                        await CoolAlert.show(
                            borderRadius: 26,
                            title: 'Éxito',
                            backgroundColor: Colors.white,
                            context: context,
                            type: CoolAlertType.success,
                            text: 'Nota eliminada con exito!');

                        Navigator.pop(context);
                      } else {
                        CoolAlert.show(
                            borderRadius: 26,
                            title: 'Error',
                            backgroundColor: Colors.white,
                            context: context,
                            type: CoolAlertType.error,
                            text: 'Error al eliminar la nota');
                      }
                    } else {
                      setState(() {
                        _hasSelectedData = false;
                      });
                    }
                  },
                  child: Expanded(
                    child: Container(
                      //width: 129.0,
                      height: 37.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: Color(0xffFF9A9A),
                      ),
                      child: Center(
                        child: Text(
                          'Eliminar Nota',
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
                            _selectedNota != null) {
                          setState(() {
                            _hasSelectedData = true;
                          });

                          bool isDone = await _subjectDao.updateGrade(
                              widget._student,
                              _selectedNota,
                              _selectedSubject,
                              _selectedType,
                              int.parse(_nota.text));

                          if (isDone) {
                            await CoolAlert.show(
                                borderRadius: 26,
                                title: 'Éxito',
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.success,
                                text: 'Nota modificada con exito!');

                            Navigator.pop(context);
                          } else {
                            CoolAlert.show(
                                borderRadius: 26,
                                title: 'Error',
                                backgroundColor: Colors.white,
                                context: context,
                                type: CoolAlertType.error,
                                text: 'Error al modificar la nota');
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
                            'Modificar',
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
