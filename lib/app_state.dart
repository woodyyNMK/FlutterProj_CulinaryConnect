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

  List<String> _TempIngredientAppState = [];
  List<String> get TempIngredientAppState => _TempIngredientAppState;
  set TempIngredientAppState(List<String> _value) {
    _TempIngredientAppState = _value;
  }

  void addToTempIngredientAppState(String _value) {
    _TempIngredientAppState.add(_value);
  }

  void removeFromTempIngredientAppState(String _value) {
    _TempIngredientAppState.remove(_value);
  }

  void removeAtIndexFromTempIngredientAppState(int _index) {
    _TempIngredientAppState.removeAt(_index);
  }

  void updateTempIngredientAppStateAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _TempIngredientAppState[_index] = updateFn(_TempIngredientAppState[_index]);
  }

  void insertAtIndexInTempIngredientAppState(int _index, String _value) {
    _TempIngredientAppState.insert(_index, _value);
  }

  List<String> _TempInstructionAppState = [];
  List<String> get TempInstructionAppState => _TempInstructionAppState;
  set TempInstructionAppState(List<String> _value) {
    _TempInstructionAppState = _value;
  }

  void addToTempInstructionAppState(String _value) {
    _TempInstructionAppState.add(_value);
  }

  void removeFromTempInstructionAppState(String _value) {
    _TempInstructionAppState.remove(_value);
  }

  void removeAtIndexFromTempInstructionAppState(int _index) {
    _TempInstructionAppState.removeAt(_index);
  }

  void updateTempInstructionAppStateAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _TempInstructionAppState[_index] =
        updateFn(_TempInstructionAppState[_index]);
  }

  void insertAtIndexInTempInstructionAppState(int _index, String _value) {
    _TempInstructionAppState.insert(_index, _value);
  }

  bool _ASIAN = false;
  bool get ASIAN => _ASIAN;
  set ASIAN(bool _value) {
    _ASIAN = _value;
  }

  bool _ITALIAN = false;
  bool get ITALIAN => _ITALIAN;
  set ITALIAN(bool _value) {
    _ITALIAN = _value;
  }

  bool _WESTERN = false;
  bool get WESTERN => _WESTERN;
  set WESTERN(bool _value) {
    _WESTERN = _value;
  }

  bool _EUROPEAN = false;
  bool get EUROPEAN => _EUROPEAN;
  set EUROPEAN(bool _value) {
    _EUROPEAN = _value;
  }

  bool _SOUP = false;
  bool get SOUP => _SOUP;
  set SOUP(bool _value) {
    _SOUP = _value;
  }

  bool _DESSERTS = false;
  bool get DESSERTS => _DESSERTS;
  set DESSERTS(bool _value) {
    _DESSERTS = _value;
  }

  List<String> _TempImgAppState = [];
  List<String> get TempImgAppState => _TempImgAppState;
  set TempImgAppState(List<String> _value) {
    _TempImgAppState = _value;
  }

  void addToTempImgAppState(String _value) {
    _TempImgAppState.add(_value);
  }

  void removeFromTempImgAppState(String _value) {
    _TempImgAppState.remove(_value);
  }

  void removeAtIndexFromTempImgAppState(int _index) {
    _TempImgAppState.removeAt(_index);
  }

  void updateTempImgAppStateAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _TempImgAppState[_index] = updateFn(_TempImgAppState[_index]);
  }

  void insertAtIndexInTempImgAppState(int _index, String _value) {
    _TempImgAppState.insert(_index, _value);
  }

  String _ProfileImg = '';
  String get ProfileImg => _ProfileImg;
  set ProfileImg(String _value) {
    _ProfileImg = _value;
  }
}
