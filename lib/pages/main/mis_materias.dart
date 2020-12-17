import 'package:flutter/material.dart';
import 'package:mis_notas/data/subject_dao.dart';

import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';

import 'package:mis_notas/widgets/styles/subject_card_style.dart';
import 'package:mis_notas/widgets/buttons/options_button.dart';
import 'package:mis_notas/widgets/components/search_bar.dart';
import 'package:provider/provider.dart';

class MisMaterias extends StatefulWidget {
  @override
  _MisMateriasState createState() => _MisMateriasState();
}

class _MisMateriasState extends State<MisMaterias> {
  String condition = 'All';
  bool isPressedAll = true;
  bool isPressedCursando = false;
  bool isPressedAprobadas = false;
  bool isPressedLibre = false;
  bool isPressedPP = false;
  bool isPressedPT = false;
  bool isPressedAD = false;

  Future<List<Subject>> getData(Student _student, String condition) async {
    var _subjectDao = new SubjectDao();

    switch (condition) {
      case 'All':
        return await _subjectDao.getAllSubjectsByUser(_student);
      case 'Cursando':
        return await _subjectDao.getAllSubjectsByUserCondition(
            _student, condition);
      case 'Aprobadas':
        return await _subjectDao.getAllSubjectsByUserCondition(
            _student, condition);
      case 'Libre':
        return await _subjectDao.getAllSubjectsByUserCondition(
            _student, condition);
      case 'Promoción Práctica':
        return await _subjectDao.getAllSubjectsByUserCondition(
            _student, condition);
      case 'Promoción Teórica':
        return await _subjectDao.getAllSubjectsByUserCondition(
            _student, condition);
      case 'Aprobación Directa':
        return await _subjectDao.getAllSubjectsByUserCondition(
            _student, condition);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _student = Provider.of<Student>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          // back arrow
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // back arrow
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
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
              padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
              child: Text(
                'Mis Materias',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 30,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                  height: 0.9666666666666667,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: SearchBar(null),
            ),

            // Filtreos

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.end,
                //alignment: WrapAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.circular(26),
                    child: OptionButton('Todas', isPressedAll),
                    onTap: () {
                      setState(() {
                        isPressedAll = true;
                        isPressedCursando = false;
                        isPressedAprobadas = false;
                        isPressedLibre = false;
                        isPressedPP = false;
                        isPressedPT = false;
                        isPressedAD = false;
                        condition = 'All';
                      });
                    },
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(26),
                      child: OptionButton('Cursando', isPressedCursando),
                      onTap: () {
                        setState(() {
                          isPressedAll = false;
                          isPressedCursando = true;
                          isPressedAprobadas = false;
                          isPressedLibre = false;
                          isPressedPP = false;
                          isPressedPT = false;
                          isPressedAD = false;
                          condition = 'Cursando';
                        });
                      }),
                  InkWell(
                      borderRadius: BorderRadius.circular(26),
                      child: OptionButton('Aprobadas', isPressedAprobadas),
                      onTap: () {
                        setState(() {
                          isPressedAll = false;
                          isPressedCursando = false;
                          isPressedAprobadas = true;
                          isPressedLibre = false;
                          isPressedPP = false;
                          isPressedPT = false;
                          isPressedAD = false;
                          condition = 'Aprobadas';
                        });
                      }),
                  InkWell(
                      borderRadius: BorderRadius.circular(26),
                      child: OptionButton('Libre', isPressedLibre),
                      onTap: () {
                        setState(() {
                          isPressedAll = false;
                          isPressedCursando = false;
                          isPressedAprobadas = false;
                          isPressedLibre = true;
                          isPressedPP = false;
                          isPressedPT = false;
                          isPressedAD = false;
                          condition = 'Aprobadas';
                        });
                      }),
                  InkWell(
                      borderRadius: BorderRadius.circular(26),
                      child: OptionButton('Prom. Prác.', isPressedPP),
                      onTap: () {
                        setState(() {
                          isPressedAll = false;
                          isPressedCursando = false;
                          isPressedAprobadas = false;
                          isPressedLibre = false;
                          isPressedPP = true;
                          isPressedPT = false;
                          isPressedAD = false;
                          condition = 'Promoción Práctica';
                        });
                      }),
                  InkWell(
                      borderRadius: BorderRadius.circular(26),
                      child: OptionButton('Prom. Teó.', isPressedPT),
                      onTap: () {
                        setState(() {
                          isPressedAll = false;
                          isPressedCursando = false;
                          isPressedAprobadas = false;
                          isPressedLibre = false;
                          isPressedPP = false;
                          isPressedPT = true;
                          isPressedAD = false;
                          condition = 'Promoción Teórica';
                        });
                      }),
                  InkWell(
                      borderRadius: BorderRadius.circular(26),
                      child: OptionButton('Ap. Directa', isPressedAD),
                      onTap: () {
                        setState(() {
                          isPressedAll = false;
                          isPressedCursando = false;
                          isPressedAprobadas = false;
                          isPressedLibre = false;
                          isPressedPP = false;
                          isPressedPT = false;
                          isPressedAD = true;
                          condition = 'Aprobación Directa';
                        });
                      }),
                ],
              ),
            ),

            // ListView builder
            FutureBuilder(
                future: getData(_student, condition),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError)
                        return Text('error');
                      else
                        return Expanded(
                            child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return SubjectCard(snapshot.data[index]);
                          },
                          physics: BouncingScrollPhysics(),
                        ));
                  }
                })
          ],
        ),
      )),
    );
  }
}
