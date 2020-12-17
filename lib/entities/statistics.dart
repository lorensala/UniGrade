import 'package:flutter/cupertino.dart';

class Statistics extends ChangeNotifier {
  Statistics(this._avg, this._left, this._passed);

  double _avg;
  //double _realAvg;
  int _passed;
  int _left;

  set avg(avg) => _avg;
  //set realAvg(avg) => _realAvg;
  set passed(avg) => _passed;
  set left(avg) => _left;

  getAvg() => _avg;
  //getRealAvg() => _avg;
  getPassed() => _passed;
  getLeft() => _left;
}
