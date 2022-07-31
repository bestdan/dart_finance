import 'package:finances/src/base/return.dart';

/// [ReturnStream] is a vector of returns which commong aggregating
/// operations can be performed on.
///
/// [cashflows] is a list of cashflows concurrent with the returns,
/// assuming investment before the return occurs.
/// If no cashflows are supplied, pure cumulative returns are supplied.
class ReturnStream {
  final List<Return> nreturns;

  ReturnStream(this.nreturns);

  factory ReturnStream.fromDoubles(List<double> dreturns) {
    final nreturns = dreturns.map((x) => Return(nreturn: x)).toList();
    return ReturnStream(nreturns);
  }

}
