import 'package:finances/src/base/finance_constants.dart';
import 'package:finances/src/base/return_period.dart';
import 'package:test/test.dart';

void main() {
  group('ReturnPeriod', () {
    group('below one full week: ', () {
      final dateMon = DateTime(2022, 08, 08, 00, 00);
      final dateMon2 = DateTime(2022, 08, 15, 00, 00);
      final dateFri = DateTime(2022, 08, 12, 00, 00);
      final dateSat = DateTime(2022, 08, 13, 00, 00);
      final dateSun = DateTime(2022, 08, 14, 00, 00);

      test('normal week', () {
        expect(
          ReturnPeriod.fromDates(
            startDate: dateMon,
            endDate: dateFri,
          ).tradingPeriod,
          Duration(days: 4),
        );
      });
      test('weekends have no trading days', () {
        expect(
          ReturnPeriod.fromDates(
            startDate: dateMon,
            endDate: dateSat,
          ).tradingPeriod,
          Duration(days: 5),
        );
        expect(
          ReturnPeriod.fromDates(
            startDate: dateMon,
            endDate: dateSun,
          ).tradingPeriod,
          Duration(days: 5),
        );
        expect(
          ReturnPeriod.fromDates(
            startDate: dateMon,
            endDate: dateMon2,
          ).tradingPeriod,
          Duration(days: 5),
        );
      });
      test('weekends have no trading days', () {
        expect(
          ReturnPeriod.fromDates(
            startDate: dateSat,
            endDate: dateSun,
          ).tradingPeriod,
          Duration(days: 0),
        );
      });
    });
    group('more than one full week: ', () {
      final startDate = DateTime(2022, 08, 08, 00, 00); // Monday
      final endDate = DateTime(2022, 08, 15, 00, 00); // Friday
      final period = ReturnPeriod.fromDates(
        startDate: startDate,
        endDate: endDate,
      );
      test('weekends have no trading days', () {
        expect(
          period.tradingPeriod,
          Duration(days: 5),
        );
      });
      group('more than a year: ', () {
        final startDate = DateTime(2000, 01, 01);
        final endDate = DateTime(2005, 01, 01);
        final period = ReturnPeriod.fromDates(
          startDate: startDate,
          endDate: endDate,
        );
        test('constants and constructor give same results', () {
          expect(
            period.tradingPeriod,
            FiConstants.oneTradingYear.tradingPeriod * 5,
          );
        });
      });
    });
  });
}
