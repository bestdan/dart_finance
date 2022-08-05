import 'dart:core';
import 'dart:math';

/// ReturnPeriods are a denomination format that allow for easy
/// conversion between [TradingPeriod]s and [CalendarPeriod]s.
///
///
class ReturnPeriod {
  /// When the period the return was generated begins
  final DateTime startDate;

  /// When the period the return was generated ends. Note it's exclusive,
  /// so M-F is 4 days, M-S is 5 days.
  final DateTime endDate;

  ReturnPeriod({required this.startDate, required this.endDate})
      : assert(endDate.difference(startDate) > Duration(seconds: 0));

  Duration get calendarPeriod {
    return endDate.difference(startDate);
  }

  Duration get tradingPeriod {
    // for each full week, subtract 2.
    // for the remainder, find # of weekend days

    int days = calendarPeriod.inDays;
    //int numWeeks = (days / 7).floor();
    int tradingWeekDays = days - 2 * ((days + startDate.weekday) ~/ 7);
    final totalDays = tradingWeekDays +
        (startDate.weekday == 7 ? 1 : 0) +
        (endDate.weekday == 7 ? 1 : 0);

    //adjust for starting and ending on a Sunday:
    return Duration(days: totalDays);
  }
}
