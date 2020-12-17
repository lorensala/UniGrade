import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/entities/student.dart';

class StudentDao {
  Future<void> updateUID(Student _student, String _userId) {
    try {
      DocumentReference _docRef = FirebaseFirestore.instance
          .collection('student')
          .doc(_student.getCareerDocRefs()[0]);

      print('=====succed======');
      return _docRef.update({'uid': _userId});
    } catch (e) {
      print(e);
      print('=====error=======');
      return null;
    }
  }

  Future<void> updateStudent(
    Student _student,
  ) {
    try {
      DocumentReference _docRef = FirebaseFirestore.instance
          .collection('student')
          .doc(_student.getStudentDocRef());

      print('=====succed======');
      return _docRef.update({
        'uid': _student.getId(),
        'display_name': _student.getFullname(),
        'careeerDocRef': FieldValue.arrayUnion(_student.getCareerDocRefs()),
        'studentDocRef': _student.getStudentDocRef(),
        'profile_pic': _student.getProfilePic(),
        'university': _student.getUniversityShortName()
      });
    } catch (e) {
      print(e);
      print('=====error=======');
      return null;
    }
  }

  Future<String> getCarrerDocRefs(String _studentDocref) async {
    var _res;

    Future<QuerySnapshot> _queryData = FirebaseFirestore.instance
        .collection('student')
        .doc(_studentDocref)
        .collection('career_student')

        // TODO: Este solo devuelve para sistemas.

        .where('name', isEqualTo: 'Ingeniería en Sistemas de Informacion')
        .get();

    await _queryData.then((value) {
      if (value.docs.isNotEmpty) _res = value.docs[0].id;
    });

    return _res;
  }

  Future<String> getStudentsDocRef(String _studentId) async {
    var _userId;

    Future<QuerySnapshot> _queryData = FirebaseFirestore.instance
        .collection('student')
        .where('uid', isEqualTo: _studentId)
        .get();

    if (_queryData != null) {
      await _queryData.then((value) {
        if (value.docs.isNotEmpty) _userId = value.docs[0].id;
      });
    }
    return _userId;
  }

  Future<Student> addNewStudent(Student _student) async {
    //TODO: Crear el data manager.

    Student _newStudent = _student;

    List<Map<String, dynamic>> _map = [
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'type': 'software',
        'year': 2,
        'name': 'Sistemas Operativos',
        'icon': 'assets/images/software.png'
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'type': 'software',
        'year': 1,
        'name': 'Algoritmos y Estructuras de datos',
        'icon': 'assets/images/software.png'
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'type': 'analista',
        'year': 3,
        'name': 'Diseño de Sistemas',
        'icon': 'assets/images/analista.png'
      },
      {
        'duration': 'semestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'type': 'software',
        'year': 2,
        'name': 'Quimica',
        'icon': 'assets/images/043-chemistry.png'
      }
    ];

    CollectionReference collRef =
        FirebaseFirestore.instance.collection('student');

    await collRef.add({
      'uid': _student.getId(),
      'display_name': _student.getFullname(),
      'profile_pic': _student.getProfilePic(),
      'university': _student.getUniversityShortName()
    });

    var carPath = await getStudentsDocRef(_student.getId());

    _newStudent.studentDocRef = carPath;

    collRef = FirebaseFirestore.instance
        .collection('student')
        .doc(carPath)
        .collection('career_student');

    await collRef.add({'name': 'Ingeniería en Sistemas de Informacion'}).then(
        (value) => print('===== Se anadio la carrera======='));

    var subPath = await getCarrerDocRefs(carPath);

    _newStudent.carrerDocRefs = [subPath];

    var newcollRef = FirebaseFirestore.instance
        .collection(collRef.path)
        .doc(subPath)
        .collection('subject_student');

    _map.forEach((element) async {
      await newcollRef
          .add(element)
          .then((value) => print('Se anadio la materia ${element['name']}'))
          .catchError((error) => print(error));
    });
  }
}

//TODO: Considerar hacer esto en todas las clases.

/* 
class Human {
  String name;
  int age;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }
} */
