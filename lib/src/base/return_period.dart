import 'dart:core';
import 'package:finances/src/base/calc_trading_period.dart';

/// ReturnPeriods are a denomination format that allow for easy
/// conversion between [TradingPeriod]s and [CalendarPeriod]s.
///
///
class ReturnPeriod {
  final Duration tradingPeriod;

  /// When the period the return was generated begins
  final DateTime? startDate;

  /// When the period the return was generated ends. Note it's exclusive,
  /// so M-F is 4 days, M-S is 5 days.
  final DateTime? endDate;

  const ReturnPeriod(
      {required this.tradingPeriod, this.startDate, this.endDate});

  ReturnPeriod.fromDates({required this.startDate, required this.endDate})
      : tradingPeriod = calcTradingPeriod(startDate!, endDate!);

  Duration? get calendarPeriod {
    if (endDate == null || startDate == null) {
      //  TODO(dpe): is it possible to construct?
      return null;
    } else
      return endDate!.difference(startDate!);
  }
}
