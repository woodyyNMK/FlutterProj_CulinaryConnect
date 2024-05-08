import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String _value) {
    _selectedCategory = _value;
  }

  bool _saved = false;
  bool get saved => _saved;
  set saved(bool _value) {
    _saved = _value;
  }
}
