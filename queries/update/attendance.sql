-- Zmiana statusu obecności ucznia
UPDATE attendance SET status=:status WHERE lid=:lid AND sid=:sid;