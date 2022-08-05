/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
  NetworkByteSwap() {
    this =
      any(MacroInvocation mi | mi.getMacro().hasName(["ntohs", "ntohl", "ntohll"]) | mi.getExpr())
  }
}

class MemcpyCall extends FunctionCall {
  MemcpyCall() { this.getTarget().hasGlobalOrStdName("memcpy") }

  Expr getLengthArgument() { result = this.getArgument(2) }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "Config" }

  override predicate isSource(DataFlow::Node node) { node.asExpr() instanceof NetworkByteSwap }

  override predicate isSink(DataFlow::Node node) {
    node.asExpr() = any(MemcpyCall c).getLengthArgument()
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
