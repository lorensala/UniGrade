import 'package:flutter/material.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';

import 'package:mis_notas/widgets/notas_style.dart';
import 'package:mis_notas/widgets/options_button.dart';
import 'package:mis_notas/widgets/search_bar.dart';

class MisNotas extends StatefulWidget {
  @override
  _MisNotasState createState() => _MisNotasState();
}

var _subjectDao = new SubjectDao();

class _MisNotasState extends State<MisNotas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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

                  // Mis Notas y boton ayuda
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                    child: Text(
                      'Mis Notas',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 30,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w900,
                        height: 0.9666666666666667,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: SearchBar(null),
                  ),
                  // Filtros
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          //alignment: WrapAlignment.spaceAround,
                          children: <Widget>[
                            OptionButton('Cursando', true),
                            OptionButton('Aprobadas', false),
                            OptionButton('Libre', false),
                            OptionButton('Promoción', false),
                            OptionButton('Ap. Directa', false),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: _subjectDao
                          .getAllSubjectsByUser(Student('Lorenzo Sala')),
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
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Subject sub = snapshot.data[index];
                                    print(sub.getGradesTP());
                                    return NotaCard(
                                        sub.getName(),
                                        sub.getGradesP(),
                                        sub.getGradesT(),
                                        sub.getGradesTP(),
                                        sub.getNf());
                                  },
                                ),
                              );
                        }
                      })
                ],
              )),
        ));
  }
}
