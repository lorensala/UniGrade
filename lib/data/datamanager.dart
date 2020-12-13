import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/business/subject.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();
}
