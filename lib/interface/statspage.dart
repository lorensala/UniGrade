import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SfCircularChart(
            //backgroundImage:AssetImage('assets/images/043-student.png') ,
            // Chart title
            title: ChartTitle(text: 'Tu Progreso'),
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries<_SalesData, String>>[
              RadialBarSeries<_SalesData, String>(
                  dataSource: <_SalesData>[
                    _SalesData('Jan', 35),
                    _SalesData('May', 40),
                    _SalesData('May', 40)
                  ],
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  cornerStyle: CornerStyle.bothCurve,

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: false))
            ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
