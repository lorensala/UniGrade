import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/business/subject.dart';
import 'package:mis_notas/data/datamanager.dart';

class SubjectDao {
  final db = DataManager();

  Future<List<Subject>> getAllSubjects() async {
    List<Subject> list = List<Subject>();

    try {
      Future<QuerySnapshot> docs =
          FirebaseFirestore.instance.collection('subject').get();

      await docs.then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> sub = element.data();

          if (sub != null) {
            var subject = mapper(sub);

            list.add(subject);
          }

          print('=====succed====');
        });
      });
    } catch (e) {
      print(e);
      print('=======error======');
    }

    return list;
  }

  Future<void> addSubjectStudent(Subject subject, String condition) {
    try {
      CollectionReference coll =
          FirebaseFirestore.instance.collection('student_subjects');
      return coll
          .add({
            'studentId': 1,
            'name': subject.getName(),
            'state': condition,
            'gradesP': [],
            'gradesT': [],
            'gradesTP': [],
          })
          .then((value) =>
              print('============ Subject added succesfully ============'))
          .catchError((error) =>
              print('============ Error adding subject ============'));
    } catch (e) {
      print('============ Error finding doc ============');
      return null;
    }
  }

  Subject mapper(Map<String, dynamic> sub) {
    return Subject(sub['name'], sub['year'], sub['short_name'], sub['icon'],
        int.parse(sub['color']));
  }

  Future<void> addSubject(Subject subject) {
    try {
      CollectionReference coll =
          FirebaseFirestore.instance.collection('subject');
      return coll
          .add({
            'color': subject.getColor(),
            'icon': subject.getIcon(),
            'name': subject.getName(),
            'short_name': subject.getShortName(),
            'year': subject.getYear(),
          })
          .then((value) =>
              print('============ Subject added succesfully ============'))
          .catchError((error) =>
              print('============ Error adding subject ============'));
    } catch (e) {
      print('============ Error finding doc ============');
      return null;
    }
  }

  Future<void> addNota(int nota, Subject subject, String type) async {
    List<int> _grades = List<int>();
    var _docRef;
    var _myType;
    DocumentReference _materia;

    List<String> _types = ['Práctico', 'Teórico', 'TP', 'Final'];

    switch (type) {
      case 'Práctico':
        {
          _myType = 'gradesP';
        }
        break;
      case 'Teórico':
        {
          _myType = 'gradesT';
        }
        break;
      case 'TP':
        {
          _myType = 'gradesTP';
        }
        break;
      case 'Final':
        {
          _myType = 'nf';
        }
        break;
    }

    print(_myType);

    try {
      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection('student_subjects')
          .where('name', isEqualTo: subject.getName())
          .get();

      docs.then((value) => print(value.docs[0].data()));

      if (_myType != 'nf') {
        await docs.then((value) {
          int size = value.docs[0].data()[_myType].length;
          _docRef = value.docs[0].reference;

          for (int i = 0; i < size; i++) {
            _grades.add(value.docs[0].data()[_myType][i]);
          }
        });
      } else {
        await docs.then((value) {
          _docRef = value.docs[0].reference;
        });
      }

      _grades.add(nota);

      _materia = _docRef;
    } catch (e) {
      print(e);
      print('============ Error finding doc ============');
      return null;
    }

    if (_materia != null && _myType != 'nf') {
      return _materia
          .update({
            _myType: _grades,
          })
          .then((value) =>
              print('============ New grade: $nota added ============'))
          .catchError((error) =>
              print('============ Error during grade adding ============'));
    } else {
      return _materia
          .update({'nf': nota})
          .then((value) =>
              print('============ New grade: $nota added ============'))
          .catchError((error) =>
              print('============ Error during grade adding ============'));
    }
  }
}
