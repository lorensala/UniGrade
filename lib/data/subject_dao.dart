import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/entities/state.dart';
import 'package:mis_notas/entities/state_record.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/data/datamanager.dart';

class SubjectDao {
  final db = DataManager();

  Future<List<Subject>> getAllSubjectsWithCondition(Student student) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .where('state', isNotEqualTo: '')
          //.orderBy('name')
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

  Future<List<Subject>> getAllSubjectsWithNoCondition(Student student) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
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

  Future<List<Subject>> getAllSubjectsByUserOrderByYear(Student student) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .orderBy('year')
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

  Future<List<Subject>> getAllElectiveSubjectsByUserOrderByYear(
      Student student) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .where('elect', isEqualTo: true)
          .orderBy('year')
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

  Future<List<Subject>> getAllSubjectsByUserCondition(
      Student student, String condition) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .where('state', isEqualTo: condition)
          .orderBy('year')
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

      if (subject.getNf() != -1) {
        await _docRef.update({'state': condition, 'passed': true}).then(
            (value) {
          isDone = true;
          print('============ Subject added succesfully ============');
        }).catchError(
            (error) => print('============ Error adding subject ============'));
      } else {
        await _docRef.update({
          'state': condition,
        }).then((value) {
          isDone = true;
          print('============ Subject added succesfully ============');
        }).catchError(
            (error) => print('============ Error adding subject ============'));
      }
    } catch (e) {
      print('============ Error finding doc ============');
    }

    return isDone;
  }

  Subject mapper(Map<String, dynamic> sub) {
    var gradesP;
    var gradesT;
    var gradesTp;
    var aplazos;
    var elect;

    sub['gradesP'] != null
        ? gradesP = new List<int>.from(sub['gradesP'])
        : gradesP = [];

    sub['gradesT'] != null
        ? gradesT = new List<int>.from(sub['gradesT'])
        : gradesT = [];

    sub['gradesTP'] != null
        ? gradesTp = new List<int>.from(sub['gradesTP'])
        : gradesTp = [];

    sub['aplazos'] != null
        ? aplazos = new List<int>.from(sub['aplazos'])
        : aplazos = [];

    sub['elect'] != null ? elect = sub['elect'] : elect = false;

    return Subject(
        sub['name'],
        sub['year'],
        gradesP,
        gradesT,
        gradesTp,
        sub['nf'],
        StateRecord(State(sub['state']), DateTime.now()),
        sub['type'],
        sub['icon'],
        sub['passed'],
        aplazos,
        sub['duration'],
        elect);
  }

  Future<bool> addSubject(Student _student, Subject subject) async {
    bool isDone = false;
    try {
      CollectionReference coll = FirebaseFirestore.instance
          .collection('student')
          .doc(_student.getStudentDocRef())
          .collection('career_student')
          .doc(_student.getCareerDocRefs()[0])
          .collection('subject_student');

      await coll.add({
        'duration': subject.getDuration(),
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': 'Cursando',
        'type': subject.getType(),
        'year': 1,
        'name': subject.getName(),
        'icon': subject.getIcon(),
        'passed': false
      }).then((value) {
        isDone = true;
        print('============ Subject added succesfully ============');
      }).catchError(
          (error) => print('============ Error adding subject ============'));
    } catch (e) {
      print('============ Error finding doc ============');
      return null;
    }

    return isDone;
  }

  Future<bool> addGrade(
      Student _student, int nota, Subject subject, String type) async {
    List<int> _grades = List<int>();
    List<int> _aplazos = List<int>();
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
        if (nota > 5) {
          await docs.then((value) {
            _docRef = value.docs[0].reference;
          });
        } else {
          await docs.then((value) {
            int size = value.docs[0].data()['aplazos'].length;
            _docRef = value.docs[0].reference;

            if (size != 0)
              for (int i = 0; i < size; i++) {
                _aplazos.add(value.docs[0].data()['aplazos'][i]);
              }
          });
        }
      }

      _grades.add(nota);
      _aplazos.add(nota);

      _materia = _docRef;
    } catch (e) {
      print(e);
      print('============ Error finding doc ============');
      return _isDone;
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
      if (nota > 5) {
        await _materia.update({'nf': nota, 'passed': true}).then((value) {
          _isDone = true;
          print('============ New grade: $nota added ============');
        }).catchError((error) =>
            print('============ Error during grade adding ============'));
      } else {
        await _materia.update({'aplazos': _aplazos}).then((value) {
          _isDone = true;
          print('============ New grade: $nota added ============');
        }).catchError((error) =>
            print('============ Error during grade adding ============'));
      }
    }

    return _isDone;
  }

  Future<bool> updateGrade(Student _student, int oldNotaCheck, Subject subject,
      String type, int newNota) async {
    List<int> _grades = List<int>();
    List<int> _aplazos = List<int>();
    var _docRef;
    var _myType;
    bool _isDone = false;
    DocumentReference _materia;

    int oldNota;

    oldNotaCheck > 10 ? oldNota = oldNotaCheck - 10 : oldNota = oldNotaCheck;

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
            if (value.docs[0].data()[_myType][i] == oldNota)
              _grades.add(newNota);
            else
              _grades.add(value.docs[0].data()[_myType][i]);
          }
        });
      } else {
        if (newNota > 5) {
          await docs.then((value) {
            _docRef = value.docs[0].reference;
          });
        } else {
          await docs.then((value) {
            int size = value.docs[0].data()['aplazos'].length;
            _docRef = value.docs[0].reference;

            if (size != 0)
              for (int i = 0; i < size; i++) {
                _aplazos.add(value.docs[0].data()['aplazos'][i]);
              }
          });
        }
      }

      // _grades.add(newNota);
      if (oldNota > 5) _aplazos.add(newNota);

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
        print('============ New grade: $newNota updated ============');
      }).catchError((error) =>
          print('============ Error during grade updated ============'));
    } else {
      if (newNota > 5) {
        if (oldNota > 5) {
          await _materia.update({'nf': newNota}).then((value) {
            _isDone = true;
            print('============ New grade: $newNota updated ============');
          }).catchError((error) =>
              print('============ Error during grade updated ============'));
        } else {
          await _materia.update({'nf': newNota, 'passed': true}).then((value) {
            _isDone = true;
            print('============ New grade: $newNota updated ============');
          }).catchError((error) =>
              print('============ Error during grade updated ============'));

          await _materia.update({
            'aplazos': FieldValue.arrayRemove([oldNota])
          });
        }
      } else {
        if (_aplazos.contains(oldNota)) {
          _aplazos.remove(oldNota);
          _aplazos.add(newNota);
        }

        await _materia.update(
          {
            'nf': -1,
            'passed': false,
          },
        );

        await _materia.update({'aplazos': _aplazos}).then((value) {
          _isDone = true;
          print('============ New grade: $newNota updated ============');
        }).catchError((error) =>
            print('============ Error during grade updated ============'));
      }
    }

    return _isDone;
  }

  Future<List<Subject>> getAllSubjectsByPassed(Student student) async {
    List<Subject> list = List<Subject>();
    CollectionReference collReference;

    try {
      collReference = FirebaseFirestore.instance
          .collection('student')
          .doc(student.getStudentDocRef())
          .collection('career_student')
          .doc(student.getCareerDocRefs()[0])
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collReference.path)
          .where('passed', isEqualTo: true)
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

  Future<bool> deleteGrade(
      Student _student, int _nota, Subject subject, String type) async {
    List<int> _newListGrades = List<int>();

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

      await docs.then((value) {
        int size = value.docs[0].data()[_myType].length;
        _docRef = value.docs[0].reference;

        for (int i = 0; i < size; i++) {
          _newListGrades.remove(_nota);
        }
      });

      _materia = _docRef;
    } catch (e) {
      print(e);
      print('============ Error finding doc ============');
      return null;
    }

    if (_materia != null) {
      await _materia.update({
        _myType: _newListGrades,
      }).then((value) {
        _isDone = true;
        print('============ Grade: $_nota removed ============');
      }).catchError((error) =>
          print('============ Error during grade removal ============'));
    }

    return _isDone;
  }
}
