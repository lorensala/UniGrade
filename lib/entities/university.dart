import 'package:mis_notas/entities/career.dart';

class University {
  final String _name;
  final String _shortName;
  final List<Career> _careers;

  University(this._careers, this._name, this._shortName);

  String getName() => _name;
  String getShortName() => _shortName;
  List<Career> getCareers() => _careers;
}
