import 'dart:core';
import 'dart:math';

///
enum ReturnType { arithmetic, logarithmic }

class Return {
  final ReturnType returnType;
  final double nreturn;
  Return({required this.nreturn, this.returnType = ReturnType.arithmetic});

  /// convert from various formats
  /// 0.05, 5.0 1.05
  
}

class ReturnStream {
  final List<Return> nreturns; 
  
  ReturnStream(this.nreturns); 

  double compound({required List<double> cashflows}) {
    return List<int>.generate(cashflows.length, (int index) => index)
        .map((int index) => cashflows[index] / pow(1 + nreturns[index].nreturn, index))
        .fold(0, (double p, double c) => p + c);
  }

}
