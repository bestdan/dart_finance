import 'return_stream.dart';
import 'dart:math';

List<double> cumulateValue(List<double> cashflows, ReturnStream returns) {
  // What to do if returns/dates don't overlap perfectly?
  /*
  final finalValue = List<int>.generate(cashflows.length, (int index) => index)
      .map((int index) =>
          cashflows[index] / pow(1.0 + returns.nreturns[index].nreturn, index))
      .fold(0.0, (double p, double c) => p + c);
  return finalValue;
  */
  return [1.0, 2.0];
}

double cumulateValueFinal(
    {required ReturnStream returns, required List<double> cashflows}) {
  final finalValue = List<int>.generate(cashflows.length, (int index) => index)
      .map((int index) =>
          cashflows[index] / pow(1.0 + returns.nreturns[index].nreturn, index))
      .fold(0.0, (double p, double c) => p + c);

  return finalValue;
}

/*
// Generate one-time $1 inflow vector if no cashflow exists
List<double> _dollarCashflowV(List<double>? cashflows, ReturnStream returns) {
  var baselineCashflow =
      (List<double>.generate(returns.nreturns.length, (x) => 0.0));
  baselineCashflow[1] = 1.0;
  return baselineCashflow;
}
*/
