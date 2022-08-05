import cpp

from Macro m
where m.getName().regexpMatch("ntohs|ntohl|ntohll")
select m
