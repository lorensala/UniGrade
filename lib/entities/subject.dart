import 'package:flutter/foundation.dart';

class Subject extends ChangeNotifier {
  String _name;
  int _year;
  String _shortName;
  String _icon = '';
  int _color = -1;
  List<int> _gradesP = [];
  List<int> _gradesT = [];
  List<int> _gradesTP = [];
  int _nf = -1;

  String getName() => _name;
  String getShortName() => _shortName;
  String getIcon() => _icon;
  int getColor() => _color;
  int getYear() => _year;
  List<int> getGradesP() => _gradesP;
  List<int> getGradesT() => _gradesT;
  List<int> getGradesTP() => _gradesTP;
  int getNf() => _nf;

  Subject(this._name, this._year, this._shortName, this._icon, this._color,
      this._gradesP, this._gradesT, this._gradesTP, this._nf);
}
