import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/services/statistics_service.dart';

import 'package:mis_notas/widgets/styles/statistics_container.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/widgets/styles/statistics_container_blank.dart';

import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class MisEstadisticas extends StatefulWidget {
  @override
  _MisEstadisticasState createState() => _MisEstadisticasState();
}

class _MisEstadisticasState extends State<MisEstadisticas> {
  int _selectedYear = 1;

  Future<List> getYearStatisticsData(Student _student, int _year) async {
    List _statisticsList = new List();
    var _statisticsService = StatisticsService();

    List<Subject> _list = List<Subject>();

    List<Subject> _listAll = _student.getSubjects();

    _listAll.forEach((s) {
      if (s.getState().getState().getName() != '') _list.add(s);
    });

    _statisticsList
        .add(await _statisticsService.getAvgNf(_student, _list, _year));
    _statisticsList.add(
        await _statisticsService.getSubjectsPassed(_student, _list, _year));
    _statisticsList.add(
        await _statisticsService.getSubjectsLeft(_student, _listAll, _year));
    _statisticsList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, _year, 'Promoción Práctica'));
    _statisticsList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, _year, 'Promoción Teórica'));
    _statisticsList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, _year, 'Aprobación Directa'));
    _statisticsList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, _year, 'Regular'));
    _statisticsList.add(
        await _statisticsService.getSubjectsCount(_student, _listAll, _year));
    _statisticsList.add(
        await _statisticsService.getAvgNfWithBadGrades(_student, _list, _year));

    return _statisticsList;
  }

  Future<List<Subject>> getSubjectsData(Student _student) async {
    List<Subject> _statisticsList = new List<Subject>();
    List<Subject> _filteredList = new List<Subject>();
    var _statisticsService = StatisticsService();

    List<Subject> _list = List<Subject>();

    List<Subject> _listAll = _student.getSubjects();

    _listAll.forEach((s) {
      if (s.getState().getState().getName() != '') _list.add(s);
    });

    if (_list.length != 0) {
      _list.forEach((Subject sub) {
        if (sub.getState().getState().getName() != 'Libre' &&
            sub.getState().getState().getName() != 'Abandonada')
          _filteredList.add(sub);
      });

      _statisticsList.add(await _statisticsService.getBestAvg(
        _student,
        _filteredList,
      ));

      _statisticsList
          .add(await _statisticsService.getWorstAvg(_student, _filteredList));
    }
    return _statisticsList;
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);

    //TODO: Fijarse que la cantidad de materias es dinamica. Hardcoded

    int percentage = (((_student.getStatistics().getPassed() +
                _student.getStatistics().getPoints()) *
            100 /
            59))
        .round();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            'assets/images/3.0x/backarrow.png',
                            scale: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mis Estadísticas',
                          style: TextStyle(
                            fontFamily: 'Avenir LT Std',
                            fontSize: 30,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w800,
                            height: 0.9666666666666667,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SvgPicture.string(
                          '<svg viewBox="323.0 109.0 28.0 28.0" ><path transform="translate(322.44, 108.44)" d="M 28.56250381469727 14.56250095367432 C 28.56250381469727 22.29620552062988 22.2939453125 28.56250381469727 14.56250095367432 28.56250381469727 C 6.831056594848633 28.56250381469727 0.5625000596046448 22.29620170593262 0.5625000596046448 14.56250095367432 C 0.5625000596046448 6.833314418792725 6.831056594848633 0.5625000596046448 14.56250095367432 0.5625000596046448 C 22.2939453125 0.5625000596046448 28.56250381469727 6.833314895629883 28.56250381469727 14.56250095367432 Z M 14.93818664550781 5.191532611846924 C 11.86174297332764 5.191532611846924 9.899598121643066 6.487492561340332 8.358806610107422 8.790775299072266 C 8.159193992614746 9.089178085327148 8.22597599029541 9.491621971130371 8.512073516845703 9.708564758300781 L 10.47088718414307 11.19380760192871 C 10.76471900939941 11.41662120819092 11.18336391448975 11.36361408233643 11.41165351867676 11.07401657104492 C 12.42010498046875 9.794936180114746 13.11158180236816 9.053218841552734 14.64650058746338 9.053218841552734 C 15.7997522354126 9.053218841552734 17.22622680664063 9.795444488525391 17.22622680664063 10.91375064849854 C 17.22622680664063 11.75917053222656 16.5283145904541 12.19334030151367 15.38963031768799 12.83175086975098 C 14.06166172027588 13.5761775970459 12.30443572998047 14.50271892547607 12.30443572998047 16.82056617736816 L 12.30443572998047 17.04637145996094 C 12.30443572998047 17.42047691345215 12.60775089263916 17.72379112243652 12.98185539245605 17.72379112243652 L 16.14314651489258 17.72379112243652 C 16.51725006103516 17.72379112243652 16.82056617736816 17.42047691345215 16.82056617736816 17.04637145996094 L 16.82056617736816 16.97112274169922 C 16.82056617736816 15.36439514160156 21.51655006408691 15.29750061035156 21.51655006408691 10.94959735870361 C 21.51655006408691 7.675290107727051 18.12013626098633 5.191532611846924 14.93818664550781 5.191532611846924 Z M 14.56250095367432 19.19153213500977 C 13.13060569763184 19.19153213500977 11.96572685241699 20.35641479492188 11.96572685241699 21.78830909729004 C 11.96572685241699 23.22014617919922 13.13060569763184 24.38508224487305 14.56250095367432 24.38508224487305 C 15.9943962097168 24.38508224487305 17.15927505493164 23.22014617919922 17.15927505493164 21.78830909729004 C 17.15927505493164 20.35641479492188 15.9943962097168 19.19153213500977 14.56250095367432 19.19153213500977 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
                    child: SvgPicture.string(
                      '<svg viewBox="24.0 151.5 255.5 1.0" ><path transform="translate(24.0, 151.5)" d="M 0 0 L 255.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                    child: Container(
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            startAngle: 270,
                            endAngle: 270,
                            showLabels: false,
                            showTicks: false,
                            radiusFactor: 0.8,
                            axisLineStyle: AxisLineStyle(
                              thickness: 0.14,
                              cornerStyle: CornerStyle.bothFlat,
                              //color: Colors.amber,
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            pointers: <GaugePointer>[
                              RangePointer(
                                  color: Colors.blue[200],
                                  value: double.parse(percentage.toString()),
                                  cornerStyle: CornerStyle.bothFlat,
                                  width: 0.14,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  enableAnimation: true,
                                  animationDuration: 600,
                                  animationType: AnimationType.linear),
                              MarkerPointer(
                                  value: double.parse(percentage.toString()),
                                  color: Colors.blue,
                                  markerType: MarkerType.circle,
                                  markerHeight: 22,
                                  markerWidth: 22,
                                  enableAnimation: true,
                                  animationDuration: 600,
                                  animationType: AnimationType.linear)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  positionFactor: 0.08,
                                  angle: 90,
                                  widget: Container(
                                    width: 190.0,
                                    height: 188.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            _student.getProfilePic()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                    child: Text(
                      'Información General:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 22,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                    child: Container(
                      height: 130,
                      child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            StatisticsContainer(percentage.toString() + '%',
                                'Carrera Completada', 0, 0),
                            StatisticsContainer(
                                _student.getStatistics().getAvg().toString(),
                                'Promedio\nsin aplazos',
                                0,
                                0),
                            StatisticsContainer(
                                _student
                                    .getStatistics()
                                    .getRealAvg()
                                    .toString(),
                                'Promedio\ncon aplazos',
                                0,
                                0),
                            StatisticsContainer(
                                _student.getStatistics().getPassed().toString(),
                                'Materias\nAprobadas',
                                0,
                                0),
                            StatisticsContainer(
                                _student.getStatistics().getLeft().toString(),
                                'Materias\nRestantes',
                                0,
                                0),
                            StatisticsContainer(
                                _student.getStatistics().getReg().toString(),
                                'Regulares\n',
                                0,
                                0),
                            StatisticsContainer(
                                _student.getStatistics().getPP().toString(),
                                'Promoción\nPráctica',
                                0,
                                0),
                            StatisticsContainer(
                                _student.getStatistics().getPT().toString(),
                                'Promoción\nTeórica',
                                0,
                                0),
                            StatisticsContainer(
                                _student.getStatistics().getAP().toString(),
                                'Aprobación\nDirecta',
                                0,
                                0),
                            //
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                    child: Text(
                      'Estadísticas por año:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 22,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 37.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.0),
                            color: const Color(0xfff7f7f7),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: _selectedYear,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedYear = newValue;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem<int>(
                                      value: 1,
                                      child: Text('Primer año'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 2,
                                      child: Text('Segundo año'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 3,
                                      child: Text('Tercer año'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 4,
                                      child: Text('Cuarto año'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 5,
                                      child: Text('Quinto año'),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.string(
                          '<svg viewBox="232.0 713.3 23.5 15.7" ><path transform="translate(227.5, 704.34)" d="M 13.63281440734863 24.65625381469727 L 18.85156440734863 24.65625381469727 L 18.85156440734863 22.04687881469727 L 13.63281440734863 22.04687881469727 L 13.63281440734863 24.65625381469727 Z M 4.5 9 L 4.5 11.60937404632568 L 27.984375 11.60937404632568 L 27.984375 9 L 4.5 9 Z M 8.4140625 18.1328125 L 24.07031440734863 18.1328125 L 24.07031440734863 15.52343845367432 L 8.4140625 15.52343845367432 L 8.4140625 18.1328125 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: getYearStatisticsData(_student, _selectedYear),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case (ConnectionState.waiting):
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                              child: Container(
                                  height: 130,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            );
                          default:
                            if (snapshot.data.isNotEmpty && snapshot.hasData) {
                              int percentageYear = 0;

                              if (snapshot.data[7] != 0)
                                percentageYear = ((snapshot.data[1] *
                                        100 /
                                        snapshot.data[7]))
                                    .round();

                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 18),
                                child: Container(
                                  height: 130,
                                  child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        StatisticsContainer(
                                            percentageYear.toString() + '%',
                                            'Año\ncompletado',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[0].toString(),
                                            'Promedio \nsin aplazos',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[8].toString(),
                                            'Promedio\ncon aplazos',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[1].toString(),
                                            'Materias\nAprobadas',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[2].toString(),
                                            'Materias\nRestantes',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[6].toString(),
                                            'Regulares\n',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[3].toString(),
                                            'Promoción\nPráctica',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[4].toString(),
                                            'Promoción\nTeórica',
                                            0,
                                            _selectedYear),
                                        StatisticsContainer(
                                            snapshot.data[5].toString(),
                                            'Aprobación\nDirecta',
                                            0,
                                            _selectedYear),
                                      ]),
                                ),
                              );
                            } else {
                              return Text('no data');
                            }
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                    child: Text(
                      'Estadísticas por Materia:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 22,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  FutureBuilder(
                      future: getSubjectsData(_student),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case (ConnectionState.waiting):
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                              child: Container(
                                  height: 130,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            );
                          default:
                            if (snapshot.data.isNotEmpty &&
                                snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data[1] != null &&
                                snapshot.data[0] != null)
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 18),
                                child: Container(
                                  height: 130,
                                  child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        StatisticsContainer(snapshot.data[0],
                                            'Mejor\nPromedio', 1, 10),
                                        StatisticsContainer(snapshot.data[1],
                                            'Peor\nPromedio', 1, 10),
                                      ]),
                                ),
                              );
                            else
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 18),
                                child: Container(
                                  height: 130,
                                  child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        StatisticsContainerBlank(
                                            'Mejor\nPromedio'),
                                        StatisticsContainerBlank(
                                            'Peor\nPromedio'),
                                      ]),
                                ),
                              );
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
