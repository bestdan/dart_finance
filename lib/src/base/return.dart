import 'dart:core';
import 'dart:math';

const oneday = Duration(days: 1);

/// A core class for working with returns.
class Return {
  /// The numeric return, expressed as `0.05` for a 5\% return.
  final double nreturn;

  /// The period over which the return occured
  final Duration period;

  /// default `false`: the calculation method of the return.
  /// Logarithmic if true, else Arithmetic.
  final bool isLog;

  Return({
    required this.nreturn,
    this.isLog = false,
    this.period = oneday,
  });

  /// Rescales the return up or down over a given time period.
  ///
  /// Warning: scale up returns of less than a year can be very misleading.
  Return scale({required Duration newPeriod}) {
    final newReturn = (pow(1.0 + this.toArithmetic.nreturn,
                newPeriod.inSeconds / period.inSeconds)
            .toDouble()) -
        1.0;
    return Return(nreturn: newReturn, period: newPeriod, isLog: false);
  }

  /// converts arithmetic return to log
  Return get toLog {
    return this.isLog
        ? this
        : Return(nreturn: log(1.0 + this.nreturn), isLog: true);
  }

  /// converts log return to arithmetic
  Return get toArithmetic {
    return this.isLog
        ? Return(nreturn: exp(this.nreturn) - 1.0, isLog: false)
        : this;
  }
}
