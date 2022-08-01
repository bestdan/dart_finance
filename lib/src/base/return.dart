import 'dart:core';
import 'dart:math';

const oneday = Duration(days: 1);

///
enum ReturnType { arithmetic, logarithmic }

/// A Return has the core primitives for working with returns.
///
/// [nreturn] is the numerical return, with a 5\% return input as 0.05.
/// [period] (default 1 day): the time period the [nreturn] occurs over.
/// [ReturnType] (default arithmetic): the calculation method of the return.
class Return {
  final double nreturn;
  final Duration period;
  final ReturnType returnType;

  Return({
    required this.nreturn,
    this.returnType = ReturnType.arithmetic,
    this.period = oneday,
  });

  Return scale({required Duration newPeriod}) {
    final newReturn =
        (pow(1.0 + this.nreturn, newPeriod.inSeconds / period.inSeconds)
                .toDouble()) -
            1.0;
    return Return(
        nreturn: newReturn,
        period: newPeriod,
        returnType: ReturnType.arithmetic);
  }
}
