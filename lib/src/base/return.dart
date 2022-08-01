import 'dart:core';
import 'dart:math';

const oneday = Duration(days: 1);

///
enum ReturnType { arithmetic, logarithmic }

/// A Return has the core primitives for working with returns.
///
/// [nreturn] is the numerical return, with a 5\% return input as `0.05`.
/// [period] (default `1 day`): the time period the [nreturn] occurs over.
/// [isLog] (default `false`): the calculation method of the return.
/// Logarithmic if true, else Arithmetic.
class Return {
  final double nreturn;
  final Duration period;
  final bool isLog;

  Return({
    required this.nreturn,
    this.isLog = false,
    this.period = oneday,
  });

  Return scale({required Duration newPeriod}) {
    final newReturn = (pow(1.0 + this.toArithmetic.nreturn,
                newPeriod.inSeconds / period.inSeconds)
            .toDouble()) -
        1.0;
    return Return(nreturn: newReturn, period: newPeriod, isLog: false);
  }

  Return get toLog {
    return this.isLog
        ? this
        : Return(nreturn: log(1.0 + this.nreturn), isLog: true);
  }

  Return get toArithmetic {
    return this.isLog
        ? Return(nreturn: exp(this.nreturn) - 1.0, isLog: false)
        : this;
  }
}
