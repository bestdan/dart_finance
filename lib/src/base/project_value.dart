import 'return_stream.dart';
import 'dart:math';

List<double> projectValue(List<double>? cashflow, ReturnStream returns) {
  return [0.0];
}

double projectValueFinal(
    {required ReturnStream returns, List<double>? cashflows}) {
  final hasCashflows = cashflows == null ? false : true;
  final cashflowsV = _genCashflowV(cashflows, returns);

  final finalValue = List<int>.generate(cashflowsV.length, (int index) => index)
      .map((int index) =>
          cashflowsV[index] / pow(1.0 + returns.nreturns[index].nreturn, index))
      .fold(0.0, (double p, double c) => p + c);

  return hasCashflows ? finalValue : (finalValue - 1.0);

  
}

// Generate one-time $1 inflow vector if no cashflow exists
List<double> _genCashflowV(List<double>? cashflows, ReturnStream returns) {
  final hasCashflows = cashflows == null ? false : true;
  if (hasCashflows) {
    return cashflows;
  } else {
    var baselineCashflow =
        (List<double>.generate(returns.nreturns.length, (x) => 0.0));
    baselineCashflow[1] = 1.0;
    return baselineCashflow;
  }
}
