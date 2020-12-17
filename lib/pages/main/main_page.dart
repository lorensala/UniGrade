import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mis_notas/data/statistics_dao.dart';
import 'package:mis_notas/entities/statistics.dart';
import 'package:mis_notas/entities/student.dart';

import 'package:mis_notas/pages/dialogs/dialog_nuevamateria.dart';
import 'package:mis_notas/pages/dialogs/dialog_nuevanota.dart';

import 'package:mis_notas/services/statistics_service.dart';
import 'package:mis_notas/support/text_formatter.dart';

import 'package:mis_notas/widgets/buttons/main_button.dart';
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
    StatisticsDao _statisticsDao = new StatisticsDao();
    List<Map<String, dynamic>> _list = await _statisticsDao.getData(_student);

    _dataList.add(await _statisticsService.getAvgNf(_student, _list, -1));
    _dataList
        .add(await _statisticsService.getSubjectsLeft(_student, _list, -1));
    _dataList
        .add(await _statisticsService.getSubjectsPassed(_student, _list, -1));

    return _dataList;
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);
    Statistics _statistics = Provider.of<Statistics>(context, listen: false);

    return FutureBuilder(
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
                                image: NetworkImage(_student.getProfilePic()),
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
                            _student.getUniversity().getCareers()[0].getName(),
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
                                'assets/images/005-books.png',
                                Color(0xFFF7F7F7),
                                '/mismaterias'),
                            MainButton(
                                'Mis\nNotas',
                                'assets/images/001-test.png',
                                Color(0xFFFFDCDC),
                                '/misnotas'),
                            MainButton(
                                'Mis\nEstadísticas',
                                'assets/images/030-cup.png',
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
                      child: Row(children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: () {
                            //student.addPromedio();
                            showNuevaNota(context, _student);
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Nueva Nota',
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 14,
                                  color: const Color(0xff7c7979),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            width: 129.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26.0),
                              color: const Color(0xfff0f0f0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: () {
                            showNuevaMateria(context, _student);
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Nueva Materia',
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 14,
                                  color: const Color(0xff7c7979),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            width: 129.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26.0),
                              color: const Color(0xffffdcdc),
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              );
          }
        });
  }

  void showNuevaNota(BuildContext context, Student _student) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogNuevaNota(_student);
        });
  }

  void showNuevaMateria(BuildContext _context, Student _student) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return DialogNuevaMateria(_student, _context);
      },
    );
  }
}
