import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  // const tradingYear = Duration(days: 252);

  group('returnStream', () {
    group('cumulativeReturn', () {
      test('initial period return returns correct number and period', () {
        final returnStream = ReturnStream([
          Return(nreturn: 0.01),
          Return(nreturn: 0.0),
          Return(nreturn: 0.0),
        ]);
        expect(returnStream.cumulativeReturn.nreturn, closeTo(0.01, 0.000001));
        expect(
          returnStream.cumulativeReturn.period,
          Duration(days: 3),
        );
        // #TODO(dan): more
      });
    });
  });
}
