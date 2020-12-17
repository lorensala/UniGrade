import 'package:flutter/cupertino.dart';

class Statistics extends ChangeNotifier {
  Statistics(this._avg, this._left, this._passed);

  double _avg;
  //double _realAvg;
  int _passed;
  int _left;
  int _pp;
  int _pt;
  int _ap;

  set avg(avg) => _avg = avg;
  //set realAvg(avg) => _realAvg;
  set passed(passed) => _passed = passed;
  set left(left) => _left = left;
  double getAvg() => _avg;
  //getRealAvg() => _avg;
  int getPassed() => _passed;
  int getLeft() => _left;
}
