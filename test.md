## Próba rozspójnienia danych w bazie oraz sprawdzenie automatycznego dodawania obecności

Scenariusz :
1. Próba dodania zajęć do planu zajęć z uczniem jako prowadzącym
```sql
INSERT INTO time_table (date, start_time, end_time, cid, tid, sbid) VALUES
('2026-02-03', '08:00:00', '08:45:00', 1, (SELECT uid FROM students_list ORDER BY random() LIMIT 1), 1);
```
*INSERT* zostaje odrzucony.
![Wynik kwerendy z punktu 1](./images/test_1_1.png)

2. Próba dodania zajęć do planu zajęć w czasie kiedy klasa ma inne zajęcia
![Wynik kwerendy pobierającej zajęcia](./images/test_1_2_select.png)
```sql
INSERT INTO time_table (date, start_time, end_time, cid, tid, sbid) VALUES
('2026-01-22', '09:45:00', '10:30:00', 2, (SELECT uid FROM teachers_list ORDER BY random() LIMIT 1), 1);
```
*INSERT* zostaje odrzucony.
![Wynik kwerendy z punktu 2](./images/test_1_2.png)

3. Poprawe dodanie zajęć do planu zajęć dla klasy o `cid`=1 (klasa 1A)
```sql
INSERT INTO time_table (date, start_time, end_time, cid, tid, sbid) VALUES
('2026-02-03', '08:00:00', '08:45:00', 1, (SELECT uid FROM teachers_list ORDER BY random() LIMIT 1), 1);
```
*INSERT* zostaje przyjęty.
![Wynik kwerendy z punktu 3](./images/test_1_3.png)

4. Dodanie lekcji
```sql
INSERT INTO lessons (ttid, topic, description) VALUES
((SELECT ttid FROM time_table WHERE date='2026-02-03' AND cid=1), 'TESTOWA LEKCJA', NULL);
```
*INSERT* zostaje przyjęty. Automatycznie zostają dodane wpisy frekwencji dla uczniów klasy 1A.
![Wynik kwerendy z punktu 4](./images/test_1_4.png)

5. Sprawdzenie czy lekcja została dodana
```sql
SELECT * FROM lessons_list;
```
![Wynik kwerendy z punktu 5](./images/test_1_5.png)

6. Sprawdzenie czy obecność została poprawnie uzupełniona
```sql
SELECT U.name, U.surname, A.status, C.cid, concat(C.number, C.letter)
FROM attendance A
   INNER JOIN lessons L ON L.lid=A.lid
   INNER JOIN users U ON A.sid=U.uid
   INNER JOIN classes C ON U.cid=C.cid
WHERE L.topic='TESTOWA LEKCJA';
```
![Wynik kwerendy z punktu 6](./images/test_1_6.png)