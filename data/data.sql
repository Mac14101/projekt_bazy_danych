-- Wstawianie przykładowych danych do bazy danych

-- Tabela users
INSERT INTO users (email, name, surname, password, role) VALUES
('anna.kowalska@example.com', 'Anna', 'Kowalska', 'Anna1234', 'student'),
('jan.nowak@example.com', 'Jan', 'Nowak', 'Nowak!2024', 'admin'),
('maria.wisniewska@example.com', 'Maria', 'Wiśniewska', 'MariaPass', 'student'),
('piotr.zielinski@example.com', 'Piotr', 'Zieliński', 'Zielinski1', 'teacher'),
('katarzyna.wojcik@example.com', 'Katarzyna', 'Wójcik', 'KasiaWojcik', 'student'),
('tomasz.krawczyk@example.com', 'Tomasz', 'Krawczyk', 'TomekKraw', 'student'),
('magdalena.kaczmarek@example.com', 'Magdalena', 'Kaczmarek', 'Magda2024', 'teacher'),
('pawel.krol@example.com', 'Paweł', 'Król', 'PawelKrol', 'student'),
('agnieszka.lewandowska@example.com', 'Agnieszka', 'Lewandowska', 'AgaLew55', 'student'),
('michal.wozniak@example.com', 'Michał', 'Woźniak', 'WozniakAdmin', 'admin'),
('joanna.dabrowska@example.com', 'Joanna', 'Dąbrowska', 'JoannaD12', 'student'),
('adam.kaminski@example.com', 'Adam', 'Kamiński', 'AdamKam1', 'student'),
('monika.zajac@example.com', 'Monika', 'Zając', 'MonikaZaj', 'teacher'),
('krzysztof.mazur@example.com', 'Krzysztof', 'Mazur', 'MazurKrzys', 'student'),
('aleksandra.konieczna@example.com', 'Aleksandra', 'Konieczna', 'OlaKoniec', 'student'),
('robert.olszewski@example.com', 'Robert', 'Olszewski', 'Robert123', 'student'),
('ewelina.sikora@example.com', 'Ewelina', 'Sikora', 'EwelinaS!', 'student'),
('dariusz.walczak@example.com', 'Dariusz', 'Walczak', 'WalczakT', 'teacher'),
('patrycja.rutkowska@example.com', 'Patrycja', 'Rutkowska', 'PatrycjaR', 'student'),
('bartosz.stepien@example.com', 'Bartosz', 'Stępień', 'Bartosz99', 'student'),
('karolina.michalska@example.com', 'Karolina', 'Michalska', 'KarolinaM', 'student'),
('grzegorz.adamczyk@example.com', 'Grzegorz', 'Adamczyk', 'AdamczykA', 'admin'),
('justyna.pawlak@example.com', 'Justyna', 'Pawlak', 'JustynaP', 'student'),
('sebastian.gorski@example.com', 'Sebastian', 'Górski', 'SebGorski', 'student'),
('natalia.sawicka@example.com', 'Natalia', 'Sawicka', 'Natalia12', 'student'),
('wojciech.krupa@example.com', 'Wojciech', 'Krupa', 'KrupaTeach', 'teacher'),
('paulina.jaworska@example.com', 'Paulina', 'Jaworska', 'PaulinaJ', 'student'),
('lukasz.mroz@example.com', 'Łukasz', 'Mróz', 'LukaszMroz', 'student'),
('dorota.urbanska@example.com', 'Dorota', 'Urbańska', 'DorotaU', 'student'),
('mateusz.szymanski@example.com', 'Mateusz', 'Szymański', 'MateuszSz', 'student'),
('marcin.bednarek@example.com', 'Marcin', 'Bednarek', 'MarcinB1', 'student'),
('izabela.maj@example.com', 'Izabela', 'Maj', 'IzabelaMaj', 'student'),
('damian.wojcicki@example.com', 'Damian', 'Wójcicki', 'DamianWoj', 'teacher'),
('beata.klos@example.com', 'Beata', 'Kloś', 'BeataKlos', 'student'),
('andrzej.roman@example.com', 'Andrzej', 'Roman', 'AndrzejR', 'student'),
('olga.kurek@example.com', 'Olga', 'Kurek', 'OlgaKurek', 'student'),
('patryk.baran@example.com', 'Patryk', 'Baran', 'PatrykBar', 'student'),
('renata.kasprzak@example.com', 'Renata', 'Kasprzak', 'RenataK!', 'student'),
('szymon.wojtowicz@example.com', 'Szymon', 'Wójtowicz', 'SzymonWoj', 'student'),
('alina.rybak@example.com', 'Alina', 'Rybak', 'AlinaRyb', 'teacher'),
('krystian.olek@example.com', 'Krystian', 'Olek', 'KrystianO', 'student'),
('marta.bogdan@example.com', 'Marta', 'Bogdan', 'MartaBog', 'student'),
('piotr.klimek@example.com', 'Piotr', 'Klimek', 'PiotrKlim', 'student'),
('ewelina.kozak@example.com', 'Ewelina', 'Kozak', 'EwelinaK', 'student'),
('dawid.plesniak@example.com', 'Dawid', 'Pleśniak', 'DawidPles', 'student'),
('karol.wojtas@example.com', 'Karol', 'Wojtas', 'KarolWoj', 'student'),
('magda.urbaniak@example.com', 'Magda', 'Urbaniak', 'MagdaUrb', 'student'),
('julia.kasza@example.com', 'Julia', 'Kasza', 'JuliaKas', 'student'),
('roksana.lis@example.com', 'Roksana', 'Lis', 'RoksanaLis', 'student'),
('mariusz.klosowski@example.com', 'Mariusz', 'Kłosowski', 'MariuszK', 'teacher'),
('albert.wozniak@example.com', 'Albert', 'Woźniak', 'AlbertWoz', 'student'),
('nina.krawiec@example.com', 'Nina', 'Krawiec', 'NinaKra', 'student'),
('jakub.olszak@example.com', 'Jakub', 'Olszak', 'JakubOls', 'student'),
('adrianna.kurek@example.com', 'Adrianna', 'Kurek', 'AdriannaK', 'student'),
('szymon.kot@example.com', 'Szymon', 'Kot', 'SzymonKot', 'student'),
('michalina.wozniak@example.com', 'Michalina', 'Woźniak', 'MichalinaW', 'student'),
('krzysztof.pietruszka@example.com', 'Krzysztof', 'Pietruszka', 'KrzysPiet', 'student'),
('laura.kasprzyk@example.com', 'Laura', 'Kasprzyk', 'LauraKas', 'student'),
('bartlomiej.wojda@example.com', 'Bartłomiej', 'Wojda', 'BartWojda', 'student'),
('weronika.mazurkiewicz@example.com', 'Weronika', 'Mazurkiewicz', 'WeronikaM', 'student');





-- Tabela classes

INSERT INTO classes (number, letter) VALUES
(1, 'A'),
(2, 'A'),
(3, 'A'),
(4, 'A'),
(5, 'A'),
(6, 'A'),
(7, 'A'),
(8, 'A'),
(1, 'B'),
(2, 'B'),
(3, 'B'),
(4, 'B'),
(5, 'B'),
(6, 'B'),
(7, 'B'),
(8, 'B'),
(4, 'C'),
(5, 'C');





-- Przypisywanie uczniów do klas

UPDATE users
SET cid=FLOOR(RANDOM()*(SELECT COUNT(cid) FROM classes))+1
WHERE role='student';





-- Tabela przedmiotów

INSERT INTO subjects (name) VALUES
('Matematyka'),
('Fizyka'),
('Chemia'),
('Biologia'),
('Informatyka'),
('Historia'),
('Geografia'),
('Język polski'),
('Język angielski'),
('Język niemiecki'),
('Wiedza o społeczeństwie'),
('Podstawy przedsiębiorczości'),
('Wychowanie fizyczne');





-- Tabela planu zajęć

INSERT INTO time_table (date, start_time, end_time, cid, tid, sbid, canceled, moved) VALUES
    ('2026-01-02', '08:00:00', '08:45:00', 6, 4, 2, DEFAULT, DEFAULT),
    ('2026-01-02', '08:50:00', '09:35:00', 8, 33, 11, DEFAULT, DEFAULT),
    ('2026-01-06', '09:45:00', '10:30:00', 10, 18, 9, DEFAULT, DEFAULT),
    ('2026-01-07', '10:40:00', '11:25:00', 12, 33, 13, DEFAULT, DEFAULT),

    -- canceled = true
    ('2026-01-08', '11:35:00', '12:20:00', 10, 7, 5, TRUE, DEFAULT),

    ('2026-01-08', '12:40:00', '13:25:00', 2, 4, 10, DEFAULT, DEFAULT),
    ('2026-01-09', '13:35:00', '14:20:00', 6, 40, 9, DEFAULT, DEFAULT),
    ('2026-01-09', '14:30:00', '15:15:00', 6, 26, 2, DEFAULT, DEFAULT),
    ('2026-01-13', '15:20:00', '16:05:00', 14, 4, 13, DEFAULT, DEFAULT),

    -- moved = true
    ('2026-01-13', '08:00:00', '08:45:00', 15, 26, 2, DEFAULT, TRUE),

    ('2026-01-14', '09:45:00', '10:30:00', 2, 7, 6, DEFAULT, DEFAULT),
    ('2026-01-14', '09:45:00', '10:30:00', 5, 13, 4, DEFAULT, DEFAULT),
    ('2026-01-15', '08:00:00', '08:45:00', 15, 4, 11, DEFAULT, DEFAULT),
    ('2026-01-15', '11:35:00', '12:20:00', 8, 33, 3, DEFAULT, DEFAULT),
    ('2026-01-16', '14:30:00', '15:15:00', 16, 7, 12, DEFAULT, DEFAULT),
    ('2026-01-16', '13:35:00', '14:20:00', 17, 50, 3, DEFAULT, DEFAULT),

    -- canceled = true
    ('2026-01-19', '14:30:00', '15:15:00', 16, 7, 7, TRUE, DEFAULT),

    ('2026-01-20', '15:20:00', '16:05:00', 18, 26, 10, DEFAULT, DEFAULT),
    ('2026-01-21', '08:00:00', '08:45:00', 10, 40, 6, DEFAULT, DEFAULT),
    ('2026-01-21', '08:50:00', '09:35:00', 13, 7, 5, DEFAULT, DEFAULT),
    ('2026-01-22', '09:45:00', '10:30:00', 2, 33, 1, DEFAULT, DEFAULT),
    ('2026-01-22', '10:40:00', '11:25:00', 15, 4, 9, DEFAULT, DEFAULT),
    ('2026-01-26', '11:35:00', '12:20:00', 15, 4, 8, DEFAULT, DEFAULT),
    ('2026-01-27', '12:40:00', '13:25:00', 6, 18, 9, DEFAULT, DEFAULT),
    ('2026-01-28', '13:35:00', '14:20:00', 7, 33, 11, DEFAULT, DEFAULT);




-- Tabela lekcji

INSERT INTO lessons (ttid, topic, description) VALUES
(1, 'Zasady dynamiki Newtona', 'Omówienie trzech zasad dynamiki i ich zastosowanie w życiu codziennym.'),
(2, 'Systemy polityczne świata', 'Porównanie demokracji, monarchii i systemów autorytarnych.'),
(3, 'Czasy przeszłe w języku angielskim', 'Ćwiczenia z Past Simple i Past Continuous.'),
(4, 'Ćwiczenia ogólnorozwojowe z piłką', 'Zajęcia praktyczne z wykorzystaniem piłek lekarskich i gimnastycznych.'),
(6, 'Przedstawianie siebie i innych po niemiecku', 'Ćwiczenia z użyciem czasownika „sein” i „haben”.'),
(7, 'Rozumienie tekstu czytanego', 'Analiza krótkich tekstów informacyjnych w języku angielskim.'),
(8, 'Zasady zachowania energii', 'Omówienie energii kinetycznej i potencjalnej oraz ich przemian.'),
(9, 'Ćwiczenia z równowagi i koordynacji', 'Zajęcia ruchowe z wykorzystaniem drabinek i równoważni.'),
(10, 'Prąd elektryczny i napięcie', 'Wyjaśnienie pojęć napięcia, natężenia i oporu elektrycznego.'),
(11, 'Fotosynteza i budowa liścia', 'Analiza procesu fotosyntezy oraz struktury liścia.'),
(12, 'Polska w okresie rozbiorów', 'Omówienie sytuacji politycznej i społecznej w XVIII wieku.'),
(14, 'Budowa atomu', NULL);