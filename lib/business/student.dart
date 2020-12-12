import 'package:flutter/foundation.dart';

class Student extends ChangeNotifier {
  String _fullname;
  double _promedio;

  addPromedio() {
    _promedio++;
    notifyListeners();
  }

  double getPromedio() => _promedio;

  String getFullname() => _fullname;

  Student(this._fullname, this._promedio);
}
