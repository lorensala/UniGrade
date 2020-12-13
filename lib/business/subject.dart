import 'package:flutter/foundation.dart';

class Subject extends ChangeNotifier {
  String _name;
  int _year;
  String _shortName;
  String _icon;
  int _color;

  String getName() => _name;
  String getShortName() => _shortName;
  String getIcon() => _icon;
  int getColor() => _color;
  int getYear() => _year;

  Subject(this._name, this._year, this._shortName, this._icon, this._color);
}
