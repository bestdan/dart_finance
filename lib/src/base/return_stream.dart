import 'package:finances/src/base/return.dart';

enum ReturnStreamType { individual, cumulative }

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
    this.nreturns, {
    this.type = ReturnStreamType.individual,
  });

  factory ReturnStream.fromDoubles(List<double> dreturns) {
    final nreturns = dreturns.map((x) => Return(nreturn: x)).toList();
    return ReturnStream(nreturns);
  }

  Return get cumulativeReturn {
    switch (type) {
      case ReturnStreamType.cumulative:
        return nreturns.last;
      case ReturnStreamType.individual:
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
        return ReturnStream(nreturns, type: ReturnStreamType.cumulative);
      case ReturnStreamType.individual:
        {
          // #TODO: could be faster?
          var total = 0.0;
          var result = List<Return>.generate(
              nreturns.length, (int x) => Return(nreturn: x.toDouble()),
              growable: false);

          for (var i = 0; i < nreturns.length; i++) {
            total = total + nreturns[i].nreturn;
            result[i] = Return(nreturn: total);
          }
          return ReturnStream(result);
        }
    }
  }
}
