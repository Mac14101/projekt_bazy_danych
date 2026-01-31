-- Zmiana hasła użytkownika
UPDATE users SET password=:password WHERE uid=:uid;