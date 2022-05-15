import 'package:flutter/material.dart';

class Error implements Exception{
  final String errorMessage;

  Error({@required this.errorMessage}){
    print(errorMessage);
  }

  @override
  String toString() {
    return errorMessage;
  }
}