import 'dart:math';
import 'package:finances/finance.dart';

void main() {
  final rng = Random();
  final ReturnStream rstream = ReturnStream(
      List.generate(48, (_) => rng.nextDouble() - 0.4).cast<Return>());
  final cashflows = List.generate(48, (_) => 100.0);
  final finalValue = rstream.compound(cashflows: cashflows);
  print(finalValue); 
}
