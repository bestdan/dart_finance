import 'package:finances/src/base/project_value.dart';
import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  const periods = 70;

  final cashflows_one = List.generate(periods, (_) => 1.0);

  group('With no cashflow', () {
    test('cumulates correctly', () {
      final rstream_small =
          ReturnStream.fromDoubles(List.generate(periods, (_) => 0.0));
      expect(projectValueFinal(returns: rstream_small), 0.0);
    }); 
  });

  group('With constant cashflow', () {
    test('returns thing', () {
      final rstream_small =
          ReturnStream.fromDoubles(List.generate(periods, (_) => 0.0));

      expect(projectValueFinal(cashflows: cashflows_one, returns: rstream_small), periods);
    });
  });
}
