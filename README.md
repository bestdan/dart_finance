# Finances

[![experimental](http://badges.github.io/stability-badges/dist/experimental.svg)](http://github.com/badges/stability-badges)
![test status](https://github.com/bestdan/dart_finance/actions/workflows/ci.yaml/badge.svg)

An opinionated, strongly-typed package for common financial types and tasks. 

* Basic yet strict classes like `Returns` which make use of period and calcuation logic. 
* Commmon procedures such as compounding, interest calculation etc. 
* Projection of balances and cashflows
* Ex-post calculation of performance such as IRR and Sharpe ratio

## Example
See `example/example.dart` for some running examples. 

```dart
import 'dart:math';
import 'package:finances/finance.dart';
import 'package:finances/src/base/cumulate_value.dart';

void main() {
  // Returns
  // Daily 1% return scaled to annual
  final dailyReturn = Return(nreturn: 0.01);
  print(dailyReturn.scale(newPeriod: Duration(days: 252)));

  // Annual return, scaled to daily
  final annualReturn = Return(nreturn: 0.05, period: Duration(days: 252));
  print(annualReturn.scale(newPeriod: Duration(days: 1)));

  // ReturnStream
  final rng = Random();
  final rstream = ReturnStream.fromDoubles(
      List.generate(48, (_) => (rng.nextDouble() - 0.4 / 5)));

  // Show cumulative return
  print(rstream.cumulativeReturn);

  // Cumulative value
  final cashflows = List.generate(48, (_) => 1.0);
  final finalValue = cumulateValueFinal(cashflows: cashflows, returns: rstream);
  print(finalValue);
}
```
