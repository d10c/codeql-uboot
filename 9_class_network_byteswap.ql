import cpp

class NetworkByteSwap extends Expr {
  NetworkByteSwap() {
    this =
      any(MacroInvocation mi | mi.getMacro().hasName(["ntohs", "ntohl", "ntohll"]) | mi.getExpr())
  }
}

from NetworkByteSwap n
select n, "Network byte swap"
