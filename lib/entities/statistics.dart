import 'package:flutter/cupertino.dart';

class Statistics extends ChangeNotifier {
  Statistics(this._avg, this._realAvg, this._left, this._passed, this._pp,
      this._pt, this._ap, this._reg);

  double _avg;
  double _realAvg;
  int _passed;
  int _left;
  int _pp;
  int _pt;
  int _ap;
  int _reg;

  set avg(avg) => _avg = avg;
  set realAvg(avg) => _realAvg;
  set passed(passed) => _passed = passed;
  set left(left) => _left = left;
  set pp(pp) => _pp = pp;
  set pt(pt) => _pt = pt;
  set ap(ap) => _ap = ap;
  set reg(reg) => _reg = reg;

  double getAvg() => _avg;
  double getRealAvg() => _avg;
  int getPassed() => _passed;
  int getLeft() => _left;
  int getPP() => _pp;
  int getPT() => _pt;
  int getAP() => _ap;
  int getReg() => _reg;
}