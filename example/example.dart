import 'dart:math';
import 'package:finances/finance.dart';

void main() {
  final rng = Random();
  final rstream = ReturnStream(
      List.generate(48, (_) => (rng.nextDouble() - 0.4 / 5)).map((x) => Return(nreturn: x)).toList());
  final cashflows = List.generate(48, (_) => 1.0);
  final finalValue = rstream.compound(cashflows: cashflows);
  print(rstream); 
  print(finalValue); 
}
