# Finances

Provides a one-stop shop for common financial types and tasks. 

* Primitive types like returns, balances.
* Commmon procedures such as compounding, interest calculation etc. 
* Projection of balances and cashflows
* Ex-post calculation of performance such as IRR and Sharpe ratio

## Example
See `example/example.dart`

```dart
import 'dart:math';
import 'package:finances/finance.dart';

void main() {
  final rng = Random();
  final rstream = ReturnStream.fromDoubles(
      List.generate(48, (_) => (rng.nextDouble() - 0.4 / 5)));
  final cashflows = List.generate(48, (_) => 1.0);
  final finalValue = rstream.compound(cashflows: cashflows);
  print(rstream); 
  print(finalValue); 
}
```