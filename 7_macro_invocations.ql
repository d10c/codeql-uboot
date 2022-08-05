import cpp

from MacroInvocation mi
where mi.getMacro().hasName(["ntohs", "ntohl", "ntohll"])
select mi
