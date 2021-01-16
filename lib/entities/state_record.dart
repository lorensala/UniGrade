import 'package:mis_notas/entities/state.dart';

class StateRecord {
  final StateSubject _state;
  final DateTime _started;

  StateSubject getState() => _state;
  DateTime getStartedDateTime() => _started;

  StateRecord(this._state, this._started);
}
