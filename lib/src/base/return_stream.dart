import 'package:finances/src/base/return.dart';
import 'package:finances/src/base/return_period.dart';

/// Indicates whether a [ReturnStream] is `incremental` or `cumulative`.
///
/// `incremental` streams have a `0.05` format and representing only their incremental effect
/// `cumulative` streams have a `1.05` format, representing cumulative returns in sequence.
enum ReturnStreamType { incremental, cumulative }

/// A vector of [Return]s enabling common aggregating operations such as compounding and averaging.
class ReturnStream {
  final List<Return> nreturns;
  final ReturnStreamType type;

  ReturnStream(
    this.nreturns,
    this.type,
  );

  /// A factory constructor to assume daily returns from List<double>.
  factory ReturnStream.fromDoubles(
      List<double> dreturns, ReturnStreamType type) {
    final nreturns = dreturns.map((x) => Return(nreturn: x)).toList();
    return ReturnStream(nreturns, type);
  }

  /// calculates the final cumulative return of the stream
  Return get cumulativeReturn {
    switch (type) {
      case ReturnStreamType.cumulative:
        return nreturns.last;
      case ReturnStreamType.incremental:
        {
          final totalReturn = nreturns.fold(
                  1.0, (double p, Return c) => (p * (1 + c.nreturn))) -
              1.0;
          final totalPeriod = nreturns.fold(Duration(days: 0),
              (Duration p, Return c) => (p + c.returnPeriod.tradingPeriod));
          return Return(
              nreturn: totalReturn,
              returnPeriod: ReturnPeriod(tradingPeriod: totalPeriod));
        }
    }
  }

  /// converts from `incremental` to `cumulative`.
  ReturnStream get cumulativeReturnStream {
    switch (type) {
      case ReturnStreamType.cumulative:
        return this;
      case ReturnStreamType.incremental:
        {
          // #TODO: could be faster?
          var totalReturn = 1.0;
          var totalPeriod = Duration(days: 0);
          var result = List<Return>.generate(
              nreturns.length, (int x) => Return(nreturn: x.toDouble()),
              growable: false);

          for (var i = 0; i < nreturns.length; i++) {
            totalReturn = (totalReturn * (1.0 + nreturns[i].nreturn));
            totalPeriod = totalPeriod + nreturns[i].returnPeriod.tradingPeriod;
            result[i] = Return(
                nreturn: totalReturn,
                returnPeriod: ReturnPeriod(tradingPeriod: totalPeriod));
          }
          return ReturnStream(result, ReturnStreamType.cumulative);
        }
    }
  }

  /// converts from `cumulative` to `incremental`.
  ///
  /// Useful if you have a series of balances/values too.
  ReturnStream get incrementalReturnStream {
    switch (type) {
      case ReturnStreamType.incremental:
        return this;
      case ReturnStreamType.cumulative:
        {
          // #TODO: could be faster?
          var thisReturn = 0.0;
          var thisPeriod = Duration.zero;
          var result = List<Return>.generate(
              nreturns.length, (int x) => Return(nreturn: x.toDouble()),
              growable: false);

          for (var i = 0; i < nreturns.length; i++) {
            if (i == 0) {
              thisReturn = nreturns[i].nreturn - 1.0;
              thisPeriod = nreturns[i].returnPeriod.tradingPeriod;
            } else {
              thisReturn =
                  (nreturns[i].nreturn / nreturns[(i - 1)].nreturn) - 1.0;
              thisPeriod = nreturns[i].returnPeriod.tradingPeriod -
                  nreturns[(i - 1)].returnPeriod.tradingPeriod;
            }

            result[i] = Return(
                nreturn: thisReturn,
                returnPeriod: ReturnPeriod(tradingPeriod: thisPeriod));
          }
          return ReturnStream(result, ReturnStreamType.incremental);
        }
    }
  }
}
