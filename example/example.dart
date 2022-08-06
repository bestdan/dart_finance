import 'dart:math';
import 'package:finances/finance.dart';

void main() {
  // Return
  final yearReturn = Return(
      nreturn: 0.05,
      returnPeriod: ReturnPeriod(tradingPeriod: Duration(days: 252 * 3)));

  // Five year return, annualized
  print(yearReturn.annualize.nreturn);

  // A ReturnStream
  final rng = Random();
  final rstream = ReturnStream.fromDoubles(
    List.generate(48, (_) => (rng.nextDouble() - 0.4 / 5)),
    ReturnStreamType.incremental,
  );

  // Show cumulative return
  print(rstream.cumulativeReturn.nreturn);

  // Show last cumulative return in the stream
  print(rstream.cumulativeReturnStream.nreturns.last.nreturn);
}
