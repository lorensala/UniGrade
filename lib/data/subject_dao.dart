import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/entities/state.dart';
import 'package:mis_notas/entities/state_record.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/data/datamanager.dart';

class SubjectDao {
  final db = DataManager();

  Future<List<Subject>> getSubjectsBySearch(String searchParam) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc('sw98JGNJh4XL9WRVVzBN')
          .collection('career_student')
          .doc('Kynm7JSEA7ZyPpgyD9jp')
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .where('name', isLessThanOrEqualTo: searchParam)
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

  Future<List<Subject>> getAllSubjectsWithNoState(Student student) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc('sw98JGNJh4XL9WRVVzBN')
          .collection('career_student')
          .doc('Kynm7JSEA7ZyPpgyD9jp')
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .where('state', isEqualTo: '')
          .orderBy('name')
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
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
          .collection('subject_student');

      print(collReference.path);

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .orderBy('name')
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
      print('=======error======');
    }

    return list;
  }

  Future<bool> updateSubjectCondition(
      Student _student, Subject subject, String condition) async {
    String _docId;
    DocumentReference _docRef;

    bool isDone = false;

    try {
      Future<QuerySnapshot> _subCollection = FirebaseFirestore.instance
          .collection('student')
          .doc(_student.getStudentDocRef())
          .collection('career_student')
          .doc(_student.getCareerDocRefs()[0])
          .collection('subject_student')
          .where('name', isEqualTo: subject.getName())
          .get();

      await _subCollection.then((value) {
        _docId = value.docs[0].id;
      });

      if (_docId != null)
        _docRef = FirebaseFirestore.instance
            .collection('student')
            .doc(_student.getStudentDocRef())
            .collection('career_student')
            .doc(_student.getCareerDocRefs()[0])
            .collection('subject_student')
            .doc(_docId);

      await _docRef.update({
        'state': condition,
      }).then((value) {
        isDone = true;
        print('============ Subject added succesfully ============');
      }).catchError(
          (error) => print('============ Error adding subject ============'));
    } catch (e) {
      print('============ Error finding doc ============');
    }

    return isDone;
  }

  Subject mapper(Map<String, dynamic> sub) {
    var gradesP;
    var gradesT;
    var gradesTp;
    var nf;

    sub['gradesP'] != null
        ? gradesP = new List<int>.from(sub['gradesP'])
        : gradesP = [];

    sub['gradesT'] != null
        ? gradesT = new List<int>.from(sub['gradesT'])
        : gradesT = [];

    sub['gradesTP'] != null
        ? gradesTp = new List<int>.from(sub['gradesTP'])
        : gradesTp = [];

    sub['nf'] != null ? nf = sub['nf'] : nf = -1;

    return Subject(
        sub['name'],
        sub['year'],
        gradesP,
        gradesT,
        gradesTp,
        nf,
        StateRecord(State(sub['state']), DateTime.now()),
        sub['type'],
        sub['icon']);
  }

  /* Future<void> addSubject(Subject subject) {
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
 */
  Future<bool> addGrade(
      Student _student, int nota, Subject subject, String type) async {
    List<int> _grades = List<int>();
    var _docRef;
    var _myType;
    bool _isDone = false;
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
          .collection('student')
          .doc(_student.getStudentDocRef())
          .collection('career_student')
          .doc(_student.getCareerDocRefs()[0])
          .collection('subject_student')
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
      await _materia.update({
        _myType: _grades,
      }).then((value) {
        _isDone = true;
        print('============ New grade: $nota added ============');
      }).catchError((error) =>
          print('============ Error during grade adding ============'));
    } else {
      await _materia.update({'nf': nota}).then((value) {
        _isDone = true;
        print('============ New grade: $nota added ============');
      }).catchError((error) =>
          print('============ Error during grade adding ============'));
    }

    return _isDone;
  }
}
