import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileStat extends StatelessWidget {
  final double _percentage;
  final String _name;
  final String _image;

  ProfileStat(this._name, this._image, this._percentage);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 170,
          width: 170,
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
                    cornerStyle: CornerStyle.bothCurve,
                    //color: Colors.amber,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                        gradient: SweepGradient(
                            colors: [Colors.blue, Colors.blue[200]],
                            stops: <double>[0.25, 0.60]),
                        value: _percentage,
                        cornerStyle: CornerStyle.bothCurve,
                        width: 0.14,
                        sizeUnit: GaugeSizeUnit.factor,
                        enableAnimation: true,
                        animationDuration: 600,
                        animationType: AnimationType.linear),
                    MarkerPointer(
                        value: _percentage,
                        color: Colors.blue,
                        markerType: MarkerType.circle,
                        markerHeight: 12,
                        markerWidth: 12,
                        enableAnimation: true,
                        animationDuration: 600,
                        animationType: AnimationType.linear)
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        positionFactor: 0.08,
                        angle: 90,
                        widget: Container(
                          width: 96.0,
                          height: 96.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              color: Colors.white,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Text(
                _name,
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 25,
                  color: const Color(0xff7c7979),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Text(
              int.parse(_percentage.round().toString()).toString() + '%',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 45,
                color: const Color(0xff7c7979),
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            )
          ],
        )
      ],
    );
  }
}
