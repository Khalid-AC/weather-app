// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingsState({
    this.tempUnit = TempUnit.celsius,
  });

  @override
  // TODO: implement props
  List<Object> get props => [tempUnit];

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  factory TempSettingsState.initial() {
    return const TempSettingsState();
  }
  @override
  bool get stringify => true;
}

class TempSettingsProvider with ChangeNotifier {
  TempSettingsState _state = TempSettingsState.initial();
  TempSettingsState get state => _state;

  void toggleTempUnit() {
    _state = _state.copyWith(
        tempUnit: _state.tempUnit == TempUnit.celsius
            ? TempUnit.fahrenheit
            : TempUnit.celsius);

    print(_state);
    notifyListeners();
  }
}
