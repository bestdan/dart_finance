import 'package:test/test.dart';
import 'package:finances/finance.dart';

void main() {
  const periods = 70;

  final cashflows_one = List.generate(periods, (_) => 1.0);

  group('With no cashflow', () {
    test('cumulates correctly', () {
      expect(cashflows_one.length, periods); 
      // #TODO(dan): more
    });
  });

  group('With constant cashflow', () {
    test('returns thing', () {
      expect(cashflows_one.length, periods); 
      // #TODO(dan): more
    });
  });
}
