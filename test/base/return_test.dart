import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  const int tradingDays = 252;
  final ReturnZero = Return(nreturn: 0, period: Duration(days: 252));
  group("Return", () {
    group("scale", () {
      test('Zero returns', () {
        expect(ReturnZero.scale(newPeriod: Duration(days: 127)).nreturn, 0.0);
        expect(ReturnZero.scale(newPeriod: Duration(days: 500)).nreturn, 0.0);
      });

      test('postive returns', () {
        final baseReturn =
            Return(nreturn: 0.01, period: Duration(days: tradingDays));
        expect(
          baseReturn.scale(newPeriod: Duration(days: 126)).nreturn,
          closeTo(0.00498756, 0.00001),
        );
        expect(
          baseReturn.scale(newPeriod: Duration(days: 504)).nreturn,
          closeTo(0.0201, 0.0000001),
        );
      });
    });
  });
}
