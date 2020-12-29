import 'package:flutter/foundation.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';

class Student extends ChangeNotifier {
  String _fullname;
  String _uid;
  University _university;
  String _profilePic;
  List<Subject> _subjects;
  List<String> _carrerDocRefs;
  String _studentDocRef;

  set studentDocRef(studentDocRef) => _studentDocRef = studentDocRef;
  set carrerDocRefs(carrerDocRefs) => _carrerDocRefs = carrerDocRefs;
  set fullname(fullname) => _fullname = fullname;
  set uid(uid) => _uid = uid;
  set university(university) => _university = university;
  set profilePic(profilePic) => _profilePic = profilePic;
  set subjects(subjects) => _subjects = subjects;

  void updated() {
    notifyListeners();
  }

  List<String> getCareerDocRefs() => _carrerDocRefs;

  String getStudentDocRef() => _studentDocRef;

  String getId() => _uid;

  String getFullname() => _fullname;

  University getUniversity() => _university;

  String getUniversityName() => _university.getName();

  String getUniversityShortName() => _university.getShortName();

  String getCarrerName() => _university.getCareers()[0].getName();

  String getProfilePic() => _profilePic;

  List<Subject> getSubjecs() => _subjects;

  Student(this._fullname, this._profilePic, this._subjects, this._uid,
      this._university, _carrerDocRefs, _studentDocRef);

  void test() {
    _fullname = 'Lorencio Sala';
    notifyListeners();
  }

  @override
  String toString() {
    return super.toString();
  }
}
