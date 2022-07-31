import 'dart:math';
import 'package:finances/finance.dart';
import 'package:finances/src/base/project_value.dart';

void main() {
  final cashflows = List.generate(48, (_) => 1.0);

  final rng = Random();
  final rstream = ReturnStream.fromDoubles(
      List.generate(48, (_) => (rng.nextDouble() - 0.4 / 5)));
  
  final finalValue = projectValueFinal(cashflows: cashflows, returns: rstream);
  print(finalValue); 


  final rstream_small = ReturnStream.fromDoubles(
      List.generate(48, (_) => 0.01));
  
  print(rstream_small.cumulate(cashflows: cashflows)); 
}
