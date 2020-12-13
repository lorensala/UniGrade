import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/data/datamanager.dart';

class SubjectDao {
  final db = DataManager();

  Future<List<Subject>> getAllSubjectsWithNoState(Student student) async {
    List<Subject> list = List<Subject>();
    try {
      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection('student_subjects')
          .where('studentId', isEqualTo: student.getId())
          //.where('state', isNotEqualTo: '')
          .get();

      await docs.then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> sub = element.data();

          if (sub != null) {
            var subject = mapper(sub);
            print(subject);
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

  Future<List<Subject>> getAllSubjectsByUser(Student student) async {
    List<Subject> list = List<Subject>();
    try {
      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection('student')
          .doc('mBvFeLfKrcKVCwdhAa7V')
          .collection('student_subjects')
          //.where('short_name', isEqualTo: '')
          .get();

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
      print('=======error======este');
    }

    return list;
  }

  Future<List<Subject>> getAllSubjects() async {
    List<Subject> list = List<Subject>();

    try {
      Future<QuerySnapshot> docs =
          FirebaseFirestore.instance.collection('subject').get();

      await docs.then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> sub = element.data();

          if (sub != null) {
            var subject = mapperReadOnly(sub);

            list.add(subject);
          }

          print('=====succed====');
        });
      });
    } catch (e) {
      print(e);
      print('=======error====== ');
    }

    return list;
  }

  Future<void> addSubjectStudent(Subject subject, String condition) {
    try {
      CollectionReference coll = FirebaseFirestore.instance
          .collection('student')
          .doc('mBvFeLfKrcKVCwdhAa7V')
          .collection('student_subjects');

      return coll
          .add({
            'name': subject.getName(),
            'state': condition,
            'gradesP': [],
            'gradesT': [],
            'gradesTP': [],
            'nf': -1,
            'year': subject.getYear(),
            'short_name': subject.getShortName(),
            'color': subject.getColor(),
            'icon': subject.getIcon(),
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
    var gradesP;
    var gradesT;
    var gradesTp;
    var nf;

    sub['gradesP'] != null
        ? gradesP = new List<int>.from(sub['gradesP'])
        : gradesP = [];

    print(gradesP);

    sub['gradesT'] != null
        ? gradesT = new List<int>.from(sub['gradesT'])
        : gradesT = [];

    print(gradesT);

    sub['gradesTP'] != null
        ? gradesTp = new List<int>.from(sub['gradesTP'])
        : gradesTp = [];

    print(gradesTp);

    sub['nf'] != null ? nf = sub['nf'] : nf = -1;

    print(nf);

    return Subject(sub['name'], sub['year'], sub['short_name'], sub['icon'],
        int.parse(sub['color']), gradesP, gradesT, gradesTp, nf);
  }

  Subject mapperReadOnly(Map<String, dynamic> sub) {
    return Subject(sub['name'], sub['year'], sub['short_name'], sub['icon'],
        int.parse(sub['color']), [], [], [], -1);
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

    try {
      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection('student_subjects')
          .where('name', isEqualTo: subject.getName())
          .get();

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
