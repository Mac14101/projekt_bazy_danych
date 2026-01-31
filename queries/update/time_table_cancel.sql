-- Odwołanie zajęć
UPDATE time_table SET canceled=true WHERE ttid=:ttid;