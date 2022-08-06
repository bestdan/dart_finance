import 'package:finances/src/base/return_period.dart';

class FiConstants {
  /// A constant of one trading day
  static const oneTradingDay = ReturnPeriod(tradingPeriod: Duration(days: 1));

  /// A constant of 252 days for the American trading year
  static const oneTradingYear =
      ReturnPeriod(tradingPeriod: Duration(days: 252));
}
