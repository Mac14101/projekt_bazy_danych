INSERT INTO messages (snid, rcid, title, content, pmid) VALUES
(1, 4, 'Prośba o wyjaśnienie zadania', 'Dzień dobry, czy mogę prosić o dodatkowe wyjaśnienie zadania z matematyki?', NULL),
(4, 1, 'Wyjaśnienie zadania', 'Oczywiście. Jutro na lekcji omówimy to zadanie krok po kroku.', 1),
(2, 4, 'Nieobecność na lekcji', 'Dzień dobry, dziś nie mogłem uczestniczyć w zajęciach z powodu wizyty u lekarza.', NULL),
(4, 2, 'Usprawiedliwienie nieobecności', 'Dziękuję za informację. Proszę uzupełnić notatki z dzisiejszej lekcji.', 3),
(33, 59, 'Prośba o ocenę próbnego wypracowania', 'Czy mógłby Pan sprawdzić moje wypracowanie przed oddaniem finalnej wersji?', NULL),
(59, 33, 'Ocena wypracowania', 'Przejrzałem pracę. Wymaga drobnych poprawek stylistycznych, ale jest na dobrej drodze.', 5),
(60, 18, 'Problem z platformą edukacyjną', 'Nie mogę zalogować się do platformy. Czy to znany problem?', NULL),
(18, 60, 'Odpowiedź w sprawie platformy', 'Tak, trwają prace techniczne. Powinno działać po południu.', 7),
(46, 13, 'Prośba o dodatkowe materiały', 'Czy mogę otrzymać dodatkowe materiały do powtórki przed sprawdzianem?', NULL),
(13, 46, 'Materiały do powtórki', 'Wysłałem dodatkowe materiały w załączniku. Powodzenia w nauce!', 9);