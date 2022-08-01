import 'package:finances/src/finance.dart';
import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  // const tradingYear = Duration(days: 252);

  group('returnStream', () {
    final baseReturnStream = ReturnStream.fromDoubles(
      [0.01, 0.0, 0.0],
      ReturnStreamType.incremental,
    );
    group('incremental to cumulativeReturn', () {
      test('initial period return returns correct number and period', () {
        expect(
            baseReturnStream.cumulativeReturn.nreturn, closeTo(0.01, 0.000001));
        expect(
          baseReturnStream.cumulativeReturn.period,
          Duration(days: 3),
        );
        // #TODO(dan): more
      });
      group('cumulativeReturnStream', () {
        final crsReturnStream = ReturnStream(
          [
            Return(nreturn: -0.01),
            Return(nreturn: 0.02, period: Duration(days: 5)),
            Return(nreturn: 0.02, period: Duration(days: 10)),
          ],
          ReturnStreamType.incremental,
        );
        final crs = crsReturnStream.cumulativeReturnStream;
        test('cumulates returns correctly', () {
          expect(crs.nreturns[0].nreturn, closeTo(0.99, 0.0001));
          expect(crs.nreturns[1].nreturn, closeTo(1.0098, 0.0001));
          expect(crs.nreturns[2].nreturn, closeTo(1.029996, 0.0000001));
        });
        test('cumulates time correctly', () {
          expect(crs.nreturns[0].period, Duration(days: 1));
          expect(crs.nreturns[1].period, Duration(days: 6));
          expect(crs.nreturns[2].period, Duration(days: 16));
        });
      });
    });
  });
}
