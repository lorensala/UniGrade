import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mis_notas/entities/state_record.dart';

class Subject extends ChangeNotifier {
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
  bool _passed;

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
      this._aplazos);

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

  // TODO: Ver theme.of(context) como funciona y ver de hacer la carpeta con los Colores.

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
