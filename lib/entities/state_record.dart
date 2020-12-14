import 'package:mis_notas/entities/state.dart';

class StateRecord {
  final State _state;
  final DateTime _started;

  State getState() => _state;
  DateTime getStartedDateTime() => _started;

  StateRecord(this._state, this._started);
}
