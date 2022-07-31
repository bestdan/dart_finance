import 'dart:math';
import 'return_stream.dart'; 
import 'return.dart'; 

// Produces a final total cumulative [Return] from a series of returns. 
Return cumulateReturn(ReturnStream returns) {
  returns.map((int index) => pow(1.0 + returns.nreturns[index].nreturn, index))
      .fold(0.0, (double p, double c) => p + c);
      // Assign time period etc. 
}

// Produces a final total cumulative [Return] from a series of returns. 
// This includes cumulating the [Period] over which the return was generated. 
ReturnStream cumulateReturnStream(ReturnStream returns) {
  returns.map((int index) => pow(1.0 + returns.nreturns[index].nreturn, index))
      .fold(0.0, (double p, double c) => p + c);
      // Assign time period etc. 
}
