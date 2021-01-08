import 'package:flutter/cupertino.dart';
import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

class StatisticsService extends ChangeNotifier {
  Future<double> getAvgNf(
      Student _student, List<Subject> _list, int _year) async {
    //Promedio de notas finales

    int _total = 0;
    int _count = 0;
    if (_year == -1) {
      _list.forEach((element) {
        if (element.getNf() != -1 && !element.getElect()) {
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
    int _count = 0;

    if (_year == -1) {
      _list.forEach((element) {
        if (element.getNf() != -1) {
          _total += element.getNf();
          element.getAplazos().forEach((aplazo) {
            _total += aplazo;
            _count += 1;
          });
          _count += 1;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getNf() != -1 && element.getYear() == _year) {
          _total += element.getNf();
          element.getAplazos().forEach((aplazo) {
            _total += aplazo;
            _count += 1;
          });
          _count += 1;
        }
      });
    }
    if (_count == 0) return 0;
    return double.parse(((_total / _count)).toStringAsFixed(2));
  }

  Future<int> getSubjectsCount(
      Student _student, List<Subject> _list, int _year) async {
    int count = 0;

    _list.forEach((element) {
      if (element.getYear() == _year) count++;
    });

    return count;
  }

  Future<int> getSubjectsLeft(
      Student _student, List<Subject> _list, int _year) async {
    int _countTotal = 0;
    int _countPassed = 0;

    if (_year != -1) {
      SubjectsDao _subjectDao = new SubjectsDao();
      List<Subject> _listAll = await _subjectDao.getAllSubjectsByUser(_student);
      _countPassed = await getSubjectsCount(_student, _listAll, _year);
    }

    if (_year == -1) {
      _countTotal = _list.length;
    } else {
      _list.forEach((element) {
        if (element.getYear() == _year) _countTotal++;
      });
    }

    if (_year != -1)
      return -(_countTotal - _countPassed);
    else
      return (_countTotal - _countPassed);
  }

  Future<int> getSubjectsPassed(
      Student _student, List<Subject> _list, int _year) async {
    int _count = 0;

    if (_year == -1) {
      _list.forEach((element) {
        if (element.getPassed() && !element.getElect()) {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getPassed() &&
            !element.getElect() &&
            element.getYear() == _year) {
          _count++;
        }
      });
    }
    return _count;
  }

  Future<int> getSubjectsCondition(Student _student, List<Subject> _list,
      int _year, String _condition) async {
    int _count = 0;

    if (_year == -1) {
      _list.forEach((element) {
        if (element.getState().getState().getName() == _condition) {
          _count++;
        }
      });
    } else {
      _list.forEach((element) {
        if (element.getState().getState().getName() == _condition &&
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

  Future<Subject> getBestAvg(Student student, List<Subject> list) async {
    Subject _best = list[0];

    list.forEach((subject) {
      if (subject.getNf() != -1 && subject.getNf() > _best.getNf())
        _best = subject;
    });

    return _best;
  }

  getWorstAvg(Student student, List<Subject> list) {
    Subject _worst;

    for (var i = 0; i < list.length; i++) {
      if (list[i].getNf() != -1) {
        _worst = list[i];
        break;
      }
    }

    list.forEach((subject) {
      if (subject.getNf() != -1 && subject.getNf() < _worst.getNf())
        _worst = subject;
    });

    return _worst;
  }

  List<int> getProfileStats(Student _student, List<Subject> _list) {
    List<int> _res = new List<int>();
    int prog = 0;
    int cal = 0;
    int an = 0;
    int programmer = 0;
    int calculador = 0;
    int analista = 0;

    _list.forEach((sub) {
      if (sub.getNf() != -1 &&
          (sub.getType() == 'software' ||
              sub.getType() == 'hardware' ||
              sub.getType() == 'logica')) {
        prog++;
        programmer += sub.getNf();
      } else if (sub.getNf() != -1 && sub.getType() == 'calculo') {
        cal++;
        calculador += sub.getNf();
      } else if (sub.getNf() != -1 && sub.getType() == 'analista') {
        an++;
        analista += sub.getNf();
      }
    });

    if (prog != 0)
      _res.add(programmer ~/ prog);
    else
      _res.add(0);
    if (cal != 0)
      _res.add(calculador ~/ cal);
    else
      _res.add(0);
    if (an != 0)
      _res.add(analista ~/ an);
    else
      _res.add(0);
    return _res;
  }
}
