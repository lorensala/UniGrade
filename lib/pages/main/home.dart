import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mis_notas/data/student_dao.dart';
import 'package:mis_notas/entities/career.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/pages/dialogs/new_user_dialog.dart';
import 'package:mis_notas/pages/main/options_page.dart';
import 'package:mis_notas/pages/main/profile_page.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isLoading = true;
  var _studentDao = new StudentDao();
  int page = 0;
  List<Subject> _listSubj = [];
  var isPressedHome = true;
  var isPressedProfile = false;
  var isPressedSettings = false;
  final Map<String, List<String>> buttons = {
    'settings': [
      'assets/images/settings.png',
      'assets/images/settings_white.png'
    ],
    'home': ['assets/images/home.png', 'assets/images/home_white.png'],
    'user': ['assets/images/user.png', 'assets/images/user_white.png'],
    'info': ['assets/images/info.png']
  };

  Future<List> getDataStudent() async {
    User _user = FirebaseAuth.instance.currentUser;
    String _userId = _user.uid;

    var _studentDocRef = await _studentDao.getStudentsDocRef(_userId);
    var _careerDocRef = await _studentDao.getCarrerDocRefs(_studentDocRef);

    List _list = [
      _user.displayName,
      _user.photoURL,
      [],
      _userId,
      University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
      [_careerDocRef],
      _studentDocRef
    ];

    return _list;
  }

  List<Map<String, dynamic>> _data = [
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Análisis Matemático I'
    },
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Álgebra y Geometría Analítica'
    },
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Algoritmos y Estructuras de Datos'
    },
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Arquitectura de Computadoras'
    },
    {'aprobada': [], 'cursada': [], 'rendir': [], 'name': 'Física I'},
    {'aprobada': [], 'cursada': [], 'rendir': [], 'name': 'Inglés I'},
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Matemática Discreta'
    },
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Sistemas y Organizaciones'
    },
    {
      'aprobada': [],
      'cursada': ['Análisis Matemático I', 'Álgebra y Geometría Analítica'],
      'rendir': ['Análisis Matemático I', 'Álgebra y Geometría Analítica'],
      'name': 'Análisis Matemático II'
    },
    {'aprobada': [], 'cursada': [], 'rendir': [], 'name': 'Química'},
    {
      'aprobada': [],
      'cursada': ['Análisis Matemático I', 'Física I'],
      'rendir': ['Análisis Matemático I', 'Física I'],
      'name': 'Física II'
    },
    {
      'aprobada': [],
      'cursada': [
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'rendir': [
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'name': 'Análisis de Sistemas'
    },
    {
      'aprobada': [],
      'cursada': ['Matemática Discreta', 'Algoritmos y Estructuras de Datos'],
      'rendir': ['Matemática Discreta', 'Algoritmos y Estructuras de Datos'],
      'name': 'Sintaxis y Semántica de los Lenguajes'
    },
    {
      'aprobada': [],
      'cursada': ['Matemática Discreta', 'Algoritmos y Estructuras de Datos'],
      'rendir': ['Matemática Discreta', 'Algoritmos y Estructuras de Datos'],
      'name': 'Paradigmas de Programación'
    },
    {
      'aprobada': [],
      'cursada': [
        'Matemática Discreta',
        'Algoritmos y Estructuras de Datos',
        'Arquitectura de Computadoras'
      ],
      'rendir': [
        'Matemática Discreta',
        'Algoritmos y Estructuras de Datos',
        'Arquitectura de Computadoras'
      ],
      'name': 'Sistemas Operativos'
    },
    {
      'aprobada': [],
      'cursada': [],
      'rendir': [],
      'name': 'Sistemas de Representación'
    },
    {
      'aprobada': [],
      'cursada': ['Análisis Matemático I', 'Álgebra y Geometría Analítica'],
      'rendir': ['Análisis Matemático I', 'Álgebra y Geometría Analítica'],
      'name': 'Probabilidad y Estadísticas'
    },
    {
      'aprobada': [
        'Matemática Discreta',
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'cursada': ['Análisis de Sistemas', 'Paradigmas de Programación'],
      'rendir': ['Análisis de Sistemas', 'Paradigmas de Programación'],
      'name': 'Diseño de Sistemas'
    },
    {
      'aprobada': [
        'Análisis Matemático I',
        'Álgebra y Geometría Analítica',
        'Física I'
      ],
      'cursada': [
        'Arquitectura de Computadoras',
        'Análisis Matemático II',
        'Física II'
      ],
      'rendir': [
        'Arquitectura de Computadoras',
        'Análisis Matemático II',
        'Física II'
      ],
      'name': 'Comunicaciones'
    },
    {
      'aprobada': ['Análisis Matemático I', 'Álgebra y Geometría Analítica'],
      'cursada': ['Análisis Matemático II'],
      'rendir': ['Análisis Matemático II'],
      'name': 'Matemática Superior'
    },
    {
      'aprobada': [
        'Matemática Discreta',
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'cursada': [
        'Análisis de Sistemas',
        'Sintaxis y Semántica de los Lenguajes',
        'Paradigmas de Programación'
      ],
      'rendir': [
        'Análisis de Sistemas',
        'Sintaxis y Semántica de los Lenguajes',
        'Paradigmas de Programación'
      ],
      'name': 'Gestión de Datos'
    },
    {
      'aprobada': [
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'cursada': [
        'Análisis de Sistemas',
      ],
      'rendir': [
        'Análisis de Sistemas',
      ],
      'name': 'Economía'
    },
    {
      'aprobada': ['Inglés I'],
      'cursada': [],
      'rendir': [],
      'name': 'Inglés II'
    },
    {
      'rendir': ['Sisteamas Operativos', 'Comunicaciones'],
      'cursada': ['Sisteamas Operativos', 'Comunicaciones'],
      'aprobada': [
        'Matemática Discreta',
        'Algoritmos y Estructuras de Datos',
        'Arquitectura de Computadoras',
        'Análisis Matemático II',
        'Física II'
      ],
      'name': 'Redes de Información'
    },
    {
      'cursada': [
        'Arquitectura de Computadoras',
        'Inglés I',
        'Análisis de Sistemas',
        'Paradigmas de Programación'
      ],
      'aprobada': ['Sisteamas Operativos', 'Diseño de Sistemas', 'Economía'],
      'rendir': [
        'Arquitectura de Computadoras',
        'Inglés I',
        'Análisis de Sistemas',
        'Paradigmas de Programación'
      ],
      'name': 'Administración de Recursos'
    },
    {
      'cursada': ['Probabilidad y Estadísticas', 'Matemática Superior'],
      'aprobada': ['Análisis Matemático II'],
      'rendir': ['Probabilidad y Estadísticas', 'Matemática Superior'],
      'name': 'Investigación Operativa'
    },
    {
      'cursada': ['Probabilidad y Estadísticas', 'Matemática Superior'],
      'aprobada': ['Análisis Matemático II'],
      'rendir': ['Probabilidad y Estadísticas', 'Matemática Superior'],
      'name': 'Simulación'
    },
    {
      'cursada': [
        'Probabilidad y Estadísticas',
        'Diseño de Sistemas',
        'Gestión de Datos'
      ],
      'aprobada': [
        'Análisis de Sistemas',
        'Sintaxis y Semántica de los Lenguajes',
        'Paradigmas de Programación'
      ],
      'rendir': [
        'Probabilidad y Estadísticas',
        'Diseño de Sistemas',
        'Gestión de Datos'
      ],
      'name': 'Ingeniería en Software'
    },
    {
      'cursada': ['Química', 'Matemática Superior'],
      'aprobada': [
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'rendir': ['Química', 'Matemática Superior'],
      'name': 'Teoría de Control'
    },
    {
      'aprobada': [
        'Sistemas y Organizaciones',
        'Algoritmos y Estructuras de Datos'
      ],
      'cursada': ['Análisis de Sistemas', 'Ingeniería y Sociedad'],
      'rendir': ['Análisis de Sistemas', 'Ingeniería y Sociedad'],
      'name': 'Legislación'
    },
    {
      'aprobada': [
        'Sistemas Operativos',
        'Sistemas de Representación',
        'Probabilidad y Estadísticas',
        'Diseño de Sistemas',
        'Comunicaciones',
        'Gestion de Datos',
        'Ingeniería y Sociedad',
        'Economía',
        'Ingles II'
      ],
      'cursada': [
        'Redes de Información',
        'Administración de Recursos',
        'Ingeniería en Software',
        'Legislación'
      ],
      'rendir': ['TODAS'],
      'name': 'Proyecto Final'
    },
    {
      'aprobada': [
        'Probabilidad y Estadísticas',
        'Diseño de Sistemas',
        'Matemática Superior',
      ],
      'cursada': ['Investigación Operativa', 'Simulación'],
      'rendir': ['Investigación Operativa', 'Simulación'],
      'name': 'Inteligencia Artificial'
    },
    {
      'aprobada': [
        'Sistemas Operativos',
        'Economía'
            'Probabilidad y Estadísticas',
        'Diseño de Sistemas',
        'Matemática Superior',
      ],
      'cursada': ['Investigación Operativa', 'Administración de Recursos'],
      'rendir': ['Investigación Operativa', 'Administración de Recursos'],
      'name': 'Administración Gerencial'
    },
    {
      'aprobada': [
        'Sistemas Operativos',
        'Economía'
            'Probabilidad y Estadísticas',
        'Diseño de Sistemas',
        'Matemática Superior',
      ],
      'cursada': [
        'Investigación Operativa',
        'Administración de Recursos',
        'Simulación'
      ],
      'rendir': [
        'Investigación Operativa',
        'Administración de Recursos',
        'Simulación'
      ],
      'name': 'Sistemas de Gestión'
    }
  ];

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context, listen: false);
    ValueNotifier<bool> _isNew = Provider.of<ValueNotifier<bool>>(context);
    if (_isNew.value) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showNewUserDialog(context));
    }

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          CoolAlert.show(
            onConfirmBtnTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            confirmBtnColor: Color(0xFF66AAFF),
            backgroundColor: Colors.white,
            context: context,
            type: CoolAlertType.confirm,
            title: "¿Estas seguro que quieres salir?",
            confirmBtnText: "Si",
            cancelBtnText: "No",
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SmartRefresher(
            header: WaterDropHeader(
              complete: Text(''),
              waterDropColor: Color(0xFF66AAFF),
            ),
            controller: _refreshController,
            onRefresh: () {
              setState(() {});
              _refreshController.refreshCompleted();
            },
            onLoading: () {
              setState(() {});
              _refreshController.loadComplete();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Image.asset('assets/images/hamburger.png'),
                            InkWell(
                                onTap: () {
                                  showNewUserDialog(context);
                                },
                                child: Image.asset('assets/images/info.png')),
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: getDataStudent(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case (ConnectionState.waiting):
                                return Center(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Center(
                                          child: CircularProgressIndicator())),
                                );
                              default:
                                if (snapshot.hasError) return Text('error');

                                _student.fullname = snapshot.data[0];
                                _student.profilePic = snapshot.data[1];
                                _student.subjects = _listSubj;
                                _student.uid = snapshot.data[3];
                                _student.university = snapshot.data[4];
                                _student.carrerDocRefs = snapshot.data[5];
                                _student.studentDocRef = snapshot.data[6];

                                _studentDao.updateStudent(_student);

                                if (page == 0) return MainPage();
                                return ProfilePage();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Container(
              height: 50,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        right: 4,
                        top: 4,
                        child: CircleAvatar(
                          backgroundColor:
                              isPressedSettings ? Colors.blue : Colors.white,
                        ),
                      ),
                      IconButton(
                          icon: !isPressedSettings
                              ? Image.asset(buttons['settings'][0])
                              : Image.asset(buttons['settings'][1]),
                          onPressed: () {
                            _data.forEach((element) {
                              FirebaseFirestore.instance
                                  .collection('/career/isi/correlativas')
                                  .add(element);
                            });

                            //showSettings(context);
                          }
                          //{showNewUserDialog(context)},
                          ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        right: 4,
                        top: 4,
                        child: CircleAvatar(
                          backgroundColor:
                              isPressedHome ? Colors.blue : Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: !isPressedHome
                            ? Image.asset(buttons['home'][0])
                            : Image.asset(buttons['home'][1]),
                        onPressed: () {
                          if (page != 0)
                            setState(() {
                              page = 0;
                              isPressedHome = true;
                              isPressedProfile = false;
                              isPressedSettings = false;
                            });
                        },
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        right: 4,
                        top: 4,
                        child: CircleAvatar(
                          backgroundColor:
                              isPressedProfile ? Colors.blue : Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: !isPressedProfile
                            ? Image.asset(buttons['user'][0])
                            : Image.asset(buttons['user'][1]),
                        onPressed: () {
                          if (page != 1)
                            setState(() {
                              page = 1;
                              isPressedHome = false;
                              isPressedProfile = true;
                              isPressedSettings = false;
                            });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  showNewUserDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return NewUserDialog();
        });
  }

  showSettings(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return OptionsDialog();
        });
  }
}
