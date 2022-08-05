import 'dart:core';
import 'dart:math';

const oneday = Duration(days: 1);
const oneyear = Duration(days: 252);

/// A core class for working with returns.
class Return {
  /// The numeric return, expressed as `0.05` for a 5\% return.
  final double nreturn;

  /// The period over which the return occured. Defaults to one day, if not specified.
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
  /// Warning: scaling returns up can be misleading.
  Return scale({required Duration newPeriod}) {
    double periodRatio = newPeriod.inSeconds / period.inSeconds;

    if (periodRatio > 1.0) {
      print('Warning: scaling returns up can be misleading.');
    }

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

  Return get annualize {
    return scale(newPeriod: oneyear);
  }
}
