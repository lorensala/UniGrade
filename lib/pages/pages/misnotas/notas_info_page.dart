import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/state.dart';
import 'package:mis_notas/entities/state_record.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/pages/dialogs/dialog_actualizar_materia.dart';
import 'package:mis_notas/pages/main/home.dart';

import 'package:mis_notas/pages/pages/misnotas/mis_notas.dart';

import 'package:mis_notas/widgets/styles/grade_card_style.dart';
import 'package:provider/provider.dart';

class MisNotasInfo extends StatefulWidget {
  Subject _subject;
  MisNotasInfo(this._subject);

  @override
  _MisNotasInfoState createState() => _MisNotasInfoState();
}

class _MisNotasInfoState extends State<MisNotasInfo> {
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
  SubjectsDao _subjectDao = new SubjectsDao();
  bool updated = false;
  bool firstTime = true;
  bool changed = false;
  var _selectedCondition;

  bool recursar = false;

  Subject _original;

  var _types = ['Práctico', 'Teórico', 'TP', 'Final'];
  var _notas = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _condicion = [
    'Ninguna',
    'Regular',
    'Aprobación Directa',
    'Promoción Teórica',
    'Promoción Práctica',
    'Abandonada',
    'Libre',
  ];

  List<String> _getGrades(String _type, Subject _subject) {
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
  void initState() {
    if (widget._subject.getState().getState().getName() != '')
      _selectedCondition = widget._subject.getState().getState().getName();
    if (_selectedCondition == 'Libre') {
      recursar = true;
      changed = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        _original = await _subjectDao.getSubject(widget._subject, _student);

        if (!changed) {
          exit(_student);
        } else {
          CoolAlert.show(
              context: context,
              backgroundColor: Colors.white,
              type: CoolAlertType.confirm,
              onConfirmBtnTap: () async {
                await _subjectDao
                    .getSubject(widget._subject, _student)
                    .then((s) {
                  _original = Subject.fromOther(s);
                });

                Subject aux = _student.getSubjects().firstWhere(
                    (s) => s.getName() == widget._subject.getName());

                aux.gradesTP = _original.getGradesTP();
                aux.gradesP = _original.getGradesP();

                aux.gradesT = _original.getGradesT();

                aux.aplazos = _original.getAplazos();

                aux.notaFinal = _original.getNf();

                exit(_student);
              });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 0, 0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {
                          _original = await _subjectDao.getSubject(
                              widget._subject, _student);

                          if (!changed) {
                            exit(_student);
                          } else {
                            CoolAlert.show(
                                context: context,
                                backgroundColor: Colors.white,
                                type: CoolAlertType.confirm,
                                onConfirmBtnTap: () async {
                                  await _subjectDao
                                      .getSubject(widget._subject, _student)
                                      .then((s) {
                                    _original = Subject.fromOther(s);
                                  });

                                  Subject aux = _student
                                      .getSubjects()
                                      .firstWhere((s) =>
                                          s.getName() ==
                                          widget._subject.getName());

                                  aux.gradesTP = _original.getGradesTP();
                                  aux.gradesP = _original.getGradesP();

                                  aux.gradesT = _original.getGradesT();

                                  aux.aplazos = _original.getAplazos();

                                  aux.notaFinal = _original.getNf();

                                  exit(_student);
                                  ;
                                });
                          }
                        },
                        icon: Image.asset(
                          'assets/images/3.0x/backarrow.png',
                          scale: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Mis Notas',
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 30,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w800,
                          height: 0.9666666666666667,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SvgPicture.string(
                        '<svg viewBox="323.0 109.0 28.0 28.0" ><path transform="translate(322.44, 108.44)" d="M 28.56250381469727 14.56250095367432 C 28.56250381469727 22.29620552062988 22.2939453125 28.56250381469727 14.56250095367432 28.56250381469727 C 6.831056594848633 28.56250381469727 0.5625000596046448 22.29620170593262 0.5625000596046448 14.56250095367432 C 0.5625000596046448 6.833314418792725 6.831056594848633 0.5625000596046448 14.56250095367432 0.5625000596046448 C 22.2939453125 0.5625000596046448 28.56250381469727 6.833314895629883 28.56250381469727 14.56250095367432 Z M 14.93818664550781 5.191532611846924 C 11.86174297332764 5.191532611846924 9.899598121643066 6.487492561340332 8.358806610107422 8.790775299072266 C 8.159193992614746 9.089178085327148 8.22597599029541 9.491621971130371 8.512073516845703 9.708564758300781 L 10.47088718414307 11.19380760192871 C 10.76471900939941 11.41662120819092 11.18336391448975 11.36361408233643 11.41165351867676 11.07401657104492 C 12.42010498046875 9.794936180114746 13.11158180236816 9.053218841552734 14.64650058746338 9.053218841552734 C 15.7997522354126 9.053218841552734 17.22622680664063 9.795444488525391 17.22622680664063 10.91375064849854 C 17.22622680664063 11.75917053222656 16.5283145904541 12.19334030151367 15.38963031768799 12.83175086975098 C 14.06166172027588 13.5761775970459 12.30443572998047 14.50271892547607 12.30443572998047 16.82056617736816 L 12.30443572998047 17.04637145996094 C 12.30443572998047 17.42047691345215 12.60775089263916 17.72379112243652 12.98185539245605 17.72379112243652 L 16.14314651489258 17.72379112243652 C 16.51725006103516 17.72379112243652 16.82056617736816 17.42047691345215 16.82056617736816 17.04637145996094 L 16.82056617736816 16.97112274169922 C 16.82056617736816 15.36439514160156 21.51655006408691 15.29750061035156 21.51655006408691 10.94959735870361 C 21.51655006408691 7.675290107727051 18.12013626098633 5.191532611846924 14.93818664550781 5.191532611846924 Z M 14.56250095367432 19.19153213500977 C 13.13060569763184 19.19153213500977 11.96572685241699 20.35641479492188 11.96572685241699 21.78830909729004 C 11.96572685241699 23.22014617919922 13.13060569763184 24.38508224487305 14.56250095367432 24.38508224487305 C 15.9943962097168 24.38508224487305 17.15927505493164 23.22014617919922 17.15927505493164 21.78830909729004 C 17.15927505493164 20.35641479492188 15.9943962097168 19.19153213500977 14.56250095367432 19.19153213500977 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
                  child: SvgPicture.string(
                    '<svg viewBox="24.0 151.5 255.5 1.0" ><path transform="translate(24.0, 151.5)" d="M 0 0 L 255.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
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
                                      if (_notaAdd != null)
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
                                  items: _types
                                      .map((type) => DropdownMenuItem(
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
                            onTap: !recursar
                                ? () async {
                                    if (_hasSelectedDataAdd &&
                                        _selectedTypeAdd != null &&
                                        _notaAdd != null) {
                                      int nota = int.parse(_notaAdd);

                                      if (isEmpty(widget._subject) &&
                                          (_selectedTypeAdd != 'Final' &&
                                              _notaAdd < 6)) {
                                        widget._subject.state = StateRecord(
                                            StateSubject('Regular'),
                                            DateTime.now());
                                      }

                                      switch (_selectedTypeAdd) {
                                        case 'Práctico':
                                          if (widget._subject
                                                  .getGradesP()
                                                  .length <
                                              5)
                                            widget._subject.addgradeP(nota);
                                          break;

                                        case 'Teórico':
                                          if (widget._subject
                                                  .getGradesT()
                                                  .length <
                                              5)
                                            widget._subject.addgradeT(nota);
                                          break;

                                        case 'TP':
                                          if (widget._subject
                                                  .getGradesTP()
                                                  .length <
                                              5)
                                            widget._subject.addgradeTP(nota);

                                          break;

                                        case 'Final':
                                          if (widget._subject
                                                  .getAplazos()
                                                  .length <=
                                              3) {
                                            if (nota > 5) {
                                              await showActualizarMateria(
                                                  context, widget._subject);
                                              widget._subject.nf(nota);
                                              widget._subject.state =
                                                  StateRecord(
                                                      StateSubject('Aprobada'),
                                                      DateTime.now());

                                              setState(() {});
                                            } else
                                              widget._subject.addgradeAp(nota);
                                            if (widget._subject
                                                    .getAplazos()
                                                    .length ==
                                                4)
                                              widget._subject.state =
                                                  StateRecord(
                                                      StateSubject('Libre'),
                                                      DateTime.now());

                                            break;
                                          }
                                      }

                                      changed = true;

                                      setState(() {});
                                    }
                                  }
                                : null,
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
                                      if (_notaDel != null)
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
                                    items: _getGrades(
                                            _selectedTypeDel, widget._subject)
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
                            onTap: !recursar
                                ? () {
                                    if (_hasSelectedDataDel &&
                                        _selectedTypeDel != null &&
                                        _notaDel != null) {
                                      int nota = int.parse(_notaDel);

                                      switch (_selectedTypeDel) {
                                        case 'Práctico':
                                          if (widget._subject
                                                  .getGradesP()
                                                  .length <
                                              6)
                                            widget._subject.deleteGradeP(nota);
                                          break;

                                        case 'Teórico':
                                          if (widget._subject
                                                  .getGradesT()
                                                  .length <
                                              6)
                                            widget._subject.deleteGradeT(nota);
                                          break;

                                        case 'TP':
                                          if (widget._subject
                                                  .getGradesTP()
                                                  .length <
                                              6)
                                            widget._subject.deleteGradeTP(nota);
                                          break;

                                        case 'Final':
                                          if (nota > 5) {
                                            widget._subject.nf(-1);
                                            widget._subject.state = StateRecord(
                                                StateSubject(''),
                                                DateTime.now());
                                          } else
                                            widget._subject.deleteGradeAp(nota);
                                          if (widget._subject
                                                  .getAplazos()
                                                  .length <
                                              4)
                                            widget._subject.state = StateRecord(
                                                StateSubject(''),
                                                DateTime.now());
                                          break;
                                      }

                                      changed = true;

                                      setState(() {
                                        _notaDel = null;
                                      });
                                    }
                                  }
                                : null,
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
                                      .map((type) => DropdownMenuItem(
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
                                        if (_selectedTypeMod != null &&
                                            _newNota != null)
                                          _hasSelectedDataMod = true;

                                        _selectedTypeAdd = null;
                                        _notaAdd = null;
                                        _hasSelectedDataAdd = false;
                                        _selectedTypeDel = null;
                                        _notaDel = null;
                                        _hasSelectedDataDel = false;
                                      });
                                    },
                                    items: _getGrades(
                                            _selectedTypeMod, widget._subject)
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
                                        if (_selectedTypeMod != null &&
                                            _notaMod != null)
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
                            onTap: !recursar
                                ? () {
                                    if (_hasSelectedDataMod &&
                                        _selectedTypeMod != null &&
                                        _notaMod != null &&
                                        _newNota != null) {
                                      int nota = int.parse(_notaMod);
                                      int nuevaNota = int.parse(_newNota);

                                      switch (_selectedTypeMod) {
                                        case 'Práctico':
                                          if (widget._subject
                                                  .getGradesP()
                                                  .length <
                                              6)
                                            widget._subject
                                                .modGradeP(nota, nuevaNota);
                                          break;

                                        case 'Teórico':
                                          if (widget._subject
                                                  .getGradesT()
                                                  .length <
                                              6)
                                            widget._subject
                                                .modGradeT(nota, nuevaNota);
                                          break;

                                        case 'TP':
                                          if (widget._subject
                                                  .getGradesTP()
                                                  .length <
                                              6)
                                            widget._subject
                                                .modGradeTP(nota, nuevaNota);
                                          break;

                                        case 'Final':
                                          if (widget._subject
                                                  .getAplazos()
                                                  .length <=
                                              3) {
                                            widget._subject
                                                .modGradAp(nota, nuevaNota);
                                            break;
                                          }
                                      }

                                      changed = true;

                                      setState(() {
                                        _newNota = null;
                                        _notaMod = null;
                                      });
                                    }
                                  }
                                : null,
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Text(
                        'Seleccionar Condición ',
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
                                  value: _selectedCondition,
                                  hint: new Text('Condicion'),
                                  onChanged: (newValue) {
                                    setState(() {
                                      if (newValue != 'Ninguna') {
                                        _selectedCondition = newValue;
                                        widget._subject.state = StateRecord(
                                            StateSubject(_selectedCondition),
                                            DateTime.now());
                                      } else {
                                        _selectedCondition = null;
                                        widget._subject.state = StateRecord(
                                            StateSubject(''), DateTime.now());
                                      }

                                      changed = true;
                                    });
                                  },
                                  items: (recursar ||
                                          widget._subject.getNf() != -1)
                                      ? null
                                      : _condicion
                                          .map((type) => DropdownMenuItem(
                                              child: Text(type), value: type))
                                          .toList()),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    !recursar
                        ? FlatButton(
                            color: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              updated = await _subjectDao.updateSubject(
                                  Subject.fromOther(widget._subject), _student);

                              if (updated) {
                                await CoolAlert.show(
                                    borderRadius: 26,
                                    title: 'Éxito',
                                    backgroundColor: Colors.white,
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: '¡Materia actualizada con exito!');

                                exit(_student);
                              } else {
                                CoolAlert.show(
                                    borderRadius: 26,
                                    title: 'Error',
                                    backgroundColor: Colors.white,
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: 'Error al actualizar la materia');
                              }
                              changed = false;
                            },
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                child: Container(
                                  //width: double.ini,
                                  height: 37.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26.0),
                                    color: changed
                                        ? const Color(0xffa7ffad)
                                        : Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text(
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
                        : FlatButton(
                            color: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              updated = await _subjectDao.recursarSubject(
                                  Subject.fromOther(widget._subject), _student);

                              if (updated) {
                                await CoolAlert.show(
                                    borderRadius: 26,
                                    title: 'Éxito',
                                    backgroundColor: Colors.white,
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: '¡Materia actualizada con exito!');

                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 250),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          animation = CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.easeInOut);
                                          return SlideTransition(
                                            position: Tween(
                                                    begin: Offset(1.0, 0.0),
                                                    end: Offset(0.0, 0.0))
                                                .animate(animation),
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return HomePage();
                                        }));
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
                                padding:
                                    const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                child: Container(
                                  //width: double.ini,
                                  height: 37.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26.0),
                                    color: changed
                                        ? const Color(0xffFF9A9A)
                                        : Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Recursar Materia',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isEmpty(Subject subject) {
    if (subject.getGradesP().isEmpty &&
        subject.getGradesTP().isEmpty &&
        subject.getGradesT().isEmpty &&
        subject.getAplazos().isEmpty &&
        subject.getNf() == -1)
      return true;
    else
      return false;
  }

  Future<void> showActualizarMateria(BuildContext _context, Subject _subject) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return DialogActualizarMateria(_subject);
      },
    );
  }

  int getIndex(Subject subject, Student _student) {
    List<Subject> _list = _student.getSubjects();

    try {
      _list.sort((a, b) => a.getYear().compareTo(b.getYear()));

      return _list.indexWhere((s) => s.getName() == subject.getName());
    } catch (e) {
      return 0;
    }
  }

  void exit(Student _student) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              return MisNotas(getIndex(_original, _student));
            }));
  }
}
