import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/statistics.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/pages/dialogs/dialog_actualizar_materia.dart';
import 'package:mis_notas/pages/dialogs/dialog_modificar_nota.dart';
import 'package:mis_notas/pages/dialogs/dialog_nueva_materia.dart';
import 'package:mis_notas/pages/dialogs/dialog_nueva_nota.dart';

import 'package:mis_notas/services/statistics_service.dart';

import 'package:mis_notas/widgets/buttons/main_button.dart';
import 'package:mis_notas/widgets/buttons/quick_buttons.dart';
import 'package:mis_notas/widgets/components/quick_bar.dart';

import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List> getDataStatistics(Student _student) async {
    List _dataList = new List();
    StatisticsService _statisticsService = new StatisticsService();
    SubjectDao _subjectDao = SubjectDao();
    List<Subject> _list = await _subjectDao.getAllSubjectsByUser(_student);
    List<Subject> _listCon =
        await _subjectDao.getAllSubjectsWithCondition(_student);

    _dataList.add(await _statisticsService.getAvgNf(_student, _list, -1));
    _dataList
        .add(await _statisticsService.getSubjectsLeft(_student, _list, -1));
    _dataList
        .add(await _statisticsService.getSubjectsPassed(_student, _list, -1));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Promoción Práctica'));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Promoción Teórica'));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Aprobación Directa'));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Regular'));
    _dataList.add(
        await _statisticsService.getAvgNfWithBadGrades(_student, _list, -1));
    _dataList.add(_statisticsService.getProfileStats(_student, _listCon));

    return _dataList;
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);

    Statistics _statistics = Provider.of<Statistics>(context, listen: false);

    return Stack(
      children: <Widget>[
        FutureBuilder(
            future: getDataStatistics(_student),
            builder: (context, AsyncSnapshot<List> snapshot) {
              switch (snapshot.connectionState) {
                case (ConnectionState.waiting):
                  return Center(child: Container(color: Colors.transparent));
                default:
                  if (snapshot.hasError) return Text('error');

                  _statistics.avg = snapshot.data[0];
                  _statistics.left = snapshot.data[1];
                  _statistics.passed = snapshot.data[2];
                  _statistics.pp = snapshot.data[3];
                  _statistics.pt = snapshot.data[4];
                  _statistics.ap = snapshot.data[5];
                  _statistics.reg = snapshot.data[6];
                  _statistics.realAvg = snapshot.data[7];
                  _statistics.prof = snapshot.data[8];

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                formatText(_student.getFullname()),
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 30,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                width: 120.0,
                                height: 118.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(_student.getProfilePic()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/line.png',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Name, avatar, university text and carreer.
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _student
                                    .getUniversity()
                                    .getCareers()[0]
                                    .getName(),
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 18,
                                  color: Color(0xff484848),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                _student.getUniversity().getShortName(),
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 14,
                                  color: const Color(0xff9a9a9a),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Consumer<Statistics>(
                          builder: (_, statistics, ___) => QuickBar(
                            prom: statistics.getAvg(),
                            aprobadas: statistics.getPassed(),
                            restantes: statistics.getLeft(),
                          ),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Text(
                            'Información',
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 22,
                              color: const Color(0xff484848),
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // Listview
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                          child: Container(
                            height: 130,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                MainButton(
                                    'Mis\nMaterias',
                                    'assets/images/materias.png',
                                    Color(0xFFF7F7F7),
                                    '/mismaterias'),
                                MainButton(
                                    'Mis\nNotas',
                                    'assets/images/notas.png',
                                    Color(0xFFFFDCDC),
                                    '/misnotas'),
                                MainButton(
                                    'Mis\nEstadísticas',
                                    'assets/images/estadisticas.png',
                                    Color(0xFFF5DCFF),
                                    '/estadisticas')
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Text(
                            'Funciones Rápidas',
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 22,
                              color: const Color(0xff484848),
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // Funciones rapidas
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                          child: Wrap(
                              spacing: 20,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              direction: Axis.horizontal,
                              children: [
                                InkWell(
                                    borderRadius: BorderRadius.circular(26),
                                    onTap: () {
                                      //student.addPromedio();
                                      showNuevaNota(context, _student);
                                    },
                                    child: QuickButton(
                                        'Nueva Nota', Color(0xFFF5F5F5))),
                                InkWell(
                                  borderRadius: BorderRadius.circular(26),
                                  onTap: () {
                                    showActualizarMateria(context, _student);
                                  },
                                  child: QuickButton(
                                      'Actualizar Materia', Color(0xFFFFDCDC)),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(26),
                                  onTap: () {
                                    showNuevaMateria(context, _student);
                                  },
                                  child: QuickButton(
                                      'Nueva Materia', Color(0xFFF5DCFF)),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(26),
                                  onTap: () {
                                    showModificarNota(context, _student);
                                  },
                                  child: QuickButton(
                                      'Modificar Nota', Color(0xFFCAFFC6)),
                                )
                              ]),
                        )
                      ],
                    ),
                  );
              }
            }),
      ],
    );
  }

  void showNuevaNota(BuildContext context, Student _student) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogNuevaNota(_student);
        });
  }

  void showActualizarMateria(BuildContext _context, Student _student) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return DialogActualizarMateria(_student);
      },
    );
  }

  void showNuevaMateria(BuildContext _context, Student _student) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return DialogNuevaMateria(_student);
      },
    );
  }

  void showModificarNota(BuildContext _context, Student _student) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return DialogModificarNota(_student);
      },
    );
  }

  String formatText(String fullname) {
    List<String> _aux = fullname.split(' ');

    return _aux[0] + '\n' + _aux[1];
  }
}
