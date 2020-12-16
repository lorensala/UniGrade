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
}
