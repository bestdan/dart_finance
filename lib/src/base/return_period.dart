import 'dart:core';
import 'dart:math';

/// ReturnPeriods are a denomination format that allow for easy
/// conversion between [TradingPeriod]s and [CalendarPeriod]s.
///
///
class ReturnPeriod {
  /// When the period the return was generated begins
  final DateTime startDate;

  /// When the period the return was generated ends
  final DateTime endDate;

  ReturnPeriod({required this.startDate, required this.endDate});

  Duration get period {
    return endDate.difference(startDate);
  }
}
