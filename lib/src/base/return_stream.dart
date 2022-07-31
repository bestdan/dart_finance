import 'package:finances/src/base/return.dart'; 
import 'dart:math'; 

/// [ReturnStream] is a vector of returns which commong aggregating
/// operations can be performed on.
/// 
/// [cashflows] is a list of cashflows concurrent with the returns, 
/// assuming investment before the return occurs. 
/// If no cashflows are supplied, pure cumulative returns are supplied. 
class ReturnStream {
  final List<Return> nreturns; 
  
  ReturnStream(this.nreturns); 

  num compound({List<double>? cashflows}) {
    final hasCashflows = cashflows ==  null ? true : false; 
    
    // If no cashflows, generate Vector to fill in with one-time $1 inflow
    final cashflowsV = cashflows ?? List<double>.generate(nreturns.length, (x) => 1); 

    final finalValue = List<int>.generate(cashflowsV.length, (int index) => index)
        .map((int index) => cashflowsV[index] / pow(1.0 + nreturns[index].nreturn, index))
        .fold(0.0, (num p, num c) => p + c);
    
    return hasCashflows ? finalValue : (finalValue - 1.0); 
  }

}
