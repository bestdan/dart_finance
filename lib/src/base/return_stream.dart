import 'package:finances/src/base/return.dart';

enum ReturnStreamType { incremental, cumulative }

/// [ReturnStream] is a vector of returns which commong aggregating
/// operations can be performed on.
///
/// [cashflows] is a list of cashflows concurrent with the returns,
/// assuming investment before the return occurs.
/// If no cashflows are supplied, pure cumulative returns are supplied.
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
    // #TODO: Needs to do duration as well
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
          var totalReturn = 0.0;
          var totalPeriod = Duration(days: 0);
          var result = List<Return>.generate(
              nreturns.length, (int x) => Return(nreturn: x.toDouble()),
              growable: false);

          for (var i = 0; i < nreturns.length; i++) {
            totalReturn = nreturns[i].nreturn - totalReturn;
            totalPeriod = nreturns[i].period - totalPeriod;
            result[i] = Return(nreturn: totalReturn, period: totalPeriod);
          }
          return ReturnStream(result, ReturnStreamType.incremental);
        }
    }
  }
}
