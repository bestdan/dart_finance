import 'package:finances/src/base/return.dart';

/// [ReturnStreamType] indicates whethere the return stream is `incremental` with
/// [Return]s in the `0.05` format and representing only their incremental effect
/// or `cumulative` in the `1.05` format, representing all cumulative returns or balances.
enum ReturnStreamType { incremental, cumulative }

/// [ReturnStream] is a vector of [Return]s which commong aggregating
/// operations such as compounding and averaging can be performed on.
///
/// Getter [cumulativeReturnStream] converts from `incremental` to `cumulative`.
/// Getter [incrementalReturnStream] converts from `cumulative` to `incremental`.
/// If you have a series of balances/values, you can convert them to `incremental` returns.
class ReturnStream {
  final List<Return> nreturns;
  final ReturnStreamType type;

  ReturnStream(
    this.nreturns,
    this.type,
  );

  factory ReturnStream.fromDoubles(
      List<double> dreturns, ReturnStreamType type) {
    final nreturns = dreturns.map((x) => Return(nreturn: x)).toList();
    return ReturnStream(nreturns, type);
  }

  Return get cumulativeReturn {
    switch (type) {
      case ReturnStreamType.cumulative:
        return nreturns.last;
      case ReturnStreamType.incremental:
        {
          final totalReturn = nreturns.fold(
                  1.0, (double p, Return c) => (p * (1 + c.nreturn))) -
              1.0;
          final totalPeriod = nreturns.fold(
              Duration(days: 0), (Duration p, Return c) => (p + c.period));
          return Return(nreturn: totalReturn, period: totalPeriod);
        }
    }
  }

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
            totalPeriod = totalPeriod + nreturns[i].period;
            result[i] = Return(nreturn: totalReturn, period: totalPeriod);
          }
          return ReturnStream(result, ReturnStreamType.cumulative);
        }
    }
  }

  ReturnStream get incrementalReturnStream {
    // #TODO: Needs to do duration as well
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
              thisPeriod = nreturns[i].period;
            } else {
              thisReturn =
                  (nreturns[i].nreturn / nreturns[(i - 1)].nreturn) - 1.0;
              thisPeriod = nreturns[i].period - nreturns[(i - 1)].period;
            }

            result[i] = Return(nreturn: thisReturn, period: thisPeriod);
          }
          return ReturnStream(result, ReturnStreamType.incremental);
        }
    }
  }
}
