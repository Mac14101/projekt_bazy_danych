-- Zmiana tematu i opisu lekcji
UPDATE lessons SET title=:title, description=:description WHERE lid=:lid;