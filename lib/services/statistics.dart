import 'package:flutter/cupertino.dart';
import 'package:mis_notas/entities/student.dart';

class StatisticsService extends ChangeNotifier {
  Future<double> getAvgNf(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    //Promedio de notas finales

    int _total = 0;
    int _count = _list.length;
    if (_year == -1) {
      _list.forEach((element) {
        if (element['nf'] != -1 && element['nf'] > 5) _total += element['nf'];
      });
    } else {
      _list.forEach((element) {
        if (element['nf'] != -1 &&
            element['nf'] > 5 &&
            element['year'] == _year) _total += element['nf'];
      });
    }

    return _total / _count;
  }

  Future<double> getAvgNfWithBadGrades(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    //Promedio de notas finales

    int _total = 0;
    int _count = _list.length;

    if (_year == -1) {
      _list.forEach((element) {
        if (element['nf'] != -1) _total += element['nf'];
      });
    } else {
      _list.forEach((element) {
        if (element['nf'] != -1 && element['year'] == _year)
          _total += element['nf'];
      });
    }

    return _total / _count;
  }

  Future<int> getSubjectsLeft(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    // TODO: Hardcodeado el 40.

    int _count = await getSubjectsPassed(_student, _list, _year);

    return 40 - _count;
  }

  Future<int> getSubjectsPassed(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.
    if (_year == -1) {
      _list.forEach((element) {
        if ((element['state'] != 'cursando') && (element['state'] != '')) {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if ((element['state'] != 'cursando') &&
            (element['state'] != '') &&
            element['year'] == _year) {
          _count++;
        }
      });
    }
    return _count;
  }

  Future<int> getSubjectsPromoP(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.
    if (_year == -1) {
      _list.forEach((element) {
        if (element['state'] == 'pp') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element['state'] == 'pp' && element['year'] == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  Future<int> getSubjectsPromoT(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.

    if (_year == -1) {
      _list.forEach((element) {
        if (element['state'] == 'pt') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element['state'] == 'pt' && element['year'] == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  Future<int> getSubjectsApDir(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.

    if (_year == -1) {
      _list.forEach((element) {
        if (element['state'] == 'ad') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element['state'] == 'ad' && element['year'] == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  // Not in use
  Future<double> getAvgAllGrades(
      Student _student, List<Map<String, dynamic>> _list, int _year) async {
    //Promedio de notas parciales

    int _total = 0;
    int _countSubjects = _list.length;
    int _countGrades = 0;
    double avg = 0;

    _list.forEach((element) {
      for (int grade in element['gradesP']) {
        _total += grade;
        _countGrades++;
      }
      for (int grade in element['gradesT']) {
        _total += grade;
        _countGrades++;
      }
      for (int grade in element['gradesTP']) {
        _total += grade;
        _countGrades++;
      }

      avg += _total / _countGrades;
      _total = 0;
      _countGrades = 0;
    });

    return avg / _countSubjects;
  }
}
