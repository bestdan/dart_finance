/// [Cashflows] represent a set of inflows and outflows from an investment.
class Cashflows {
  List<double>? cashflows;
  List<DateTime>? dates;

  Cashflows({required this.cashflows, this.dates});
}
