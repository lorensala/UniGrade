import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mis_notas/entities/student.dart';

class StatisticsDao {
  Future<List<Map<String, dynamic>>> getData(Student _student) async {
    List<Map<String, dynamic>> _list = List<Map<String, dynamic>>();

    try {
      CollectionReference collRef = FirebaseFirestore.instance
          .collection('student')
          .doc(_student.getStudentDocRef())
          .collection('career_student')
          .doc(_student.getCareerDocRefs()[0])
          .collection('subject_student');

      Future<QuerySnapshot> docs = FirebaseFirestore.instance
          .collection(collRef.path)
          .where('passed', isEqualTo: true)
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
}
