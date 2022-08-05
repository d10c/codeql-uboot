import cpp

from FunctionCall fc
where fc.getTarget().hasGlobalOrStdName("memcpy")
select fc
