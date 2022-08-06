import 'dart:math';

import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  const int tradingDays = 252;
  final ReturnZero = Return(
      nreturn: 0,
      returnPeriod: ReturnPeriod(tradingPeriod: Duration(days: 252)));
  group("Return: ", () {
    group('isLog functionality: ', () {
      double baseReturn = 2.40;
      final returnArith = Return(
          nreturn: baseReturn,
          returnPeriod: ReturnPeriod(tradingPeriod: Duration(days: 252)));
      final returnLog = Return(
          nreturn: 0.74,
          returnPeriod: ReturnPeriod(tradingPeriod: Duration(days: 252)),
          isLog: true);

      test('conversion to log works', (() {
        expect(returnArith.toLog.isLog, true);
        expect(returnArith.toLog.nreturn, log(baseReturn + 1.0));
      }));
      test('conversion to arithmetic works', (() {
        expect(returnLog.toArithmetic.isLog, false);
        expect(returnLog.toLog.nreturn, closeTo(0.74, 0.0001));
      }));
    });
    group("scale: ", () {
      test('zero returns does not scale', () {
        expect(ReturnZero.scale(newPeriod: Duration(days: 127)).nreturn, 0.0);
        expect(ReturnZero.scale(newPeriod: Duration(days: 500)).nreturn, 0.0);
      });

      test('postive returns scale', () {
        final baseReturn = Return(
            nreturn: 0.01,
            returnPeriod:
                ReturnPeriod(tradingPeriod: Duration(days: tradingDays)));
        expect(
          baseReturn.scale(newPeriod: Duration(days: 126)).nreturn,
          closeTo(0.00498756, 0.00001),
        );
        expect(
          baseReturn.scale(newPeriod: Duration(days: 504)).nreturn,
          closeTo(0.0201, 0.0000001),
        );
      });
      test('negative returns scale', () {
        final baseReturn = Return(
            nreturn: -0.01,
            returnPeriod:
                ReturnPeriod(tradingPeriod: Duration(days: tradingDays)));
        expect(
          baseReturn.scale(newPeriod: Duration(days: 126)).nreturn,
          closeTo(-0.00501256, 0.00001),
        );
        expect(
          baseReturn.scale(newPeriod: Duration(days: 504)).nreturn,
          closeTo(-0.0199, 0.0000001),
        );
      });
      test('convenience function annualize works', () {
        expect(
          Return(
                  nreturn: 0.27628156,
                  returnPeriod: ReturnPeriod(
                      tradingPeriod: Duration(days: tradingDays * 5)))
              .annualize
              .nreturn,
          closeTo(0.05, 0.00001),
        );
      });
    });
  });
}
