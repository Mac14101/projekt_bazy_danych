-- Przeniesienie zajęć na inny dzień/godzinę
UPDATE time_table SET date=:date, start_time=:start_time, end_time=:end_time, moved=true WHERE ttid=:ttid;