import 'package:finances/finance.dart';
import 'package:test/test.dart';

void main() {
  // const tradingYear = Duration(days: 252);
  final returnStreamOne = ReturnStream.fromDoubles(
    [0.01, 0.0, 0.0],
    ReturnStreamType.incremental,
  );
  final returnStreamVol = ReturnStream(
    [
      Return(nreturn: -0.01),
      Return(nreturn: 0.02, period: Duration(days: 5)),
      Return(nreturn: 0.02, period: Duration(days: 10)),
    ],
    ReturnStreamType.incremental,
  );
  final returnStreamVolCumulative = returnStreamVol.cumulativeReturnStream;

  group('ReturnStream: ', () {
    group('incremental to cumulativeReturn: ', () {
      test('initial period return returns correct number and period', () {
        expect(
            returnStreamOne.cumulativeReturn.nreturn, closeTo(0.01, 0.000001));
        expect(
          returnStreamOne.cumulativeReturn.period,
          Duration(days: 3),
        );
        expect(
          returnStreamVolCumulative.cumulativeReturn.nreturn,
          closeTo(1.029996, 0.00001),
        );
      });

      group('types: ', () {
        test('default is incremental type:', () {
          expect(returnStreamVol.type, ReturnStreamType.incremental);
        });
        test('cumulative conversion is cumulative type', () {
          expect(returnStreamVolCumulative.type, ReturnStreamType.cumulative);
        });
      });

      group('type conversion: ', () {
        test('cumulative to incremental: is incremental type', () {
          expect(returnStreamVolCumulative.incrementalReturnStream.type,
              ReturnStreamType.incremental);
        });
        test('incremental to cumulative: is cumulative type', () {
          expect(returnStreamVol.cumulativeReturnStream.type,
              ReturnStreamType.cumulative);
        });

        test('cumulates returns correctly', () {
          expect(returnStreamVolCumulative.nreturns[0].nreturn,
              closeTo(0.99, 0.0001));
          expect(returnStreamVolCumulative.nreturns[1].nreturn,
              closeTo(1.0098, 0.0001));
          expect(returnStreamVolCumulative.nreturns[2].nreturn,
              closeTo(1.029996, 0.0000001));
        });
        test('cumulates time correctly', () {
          expect(
              returnStreamVolCumulative.nreturns[0].period, Duration(days: 1));
          expect(
              returnStreamVolCumulative.nreturns[1].period, Duration(days: 6));
          expect(
              returnStreamVolCumulative.nreturns[2].period, Duration(days: 16));
        });
      });
      group('incrementalReturnStream: ', () {
        final irs = returnStreamVolCumulative.incrementalReturnStream;
        test('increments returns correctly', () {
          expect(irs.nreturns[0].nreturn,
              closeTo(returnStreamVol.nreturns[0].nreturn, 0.00001));
          expect(irs.nreturns[1].nreturn,
              closeTo(returnStreamVol.nreturns[1].nreturn, 0.00001));
          expect(irs.nreturns[2].nreturn,
              closeTo(returnStreamVol.nreturns[2].nreturn, 0.00001));
        });
        test('increments time correctly', () {
          expect(irs.nreturns[0].period, Duration(days: 1));
          expect(irs.nreturns[1].period, Duration(days: 5));
          expect(irs.nreturns[2].period, Duration(days: 10));
        });
      });
    });
  });
}
