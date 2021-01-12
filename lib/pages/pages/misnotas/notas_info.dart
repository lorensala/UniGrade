import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/widgets/styles/grade_card_style.dart';
import 'package:provider/provider.dart';

class NotasInfo extends StatefulWidget {
  final Subject _subject;

  NotasInfo(this._subject);

  @override
  _NotasInfoState createState() => _NotasInfoState();
}

class _NotasInfoState extends State<NotasInfo> {
  String _selectedTypeAdd;
  var _notaAdd;
  bool _hasSelectedDataAdd = false;
  String _selectedTypeDel;
  var _notaDel;
  bool _hasSelectedDataDel = false;
  String _selectedTypeMod;
  var _notaMod;
  bool _hasSelectedDataMod = false;
  var _newNota;
  SubjectsDao _subejctDao = new SubjectsDao();
  bool done = false;

  //TODO: Implementar logica para ver si cambia realmente.
  bool changed = false;

  //TODO: SI ingresa una nota final, deberia marcar como terminó la materia.
  //TODO: Provider de estudiante con sus respectivas materias!

  var _types = ['Práctico', 'Teórico', 'TP', 'Final'];
  var _notas = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  List<String> _getGrades(String _type) {
    List<String> _grades = new List<String>();

    switch (_type) {
      case 'Práctico':
        widget._subject.getGradesP().toSet().toList().forEach((grade) {
          _grades.add(grade.toString());
        });
        return _grades;

      case 'Teórico':
        widget._subject.getGradesT().toSet().toList().forEach((grade) {
          _grades.add(grade.toString());
        });
        return _grades;

      case 'TP':
        widget._subject.getGradesTP().toSet().toList().forEach((grade) {
          _grades.add(grade.toString());
        });
        return _grades;

      case 'Final':
        widget._subject.getAplazos().toSet().toList().forEach((grade) {
          _grades.add(grade.toString());
        });
        if (widget._subject.getNf() != -1)
          _grades.add(widget._subject.getNf().toString());
        return _grades;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GradeCard(widget._subject, false),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Text(
            'Añadir Nota',
            style: TextStyle(
              fontFamily: 'Avenir LT Std',
              fontSize: 22,
              color: const Color(0xff484848),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
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
                      value: _selectedTypeAdd,
                      hint: new Text('Tipo de Nota'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedTypeAdd = newValue;
                          if (_notaAdd != null) _hasSelectedDataAdd = true;

                          _selectedTypeDel = null;
                          _notaDel = null;
                          _hasSelectedDataDel = false;
                          _selectedTypeMod = null;
                          _notaMod = null;
                          _newNota = null;
                          _hasSelectedDataMod = false;
                        });
                      },
                      items: _types
                          .map((type) =>
                              DropdownMenuItem(child: Text(type), value: type))
                          .toList()),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            children: [
              Container(
                //width: 288.0,
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xfff7f7f7),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _notaAdd,
                        hint: new Text('Nota'),
                        onChanged: (newValue) {
                          setState(() {
                            _notaAdd = newValue;
                            if (_selectedTypeAdd != null)
                              _hasSelectedDataAdd = true;

                            _selectedTypeDel = null;
                            _notaDel = null;
                            _hasSelectedDataDel = false;
                            _selectedTypeMod = null;
                            _notaMod = null;
                            _newNota = null;
                            _hasSelectedDataMod = false;
                          });
                        },
                        items: _notas
                            .map((type) => DropdownMenuItem(
                                child: Text(type), value: type))
                            .toList()),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (_hasSelectedDataAdd &&
                      _selectedTypeAdd != null &&
                      _notaAdd != null) {
                    int nota = int.parse(_notaAdd);

                    switch (_selectedTypeAdd) {
                      case 'Práctico':
                        if (widget._subject.getGradesP().length < 6)
                          widget._subject.addgradeP(nota);
                        break;

                      case 'Teórico':
                        if (widget._subject.getGradesT().length < 6)
                          widget._subject.addgradeT(nota);
                        break;

                      case 'TP':
                        if (widget._subject.getGradesTP().length < 6)
                          widget._subject.addgradeTP(nota);
                        break;

                      case 'Final':
                        if (widget._subject.getAplazos().length <= 3) {
                          if (nota > 5)
                            //TODO: Mostrar mensaje para que ponga la condicion
                            widget._subject.nf(nota);
                          else
                            widget._subject.addgradeAp(nota);
                          break;
                        }
                    }

                    changed = true;

                    setState(() {});
                  }
                },
                child: Container(
                  width: 38.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.0),
                    color: const Color(0xffa7ffad),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Text(
            'Eliminar Nota',
            style: TextStyle(
              fontFamily: 'Avenir LT Std',
              fontSize: 22,
              color: const Color(0xff484848),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 288.0,
              height: 37.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                color: const Color(0xfff7f7f7),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: _selectedTypeDel,
                      hint: new Text('Tipo de Nota'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedTypeDel = newValue;
                          if (_notaDel != null) _hasSelectedDataDel = true;

                          _selectedTypeAdd = null;
                          _notaAdd = null;
                          _hasSelectedDataAdd = false;
                          _selectedTypeMod = null;
                          _notaMod = null;
                          _newNota = null;
                          _hasSelectedDataMod = false;
                        });
                      },
                      items: _types
                          .map((type) => DropdownMenuItem<String>(
                              child: Text(type), value: type))
                          .toList()),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            children: [
              Container(
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xfff7f7f7),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _notaDel,
                        hint: new Text('Nota'),
                        onChanged: (newValue) {
                          setState(() {
                            _notaDel = newValue;
                            if (_selectedTypeDel != null)
                              _hasSelectedDataDel = true;

                            _selectedTypeAdd = null;
                            _notaAdd = null;
                            _hasSelectedDataAdd = false;
                            _selectedTypeMod = null;
                            _notaMod = null;
                            _newNota = null;
                            _hasSelectedDataMod = false;
                          });
                        },
                        items: _getGrades(_selectedTypeDel)
                            .map((type) => DropdownMenuItem(
                                child: Text(type), value: type))
                            .toList()),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (_hasSelectedDataDel &&
                      _selectedTypeDel != null &&
                      _notaDel != null) {
                    int nota = int.parse(_notaDel);

                    switch (_selectedTypeDel) {
                      case 'Práctico':
                        if (widget._subject.getGradesP().length < 6)
                          widget._subject.deleteGradeP(nota);
                        break;

                      case 'Teórico':
                        if (widget._subject.getGradesT().length < 6)
                          widget._subject.deleteGradeT(nota);
                        break;

                      case 'TP':
                        if (widget._subject.getGradesTP().length < 6)
                          widget._subject.deleteGradeTP(nota);
                        break;

                      case 'Final':
                        if (widget._subject.getAplazos().length <= 3) {
                          if (nota > 5)
                            widget._subject.nf(-1);
                          else
                            widget._subject.deleteGradeAp(nota);
                          break;
                        }
                    }

                    changed = true;

                    setState(() {
                      _notaDel = null;
                    });
                  }
                },
                child: Container(
                  width: 38.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.0),
                    color: const Color(0xffFF9A9A),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Text(
            'Modificar Nota',
            style: TextStyle(
              fontFamily: 'Avenir LT Std',
              fontSize: 22,
              color: const Color(0xff484848),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
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
                      value: _selectedTypeMod,
                      hint: new Text('Tipo de Nota'),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedTypeMod = newValue;
                          if (_notaMod != null && _newNota != null)
                            _hasSelectedDataMod = true;

                          _selectedTypeAdd = null;
                          _notaAdd = null;
                          _hasSelectedDataAdd = false;
                          _selectedTypeDel = null;

                          _notaDel = null;
                          _hasSelectedDataDel = false;
                          _newNota = null;
                          _notaMod = null;
                        });
                      },
                      items: _types
                          .map((type) =>
                              DropdownMenuItem(child: Text(type), value: type))
                          .toList()),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            children: [
              Container(
                //width: 288.0,
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xfff7f7f7),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _notaMod,
                        hint: new Text('Nota'),
                        onChanged: (newValue) {
                          setState(() {
                            _notaMod = newValue;
                            if (_selectedTypeMod != null && _newNota != null)
                              _hasSelectedDataMod = true;

                            _selectedTypeAdd = null;
                            _notaAdd = null;
                            _hasSelectedDataAdd = false;
                            _selectedTypeDel = null;
                            _notaDel = null;
                            _hasSelectedDataDel = false;
                          });
                        },
                        items: _getGrades(_selectedTypeMod)
                            .map((type) => DropdownMenuItem(
                                child: Text(type), value: type))
                            .toList()),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset('assets/images/arrow.png'),
              SizedBox(
                width: 10,
              ),
              Container(
                //width: 288.0,
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xfff7f7f7),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _newNota,
                        hint: new Text('Nota'),
                        onChanged: (newValue) {
                          setState(() {
                            _newNota = newValue;
                            if (_selectedTypeMod != null && _notaMod != null)
                              _hasSelectedDataMod = true;

                            _selectedTypeAdd = null;
                            _notaAdd = null;
                            _hasSelectedDataAdd = false;
                            _selectedTypeDel = null;
                            _notaDel = null;
                            _hasSelectedDataDel = false;
                          });
                        },
                        items: _notas
                            .map((type) => DropdownMenuItem(
                                child: Text(type), value: type))
                            .toList()),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  if (_hasSelectedDataMod &&
                      _selectedTypeMod != null &&
                      _notaMod != null &&
                      _newNota != null) {
                    int nota = int.parse(_notaMod);
                    int nuevaNota = int.parse(_newNota);

                    switch (_selectedTypeMod) {
                      case 'Práctico':
                        if (widget._subject.getGradesP().length < 6)
                          widget._subject.modGradeP(nota, nuevaNota);
                        break;

                      case 'Teórico':
                        if (widget._subject.getGradesT().length < 6)
                          widget._subject.modGradeT(nota, nuevaNota);
                        break;

                      case 'TP':
                        if (widget._subject.getGradesTP().length < 6)
                          widget._subject.modGradeTP(nota, nuevaNota);
                        break;

                      case 'Final':
                        if (widget._subject.getAplazos().length <= 3) {
                          widget._subject.modGradAp(nota, nuevaNota);
                          break;
                        }
                    }

                    changed = true;

                    setState(() {
                      _newNota = null;
                      _notaMod = null;
                    });
                  }
                },
                child: Container(
                  width: 38.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.0),
                    color: Colors.yellow,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FlatButton(
          color: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () async {
            done = await _subejctDao.updateSubject(widget._subject, _student);

            if (done) {
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
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Container(
                //width: double.ini,
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: changed ? const Color(0xffa7ffad) : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    //TODO: NO SE PUEDE TOCAR SI NO SE MODIFICO NADA
                    'Guardar Cambios',
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
