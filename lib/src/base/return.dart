import 'dart:core';
import 'dart:math';
import 'package:finances/src/base/finance_constants.dart';
import 'package:finances/src/base/return_period.dart';
import 'package:finances/src/base/calc_trading_period.dart';

/// A core class for working with returns.
class Return {
  /// The numeric return, expressed as `0.05` for a 5\% return.
  final double nreturn;

  /// The period over which the return occured. Defaults to one day, if not specified.
  final ReturnPeriod returnPeriod;

  /// default `false`: the calculation method of the return.
  /// Logarithmic if true, else Arithmetic.
  final bool isLog;

  Return({
    required this.nreturn,
    this.isLog = false,
    this.returnPeriod = FiConstants.oneTradingDay,
  });

  Return.fromDates(
      {required this.nreturn,
      this.isLog = false,
      required DateTime startDate,
      required DateTime endDate})
      : returnPeriod =
            ReturnPeriod(tradingPeriod: calcTradingPeriod(startDate, endDate));

  /// Rescales the return up or down over a given time period.
  ///
  /// Warning: scaling returns up can be misleading.
  Return scale({required Duration newPeriod}) {
    double periodRatio =
        newPeriod.inSeconds / returnPeriod.tradingPeriod.inSeconds;

    if (periodRatio > 1.0) {
      print('Warning: scaling returns up can be misleading.');
    }

    final newReturn = (pow(1.0 + this.toArithmetic.nreturn,
                newPeriod.inSeconds / returnPeriod.tradingPeriod.inSeconds)
            .toDouble()) -
        1.0;
    return Return(
        nreturn: newReturn,
        returnPeriod: ReturnPeriod(tradingPeriod: newPeriod),
        isLog: false);
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
    return scale(newPeriod: FiConstants.oneTradingYear.tradingPeriod);
  }
}
