import 'package:flutter/cupertino.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

class StatisticsService extends ChangeNotifier {
  //TODO: El promedio debe calcularse en base a las que tienennota final

  Future<double> getAvgNf(
      Student _student, List<Subject> _list, int _year) async {
    //Promedio de notas finales

    int _total = 0;
    int _count = 0;
    if (_year == -1) {
      _list.forEach((element) {
        if (element.getNf() != -1 && element.getNf() > 5) {
          _total += element.getNf();
          _count += 1;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getNf() != -1 &&
            //element.getNf() > 5 &&
            element.getYear() == _year) {
          _total += element.getNf();
          _count += 1;
        }
      });
    }
    if (_count == 0) return 0;
    return double.parse(((_total / _count)).toStringAsFixed(2));
  }

  Future<double> getAvgNfWithBadGrades(
      Student _student, List<Subject> _list, int _year) async {
    //Promedio de notas finales

    int _total = 0;
    int _count = _list.length;

    if (_year == -1) {
      _list.forEach((element) {
        if (element.getNf() != -1) _total += element.getNf();
      });
    } else {
      _list.forEach((element) {
        if (element.getNf() != -1 && element.getYear() == _year)
          _total += element.getNf();
      });
    }

    return _total / _count;
  }

  Future<int> getSubjectsLeft(
      Student _student, List<Subject> _list, int _year) async {
    // TODO: Hardcodeado el 40.

    int _countTotal = 0;
    int _countPassed = await getSubjectsPassed(_student, _list, _year);

    // TODO: Revisar condiciones de estado.
    if (_year == -1) {
      _countTotal = _list.length;
    } else {
      _list.forEach((element) {
        if (element.getYear() == _year) _countTotal++;
      });
    }

    return _countTotal - _countPassed;
  }

  Future<int> getSubjectsPassed(
      Student _student, List<Subject> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.
    if (_year == -1) {
      _list.forEach((element) {
        if ((element.getState().getState().getName() != 'Cursando') &&
            (element.getState().getState().getName() != '') &&
            (element.getState().getState().getName() != 'Abandonada')) {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if ((element.getState().getState().getName() != 'Cursando') &&
            (element.getState().getState().getName() != '') &&
            element.getYear() == _year) {
          _count++;
        }
      });
    }
    return _count;
  }

  Future<int> getSubjectsRegulares(
      Student _student, List<Subject> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.
    if (_year == -1) {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Regular') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Regular' &&
            element.getYear() == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  Future<int> getSubjectsPromoP(
      Student _student, List<Subject> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.
    if (_year == -1) {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Promoción Práctica') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Promoción Práctica' &&
            element.getYear() == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  Future<int> getSubjectsPromoT(
      Student _student, List<Subject> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.

    if (_year == -1) {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Promoción Teórica') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Promoción Teórica' &&
            element.getYear() == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  Future<int> getSubjectsApDir(
      Student _student, List<Subject> _list, int _year) async {
    int _count = 0;

    // TODO: Revisar condiciones de estado.

    if (_year == -1) {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Aprobación Directa') {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getState().getState().getName() == 'Aprobación Directa' &&
            element.getYear() == _year) {
          _count++;
        }
      });
    }

    return _count;
  }

  // Not in use
  Future<double> getAvgAllGrades(
      Student _student, List<Subject> _list, int _year) async {
    //Promedio de notas parciales

    int _total = 0;
    int _countSubjects = _list.length;
    int _countGrades = 0;
    double avg = 0;

    _list.forEach((element) {
      for (int grade in element.getGradesP()) {
        _total += grade;
        _countGrades++;
      }
      for (int grade in element.getGradesT()) {
        _total += grade;
        _countGrades++;
      }
      for (int grade in element.getGradesTP()) {
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