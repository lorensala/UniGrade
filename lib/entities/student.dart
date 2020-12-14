import 'package:flutter/foundation.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';

class Student extends ChangeNotifier {
  String _fullname;
  String _uid;
  University _university;
  String _profilePic;
  List<Subject> _subjects;

  /* TODO: Aplica a todas las clases. Modificar las funciones por properties.
  get fullname => _fullname;  
  */
  String getId() => _uid;

  String getFullname() => _fullname;

  University getUniversity() => _university;

  String getProfilePic() => _profilePic;

  List<Subject> getSubjecs() => _subjects;

  Student(this._fullname, this._profilePic, this._subjects, this._uid,
      this._university);

  void test() {
    _fullname = 'Lorencio Sala';
    notifyListeners();
  }
}
