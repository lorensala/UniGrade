import 'package:flutter/material.dart';
import 'package:mis_notas/entities/state_record.dart';

class Subject {
  String _name;
  int _year;
  List<int> _gradesP;
  List<int> _gradesT;
  List<int> _gradesTP;
  List<int> _aplazos;
  int _nf = -1;
  StateRecord _state;
  String _type;
  String _icon;
  bool _passed; //TODO: Sacar esto!!
  String _duration;
  bool _elect;
  int _points; //TODO: Esto

  //TODO: List<Subjects> _correlativas;

  Map<String, dynamic> toMap() {
    return {
      'duration': _duration,
      'gradesP': _gradesP,
      'gradesT': _gradesT,
      'gradesTP': _gradesTP,
      'nf': _nf,
      'aplazos': _aplazos,
      'state': getState().getState().getName(),
      'type': _type,
      'year': _year,
      'name': _name,
      'icon': _icon,
      'passed': _passed,
      'elect': _elect,
      'points': 0 //TODO: Hardcoded
    };
  }

  /*TODO: No deberia exisitir el passed, hay que calcular de una si la nota
  es mayor a 6, entonces ahi esta aprobada. Las condiciones deberian ser
  regular, porom, ap directa, libre, abandonada.
  */

  bool getElect() => _elect;
  String getDuration() => _duration;
  List<int> getAplazos() => _aplazos;
  String getName() => _name;
  int getYear() => _year;
  List<int> getGradesP() => _gradesP;
  List<int> getGradesT() => _gradesT;
  List<int> getGradesTP() => _gradesTP;
  int getNf() => _nf;
  StateRecord getState() => _state;
  String getType() => _type;
  String getIcon() => _icon;
  bool getPassed() => _passed;

  set passed(passed) => _passed = passed;
  void addgradeP(grade) => _gradesP.add(grade);
  void addgradeT(grade) => _gradesT.add(grade);
  void addgradeTP(grade) => _gradesTP.add(grade);
  void addgradeAp(grade) => _aplazos.add(grade);
  void nf(grade) => _nf = grade;

  void deleteGradeP(int nota) => _gradesP.remove(nota);
  void deleteGradeT(int nota) => _gradesT.remove(nota);
  void deleteGradeTP(int nota) => _gradesTP.remove(nota);
  void deleteGradeAp(int nota) => _aplazos.remove(nota);

  set state(state) => _state = state;

  void modGradeP(int nota, int nuevaNota) {
    int index = _gradesP.indexOf(nota);
    _gradesP[index] = nuevaNota;
  }

  void modGradeT(int nota, int nuevaNota) {
    int index = _gradesT.indexOf(nota);
    _gradesT[index] = nuevaNota;
  }

  void modGradeTP(int nota, int nuevaNota) {
    int index = _gradesTP.indexOf(nota);
    _gradesTP[index] = nuevaNota;
  }

  void modGradAp(int nota, int nuevaNota) {
    if (nota >= 6 && nuevaNota >= 6) {
      nf(nuevaNota);
    } else if (nota >= 6 && nuevaNota < 6) {
      nf(-1);
      _aplazos.add(nuevaNota);
    } else if (nota < 6 && nuevaNota >= 6) {
      _aplazos.remove(nota);

      nf(nuevaNota);
    } else {
      int index = _aplazos.indexOf(nota);
      _aplazos[index] = nuevaNota;
    }
  }

  Subject.allNull();

  Subject.fromOther(Subject other)
      : this._name = other.getName(),
        this._year = other.getYear(),
        this._gradesP = other.getGradesP(),
        this._gradesT = other.getGradesT(),
        this._gradesTP = other.getGradesTP(),
        this._nf = other.getNf(),
        this._state = other.getState(),
        this._type = other.getType(),
        this._icon = other.getIcon(),
        this._passed = other.getPassed(),
        this._aplazos = other.getAplazos(),
        this._duration = other.getDuration(),
        this._elect = other.getElect();

  Subject(
      this._name,
      this._year,
      this._gradesP,
      this._gradesT,
      this._gradesTP,
      this._nf,
      this._state,
      this._type,
      this._icon,
      this._passed,
      this._aplazos,
      this._duration,
      this._elect);

  @override
  String toString() {
    return _name.toString() +
        ',' +
        _year.toString() +
        _gradesP.toString() +
        _gradesT.toString() +
        _gradesTP.toString() +
        _nf.toString() +
        _state.toString() +
        _type.toString();
  }

  Color getColor() {
    switch (_year.toString()) {
      case '1':
        return Color(0xFF4F5973);
      case '2':
        return Color(0xFFB3A5EF);
      case '3':
        return Color(0xFF62DDBD);
      case '4':
        return Color(0xFFFFC305);
      case '5':
        return Color(0xFF96CBFF);
      default:
        return Colors.amber;
    }
  }
}
