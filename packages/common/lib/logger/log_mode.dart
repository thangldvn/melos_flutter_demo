import 'package:flutter/material.dart';

class LogModeValue {
  List<LogMode> logModeList = [];
}

class LogMode {

  LogMode({this.logMessage, this.level, this.time, this.fileName});
  String? logMessage;
  int? level;
  String? time;
  String? fileName;
}

class LogValueNotifier extends ValueNotifier<LogModeValue> {

  LogValueNotifier() : super(LogModeValue());
  bool _isDispoosed = false;

  void addLog(LogMode mode) {
    value.logModeList.add(mode);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _isDispoosed = true;
  }

  @override
  void notifyListeners() {
    if (!_isDispoosed) {
      super.notifyListeners();
    }
  }
}
