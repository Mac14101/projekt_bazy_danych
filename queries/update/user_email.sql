-- Zmiana adresu e-mail użytkownika
UPDATE users SET email=:email WHERE uid=:uid;