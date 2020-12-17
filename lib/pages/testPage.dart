import 'package:flutter/material.dart';
import 'package:mis_notas/data/statistics_dao.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/services/statistics_service.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  final StatisticsService _statisticsService = new StatisticsService();
  final StatisticsDao _statisticsDao = new StatisticsDao();
  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);
    return Scaffold(
      body: FlatButton(
          onPressed: () async {
            //List<Map<String, dynamic>> _list = await _statisticsDao.getData(_student);

            //await _statisticsDao.getStudentSDocRef(_student.getId());
          },
          child: Container(
            color: Colors.black,
          )),
    );
  }
}
