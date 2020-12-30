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

  Future<void> addNewStudent(Student _student) async {
    Student _newStudent = _student;

    List<Map<String, dynamic>> _map = [
      //Primer Año
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'calculo',
        'year': 1,
        'name': 'Análisis Matemático I',
        'icon': 'assets/images/matematica.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'idioma',
        'year': 1,
        'name': 'Ingles I',
        'icon': 'assets/images/ingles.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'calculo',
        'year': 1,
        'name': 'Álgebra y Geometría Analítica',
        'icon': 'assets/images/algebra.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'calculo',
        'year': 1,
        'name': 'Física I',
        'icon': 'assets/images/fisica.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'otros',
        'year': 1,
        'name': 'Ingeniería y Sociedad',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 1,
        'name': 'Algoritmos y Estructuras de Datos',
        'icon': 'assets/images/software.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'aplazos': [],
        'type': 'hardware',
        'year': 1,
        'name': 'Arquitectura de Computadoras',
        'icon': 'assets/images/aco.png',
        'passed': false
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'aplazos': [],
        'type': 'analista',
        'year': 1,
        'name': 'Sistemas y Organizaciones',
        'icon': 'assets/images/analista.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'aplazos': [],
        'type': 'logica',
        'year': 1,
        'name': 'Matemática Discreta',
        'icon': 'assets/images/logica.png',
        'passed': false
      },
      // Segundo Año

      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'calculo',
        'year': 2,
        'name': 'Análisis Matemático II',
        'icon': 'assets/images/matematica.png',
        'passed': false
      },

      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'calculo',
        'year': 2,
        'name': 'Física II',
        'icon': 'assets/images/fisica2.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'analista',
        'year': 2,
        'name': 'Análisis de Sistemas',
        'icon': 'assets/images/analista.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'aplazos': [],
        'nf': -1,
        'state': '',
        'type': 'idioma',
        'year': 2,
        'name': 'Ingles II',
        'icon': 'assets/images/ingles.png',
        'passed': false
      },

      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'state': '',
        'aplazos': [],
        'type': 'software',
        'year': 2,
        'name': 'Sistemas Operativos',
        'icon': 'assets/images/software.png',
        'passed': false
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 2,
        'name': 'Quimica',
        'icon': 'assets/images/quimica.png',
        'passed': false
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'logica',
        'year': 2,
        'name': 'Sintaxis y Semántica de los Lenguajes',
        'icon': 'assets/images/logica.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'calculo',
        'year': 2,
        'name': 'Probabilidades y Estadísticas',
        'icon': 'assets/images/pye.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 2,
        'name': 'Paradigmas de Programación',
        'icon': 'assets/images/software.png',
        'passed': false
      },

      // Tercer Año
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 3,
        'name': 'Tecnología Educativa',
        'icon': 'assets/images/software.png',
        'passed': false,
        'elect': true,
        'points': 2
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 3,
        'name': 'Gestión de la Mejora de Procesos',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 2
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 3,
        'name': 'Gestión Industrial de la Producción',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 2
      },

      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'analista',
        'year': 3,
        'name': 'Diseño de Sistemas',
        'icon': 'assets/images/analista.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 3,
        'name': 'Sistemas de Representacion',
        'icon': 'assets/images/srp.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'hardware',
        'year': 3,
        'name': 'Comunicaciones',
        'icon': 'assets/images/com.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 3,
        'name': 'Economia',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 3,
        'name': 'Programación de Aplicaciones Visuales I',
        'icon': 'assets/images/software.png',
        'passed': false,
        'elect': true,
        'points': 2
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 3,
        'name': 'Tecnología de Software Base',
        'icon': 'assets/images/software.png',
        'passed': false,
        'elect': true,
        'points': 2
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'calculo',
        'year': 3,
        'name': 'Matemática Superior',
        'icon': 'assets/images/matsup.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 3,
        'name': 'Gestion de Datos',
        'icon': 'assets/images/gda.png',
        'passed': false
      },

      // Cuarto Año
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Programación de Aplicaciones Visuales II',
        'icon': 'assets/images/software.png',
        'passed': false,
        'elect': true,
        'points': 4
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Diseño de Lenguaje de Consultas',
        'icon': 'assets/images/software.png',
        'passed': false,
        'elect': true,
        'points': 4
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Diseño de Lenguaje de Consultas',
        'icon': 'assets/images/software.png',
        'passed': false,
        'elect': true,
        'points': 2
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'hardware',
        'year': 4,
        'name': 'Redes de Información',
        'icon': 'assets/images/redes.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 4,
        'name': 'Administración de Recursos',
        'icon': 'assets/images/adm.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Investigación Operativa',
        'icon': 'assets/images/iop.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Simulación',
        'icon': 'assets/images/default.png',
        'passed': false
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Ingeniería de Software',
        'icon': 'assets/images/software.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Teoría de Control',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 4,
        'name': 'Legislación',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      // Quinto Año

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Auditoría de SI/TI',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Consultoría en Auditoría de SI/TI',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Consultoría en Seguridad de SI/TI',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Decisiones en Escenarios Complejos',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Gerenciamiento Estratégico',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Consultoría en Negocios SI/TI',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Emprendimientos Tecnológicos',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },

      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Inteligencia de Negocios',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Gestión de la Calidad',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Servicios del Software',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Métricas del Software',
        'icon': 'assets/images/default.png',
        'passed': false,
        'elect': true,
        'points': 3
      },

      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Proyecto Final',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 5,
        'name': 'Inteligencia Artificial',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      {
        'duration': 'cuatrimestral',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'otros',
        'year': 5,
        'name': 'Administración Gerencial',
        'icon': 'assets/images/default.png',
        'passed': false
      },
      {
        'duration': 'anual',
        'gradesP': [],
        'gradesT': [],
        'gradesTP': [],
        'nf': -1,
        'aplazos': [],
        'state': '',
        'type': 'software',
        'year': 5,
        'name': 'Sistemas de Gestión',
        'icon': 'assets/images/default.png',
        'passed': false
      },
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
