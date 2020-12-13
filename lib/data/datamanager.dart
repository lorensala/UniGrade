import 'package:mis_notas/entities/subject.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();
}
