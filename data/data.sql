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