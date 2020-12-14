import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mis_notas/entities/state_record.dart';

class Subject extends ChangeNotifier {
  String _name;
  int _year;
  List<int> _gradesP;
  List<int> _gradesT;
  List<int> _gradesTP;
  int _nf = -1;
  StateRecord _state;
  String _type;
  String _icon;

  String getName() => _name;
  int getYear() => _year;
  List<int> getGradesP() => _gradesP;
  List<int> getGradesT() => _gradesT;
  List<int> getGradesTP() => _gradesTP;
  int getNf() => _nf;
  StateRecord getState() => _state;
  String getType() => _type;
  String getIcon() => _icon;

  Subject(this._name, this._year, this._gradesP, this._gradesT, this._gradesTP,
      this._nf, this._state, this._type, this._icon);

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
    switch (_type) {
      case 'software':
        return Color(0xFFFC8370);
      case 'logica':
        return Color(0xFFB3A5EF);
    }
  }
}
