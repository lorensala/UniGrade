import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mis_notas/business/subject.dart';

class DataManager {
  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  Future<void> addSubject(Subject subject) {
    CollectionReference subCollection =
        FirebaseFirestore.instance.collection('subject');

    return subCollection
        .add({
          'color': subject.getColor(),
          'icon': subject.getIcon(),
          'name': subject.getName(),
          'short_name': subject.getShortName(),
          'year': subject.getYear(),
        })
        .then((value) => print('Added'))
        .catchError((error) => print('Falló'));
  }

  Future<void> addNota(int nota) async {
    List<int> _grades = List<int>();
    var docRef;
    DocumentReference materia;

    //TODO: Añadir tipos de nota al momento de agregar.

    try {
      Future<QuerySnapshot> doc = FirebaseFirestore.instance
          .collection('student')
          .doc('mBvFeLfKrcKVCwdhAa7V')
          .collection('student_subjects')
          .where('name', isEqualTo: 'Sistemas Operativos')
          .get();

      await doc.then((value) {
        int size = value.docs[0].data()['gradesP'].length;
        docRef = value.docs[0].reference;

        for (int i = 0; i < size; i++) {
          _grades.add(value.docs[0].data()['gradesP'][i]);
        }
      });

      _grades.add(nota);

      materia = docRef;
    } catch (e) {
      print('============ Error finding doc ============');
    }

    if (materia != null) {
      return materia
          .update({'gradesP': _grades})
          .then((value) =>
              print('============ New grade: $nota added ============'))
          .catchError((error) =>
              print('============ Error during grade adding ============'));
    }
  }
}
