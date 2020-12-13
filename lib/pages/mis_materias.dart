import 'package:flutter/material.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/widgets/materia_style.dart';
import 'package:mis_notas/widgets/options_button.dart';
import 'package:mis_notas/widgets/search_bar.dart';

class MisMaterias extends StatefulWidget {
  @override
  _MisMateriasState createState() => _MisMateriasState();
}

class _MisMateriasState extends State<MisMaterias> {
  var _subjectDao = SubjectDao();

  @override
  Widget build(BuildContext context) {
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

            // Filtreos

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OptionButton('Cursando', true),
                  OptionButton('Aprobadas', false),
                  OptionButton('Restantes', false)
                ],
              ),
            ),

            // ListView builder
            FutureBuilder(
                future:
                    _subjectDao.getAllSubjectsByUser(Student('Lorenzo Sala')),
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
                            print(snapshot.data[index].getName());
                            return MateriaCard(snapshot.data[index]);
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
