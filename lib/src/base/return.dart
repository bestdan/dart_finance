import 'dart:core';

///
enum ReturnType { arithmetic, logarithmic }

class Return {
  final ReturnType returnType;
  final double nreturn;
  Return({required this.nreturn, this.returnType = ReturnType.arithmetic});

  /// convert from various formats
  /// 0.05, 5.0 1.05
  
}

