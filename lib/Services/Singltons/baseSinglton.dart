import 'dart:developer';

import 'package:flutter/cupertino.dart';

abstract class ExampleStateBase {
  @protected
  String intitialStringValue;
  @protected
  String currentStringValue;
  String get currentText => currentStringValue;
  void setStateText(String newText) {
    currentStringValue = newText;
  }

  void reset() {
    currentStringValue = intitialStringValue;
  }
}

class SingeltonExampleState extends ExampleStateBase {
  static final SingeltonExampleState _instance =
      SingeltonExampleState._internal();
  factory SingeltonExampleState() {
    //Factory Constructors implements a constructor that doesn't always create an instance of it's class.
    //returns the existing one if it is already intiated .
    return _instance;
  }
  SingeltonExampleState._internal() {
    intitialStringValue = "Example State instance is created";
    currentStringValue = intitialStringValue;
    log(currentStringValue);
  }
}

class ExampleStateWithoutSingleton extends ExampleStateBase {
  ExampleStateWithoutSingleton() {
    intitialStringValue = "Example State with out singleton been created";
    currentStringValue = intitialStringValue;
    log(currentStringValue);
  }
}
