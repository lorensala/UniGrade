import 'package:flutter/foundation.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/services/statistics.dart';

class Student extends ChangeNotifier {
  String _fullname;
  String _uid;
  University _university;
  String _profilePic;
  List<Subject> _subjects;
  List<String> _docId;
  String _subId;

  set subId(subID) => _subId = subID;
  set docId(docID) => _docId = docID;
  set fullname(fullname) => _fullname = fullname;
  set uid(uid) => _uid = uid;
  set university(university) => _university = university;
  set profilePic(profilePic) => _profilePic = profilePic;
  set subjects(subjects) => _subjects = subjects;

  void updated() {
    notifyListeners();
  }

  /* TODO: Aplica a todas las clases. Modificar las funciones por properties.
  get fullname => _fullname;  
  */
  List<String> getDocId() => _docId;

  String getSubId() => _subId;

  String getId() => _uid;

  String getFullname() => _fullname;

  University getUniversity() => _university;

  String getProfilePic() => _profilePic;

  List<Subject> getSubjecs() => _subjects;

  Student(this._fullname, this._profilePic, this._subjects, this._uid,
      this._university, this._docId, this._subId);

  void test() {
    _fullname = 'Lorencio Sala';
    notifyListeners();
  }

  @override
  String toString() {
    return super.toString();
  }
}
