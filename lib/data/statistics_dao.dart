import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/entities/student.dart';

class StatisticsDao {
  Future<List<Map<String, dynamic>>> getData(Student _student) async {
    List<Map<String, dynamic>> _list = List<Map<String, dynamic>>();

    try {
      CollectionReference collRef = FirebaseFirestore.instance
          .collection('student')
          .doc(_student.getDocId()[0])
          .collection('career_student')
          .doc(_student.getSubId())
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collRef.path)
          .where('state', isNotEqualTo: '')
          .get();

      await docs.then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic> _sub = element.data();
          if (_sub.isNotEmpty) _list.add(_sub);
        });
        print('=====succed====');
      });
    } catch (e) {
      print(e);
      print('=======error======');
    }
    return _list;
  }

  Future<String> getSubId(Student student) async {
    Future<QuerySnapshot> _queryData = FirebaseFirestore.instance
        .collection('student')
        .doc(student.getDocId()[0])
        .collection('career_student')
        .where('name', isEqualTo: 'Ingeniería en Sistemas de Informacion')
        .get();

    await _queryData.then((value) {
      if (value.docs.isNotEmpty)
        return value.docs[0].id;
      else
        return null;
    });
  }

  Future<String> getDocId(Student student) async {
    String _userId;

    Future<QuerySnapshot> _queryData = FirebaseFirestore.instance
        .collection('student')
        .where(
          'uid',
          isEqualTo: student.getId(),
        )
        .get();

    _userId = await _queryData.then((value) {
      if (value.docs.isNotEmpty)
        return value.docs[0].id;
      else
        return null;
    });

    return _userId;
  }
}

// sw98JGNJh4XL9WRVVzBN idUser
// Kynm7JSEA7ZyPpgyD9jp id carrer_stundet
