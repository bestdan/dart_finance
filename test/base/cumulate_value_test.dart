import 'package:finances/src/base/cumulate_value.dart';
import 'package:finances/src/finance.dart';
import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  const periods = 70;

  final cashflows_one = List.generate(periods, (_) => 1.0);

  group('With no cashflow', () {
    test('cumulates correctly', () {
      final rstream_small = ReturnStream.fromDoubles(
          List.generate(periods, (_) => 0.0), ReturnStreamType.incremental);
      expect(
          cumulateValueFinal(cashflows: cashflows_one, returns: rstream_small),
          periods);
    });
  });

  group('With constant cashflow', () {
    test('returns thing', () {
      final rstream_small = ReturnStream.fromDoubles(
          List.generate(periods, (_) => 0.0), ReturnStreamType.incremental);

      expect(
          cumulateValueFinal(cashflows: cashflows_one, returns: rstream_small),
          periods);
    });
  });
}
