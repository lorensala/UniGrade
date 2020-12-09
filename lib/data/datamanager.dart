import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/business/subject.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  Future<void> addSubejct(Subject subject) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('subject');

    return collection
        .add({
          'name': subject.name,
          'year': subject.year,
        })
        .then((value) => print("subject Added"))
        .catchError((error) => print("Failed to add subject: $error"));
  }
}
