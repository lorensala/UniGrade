import 'package:flutter/material.dart';
import 'package:mis_notas/data/subject_dao.dart';

import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/pages/dialogs/dialog_subject_info.dart';

class SubjectCard extends StatelessWidget {
  final Subject _subject;
  final SubjectsDao _subjectDao = new SubjectsDao();

  SubjectCard(this._subject);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
      child: InkWell(
        onTap: () {
          showSubjectInfo(context, _subject);
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
                  radius: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSubjectInfo(BuildContext context, Subject subject) {
    print('tocuh');
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: _subjectDao.getCorrelativas(subject),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                default:
                  if (snapshot.hasData && snapshot.data != null)
                    return DialogSubjectInfo(snapshot.data);
                  else
                    return Text('No data');
              }
            });
      },
    );
  }
}
