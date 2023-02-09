import 'package:flutter/material.dart';


enum PetType {
  cat,
  dog
}

extension PetTypeExtension on PetType {
  String get size {
    switch (this) {
      case PetType.cat:
        return 'สุนัข';
      case PetType.dog:
        return 'แมว';
      default:
        return '';
    }
  }
}