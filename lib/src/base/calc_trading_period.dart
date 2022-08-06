import 'dart:core';

Duration calcTradingPeriod(DateTime startDate, DateTime endDate) {
  // for each full week, subtract 2.
  // for the remainder, find # of weekend days

  int days = endDate.difference(startDate).inDays;
  //int numWeeks = (days / 7).floor();
  int tradingWeekDays = days - 2 * ((days + startDate.weekday) ~/ 7);
  final totalDays = tradingWeekDays +
      (startDate.weekday == 7 ? 1 : 0) +
      (endDate.weekday == 7 ? 1 : 0);

  //adjust for starting and ending on a Sunday:
  return Duration(days: totalDays);
}
