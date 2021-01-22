import 'package:flutter/material.dart';
import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/pages/pages/mismaterias/materias_info_page.dart';

class SubjectCard extends StatelessWidget {
  final Subject _subject;

  SubjectCard(this._subject);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
      child: InkWell(
        onTap: () async {
          SubjectsDao _subjectsDao = new SubjectsDao();

          Map _map = await _subjectsDao.getCorrelativas(_subject);

          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.easeInOut);
                    return SlideTransition(
                      position:
                          Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                              .animate(animation),
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return MisMateriasInfo(_subject, _map);
                  }));
        },
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.fromLTRB(21, 15, 0, 15),
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: _subject.getColor(),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _subject.getName(),
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 25,
                          color: const Color(0xffffffff),
                          height: 1.04,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            Align(
              alignment: Alignment(0.80, 0.00),
              child: Card(
                color: Colors.transparent,
                elevation: 16,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(_subject.getIcon()),
                  radius: 45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
