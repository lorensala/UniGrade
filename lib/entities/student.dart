import 'package:flutter/foundation.dart';

class Student extends ChangeNotifier {
  String _fullname;
  double _average = 0;
  double _realAverage = 0;
  int _passed = 0;
  int _left = 0;
  int _id = 1;

  addPassed() {
    _passed++;
    notifyListeners();
  }

  subLeft() {
    _left--;
  }

  addLeft() {
    _left++;
  }

  int getId() => _id;

  double getAverage() => _average;

  String getFullname() => _fullname;

  double getRealAverage() => _realAverage;

  int getPassed() => _passed;

  int getLeft() => _left;

  Student(this._fullname);
}
