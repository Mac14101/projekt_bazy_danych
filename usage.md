# Spis treści

1. [Wstawianie danych](#wstawianie-danych)
2. [Aktualizowanie danych](#aktualizowanie-danych)
3. [Pobieranie danych](#pobieranie-danych)
4. [Usuwanie danych](#usuwanie-danych)

## Wstawianie danych

1. Dodawanie użytkownika
   Kwerenda SQL :
   ``` sql
   INSERT INTO users (email, name, surname, password, role) VALUES (:email, :name, :surname, :password, :role);
   ```

   Parametry :
      * `email` - adres e-mail nowego użytkownika, jeżeli użytkownik z podanym adresie e-mail juz istnieje wystąpi błąd
      * `name` - imię nowego użytkownika
      * `surname` - nazwisko nowego użytkownika
      * `password` - hasło do konta nowego użytkownika
      * `role` - rola nowego użytkownika, do wyboru
         * **student** - uczeń
         * **teacher** - nauczyciel
         * **admin** - administrator

2. Dodawanie klasy
   Kwerenda SQL :
   ```sql
   INSERT INTO classes (number, letter) VALUES (:number, :letter);
   ```

   Parametry :
      * `number` - numer klasy (np. 1, 2, 6)
      * `letter` - litera klasy (np. A, B, D)

3. Dodawanie przedmiotu
   Kwerenda SQL :
   ```sql
   INSERT INTO subjects (name) VALUES (:name);
   ```

   Parametry :
      * `name` - nazwa przedmiotu szkolnego (np. Matematyka, Język polski)

4. Dodawanie zajęć do planu zajęć
   Kwerenda SQL :
   ```sql
   INSERT INTO time_table (date, start_time, end_time, cid, tid, sbid) VALUES (:date, :start_time, :end_time, :cid, :tid, :sbid);
   ```

   Parametry :
      * `date` - data, kiedy odbywają się zajęcia
      * `start_time` - godzina rozpoczęcia zajęć
      * `end_time` - godzina zakończenia zajęć
      * `cid` - numer id klasy, której dotyczą zajęcia (tabela *classes*)
      * `tid` - numer id nauczyciela prowadzącego zajęcia (tabela *users*), niezbędna rola **teacher**
      * `sbid` - numer id przedmiotu szkolnego (tabela *subjects*)

5. Dodawanie lekcji 
   Kwerenda SQL :
   ```sql
   INSERT INTO lessons (ttid, topic, description) VALUES (:ttid, :topic, :description);
   ```

   Parametry :
      * `ttid` - identyfikator zajęć w planie zajęć (tabela *time_table*)
      * `topic` - temat zajęć
      * `description` - opis zajęć, pole niewymagane

6. Dodawanie oceny
   Kwerenda SQL :
   ```sql
   INSERT INTO grades (sid, tid, sbid, grade, title, description) VALUES (:sid, :tid, :sbid, :grade, :title, :description);
   ```

   Parametry :
      * `sid` - identyfikator ucznia otrzymującego ocenę (tabela *users*), niezbędna rola **student**
      * `tid` - identyfikator nauczyciela wystawiającego ocenę (tabela *users*), niezbędna rola **teacher**
      * `sbid` - identyfikator przedmiotu (tabela *subjects*)
      * `grade` - ocena
         * **ndst** (1)
         * **dop** (2)
         * **dst** (3)
         * **db** (4)
         * **bdb** (5)
         * **cel** (6)
         * **np** (nie przygotowany)
         * **nb** (brak oceny np. nieobecny na sprawdzianie)
         * **o** (inne)
      * `title` - tytuł oceny
      * `description` - opis zajęć, pole niewymagane

7. Dodawanie sprawdzianu
   Kwerenda SQL :
   ```sql
   INSERT INTO tests (ttid, title, description) VALUES (:ttid, :title, :description);
   ```

   Parametry :
      * `ttid` - identyfikator zajęć z planu zajęć, na których odbywać (tabela *time_table*)
      * `title` - tytuł sprawdzianu
      * `description` - opis sprawdzianu, pole niewymagane

8. Zadanie domowe
   Kwerenda SQL :
   ```sql
   INSERT INTO homework (cid, tid, sbid, title, description) VALUES (:cid, :tid, :sbid, :title, :description);
   ```

   Parametry :
      * `cid` - identyfikator klasy, której dotyczy zadanie domowe (tabela *classes*)
      * `cid` - identyfikator nauczyciela, który zadał zadanie (tabela *users*), niezbędna rola **teacher**
      * `cid` - identyfikator przedmiotu, którego dotyczy zadanie (tabela *subjects*)
      * `title` - tytuł zadanie domowego
      * `description` - opis zadania domowego, pole niewymagane

## Aktualizacja danych

1. Zmiana adresu e-mail użytkownika
   Kwerenda SQL :
   ```sql
   UPDATE users SET email=:email WHERE uid=:uid;
   ```

   Parametry :
      * `uid` - identyfikator użytkownika, którego dotyczy zmiana
      * `email` - nowy adres e-mail użytkownika

2. Zmiana hasła użytkownika
   Kwerenda SQL :
   ```sql
   UPDATE users SET password=:password WHERE uid=:uid;
   ```

   Parametry :
      * `uid` - identyfikator użytkownika, którego dotyczy zmiana
      * `password` - nowe hasło użytkownika

3. Zmiana klasy ucznia
   Kwerenda SQL :
   ```sql
   UPDATE users SET cid=:cid WHERE uid=:sid;
   ```

   Parametry :
      * `sid` - identyfikator użytkownika, którego dotyczy zmiana
      * `cid` - identyfikator klasy, do której przepisany zostaje uczeń

4. Zmiana nazwy klasy
   Kwerenda SQL :
   ```sql
   UPDATE classes SET number=:number, letter=:letter WHERE cid=:cid;
   ```

   Parametry :
      * `cid` - identyfikator klasy, której dotyczy zmiana
      * `number` - nowa cyfra przypisana do klasy
      * `letter` - nowa litera przypisana do klasy

5. Zmiana nauczyciela prowadzącego zajęcia
   Kwerenda SQL :
   ```sql
   UPDATE time_table SET tid=:tid WHERE ttid=:ttid;
   ```

   Parametry :
      * `ttid` - identyfikator zajęć, których dotyczy zmiana
      * `tid` - identyfikator nauczyciela przydzielonego w zastępstwo

6. Przeniesienie zajęć na inny dzień/godzinę
   Kwerenda SQL :
   ```sql
   UPDATE time_table SET date=:date, start_time=:start_time, end_time=:end_time, moved=true WHERE ttid=:ttid;
   ```

   Parametry :
      * `ttid` - identyfikator zajęć, których dotyczy zmiana
      * `date` - dzień, na który zajęcia zostają przeniesione
      * `start_time` - nowa godzina rozpoczęcia zajęć
      * `end_time` - nowy czas zakończenia zajęć

7. Odwołanie zajęć
   Kwerenda SQL :
   ```sql
   UPDATE time_table SET canceled=true WHERE ttid=:ttid;
   ```

   Parametry :
      * `ttid` - identyfikator zajęć, których dotyczy zmiana

8. Zmiana tematu i opisu lekcji
   Kwerenda SQL :
   ```sql
   UPDATE lessons SET title=:title, description=:description WHERE lid=:lid;
   ```

   Parametry :
      * `lid` - identyfikator lekcji, której dotyczy zmiana
      * `title` - nowy tytuł lekcji
      * `description` - nowy opis lekcji

9. Zmiana statusu obecności ucznia
   Kwerenda SQL :
   ```sql
   UPDATE attendance SET status=:status WHERE lid=:lid AND sid=:sid;
   ```

   Parametry :
      * `lid` - identyfikator lekcji, której dotyczy zmiana
      * `sid` - identyfikator ucznia, którego dotyczy zmiana obecności
      * `status` - status obecności :
         * **undefined**
         * **present**
         * **absent**
         * **late**

10. Zmiana oceny i opisu oceny
   Kwerenda SQL :
   ```sql
   UPDATE grades SET grade=:grade, description=:description WHERE gid=:gid;
   ```

   Parametry :
      * `gid` - identyfikator oceny, której dotyczy zmiana
      * `grade` - nowa ocena :
         * ndst (1)
         * dop (2)
         * dst (3)
         * db (4)
         * bdb (5)
         * cel (6)
         * np (nie przygotowany)
         * nb (brak oceny np. nieobecny na sprawdzianie)
         * o (inne)
      * `description` - nowy opis oceny

11. Zmiana przypisania sprawdzianu do zajęć
   Kwerenda SQL :
   ```sql
   UPDATE tests SET ttid=:ttid WHERE tsid=:tsid;
   ```

   Parametry :
      * `tsid` - identyfikator sprawdzianu, którego dotyczy zmiana
      * `ttid` - identyfikator zajęć, na które sprawdzian zostaje przeniesiony


12. Zmiana terminu oddania zadania domowego
   Kwerenda SQL :
   ```sql
   UPDATE homework SET date=:date WHERE hid=:hid;
   ```

   Parametry :
      * `hid` - identyfikator zadania domowego, którego dotyczy zmiana
      * `date` - nowa data zwrotu zadania domowego

## Pobieranie danych

1. Uczniowie z wybranej klasy
   Kwerenda SQL :
   ```sql
   SELECT uid, email, name, surname 
   FROM students_list 
   WHERE class = :class_name;
   ```

   * Parametry :
      * `class_name` - nazwa klasy (np. 1A, 4D, 5B)

2. Plan zajęć dla klasy na konkretny dzień
   Kwerenda SQL :
   ```sql
   SELECT start_time, end_time, subject_name, teacher_surname, topic 
   FROM lessons_list 
   WHERE class = :class_name AND date = :date;
   ```

   * Parametry :
      * `class_name` - nazwa klasy (np. 1A, 4D, 5B)
      * `date` - data, dla której należy sprawdzić plan zajęć

3. Wszystkie lekcje prowadzone przez danego nauczyciela
   Kwerenda SQL :
   ```sql
   SELECT date, start_time, subject_name, class, topic 
   FROM lessons_list 
   WHERE teacher_surname = :surname 
   ORDER BY date, start_time;
   ```

   * Parametry :
      * `surname` - nazwisko nauczyciela

4. Skrzynka odbiorcza konkretnego użytkownika
   Kwerenda SQL :
   ```sql
   SELECT mid, title, content, sender_name, sender_surname, previous_message_title
   FROM messages_list 
   WHERE receiver_id = :user_id 
   ORDER BY mid DESC;
   ```

   * Parametry :
      * `user_id` - identyfikator użytkownika

5. Historia konwersacji między dwoma użytkownikami
   Kwerenda SQL :
   ```sql
   SELECT sender_name, sender_surname, title, content
   FROM messages_list
   WHERE (sender_id = :user_a AND receiver_id = :user_b)
      OR (sender_id = :user_b AND receiver_id = :user_a)
   ORDER BY mid ASC;
   ```

   * Parametry :
      * `user_a` - identyfikator użytkownika
      * `user_b` - identyfikator drugiego użytkownika

6. Lista wszystkich nauczycieli uczących dany przedmiot
   Kwerenda SQL :
   ```sql
   SELECT DISTINCT teacher_name, teacher_surname 
   FROM lessons_list 
   WHERE subject_name = :subject_name;
   ```

   * Parametry :
      * `subject_name` - nazwa przedmiotu

7. Statystyka liczby uczniów w każdej klasie
   Kwerenda SQL :
   ```sql
   SELECT class, COUNT(*) as student_count
   FROM students_list
   GROUP BY class
   ORDER BY class;
   ```

8. Lista uczniów nie należących do każdej klasy
   Kwerenda SQL :
   ```sql
   SELECT name, surname, email
   FROM students_list
   WHERE class IS NULL;
   ```

## Usuwanie danych

1. Usuwanie konta użytkownika
   Kwerenda SQL:
   ```sql
   DELETE FROM users WHERE uid=:uid;
   ```

   Parametry :
      * `uid` - identyfikator użytkownika, który ma zostać usunięty

2. Usuwanie klasy
   Kwerenda SQL:
   ```sql
   DELETE FROM classes WHERE cid=:cid;
   ```

   Parametry :
      * `cid` - identyfikator klasy, która ma zostać usuniętą

3. Usuwanie oceny
   Kwerenda SQL:
   ```sql
   DELETE FROM grades WHERE gid=:gid;
   ```

   Parametry :
      * `gid` - identyfikator oceny, która ma zostać usuniętą

4. Usuwanie sprawdzianu
   Kwerenda SQL:
   ```sql
   DELETE FROM tests WHERE tsid=:tsid;
   ```

   Parametry :
      * `tsid` - identyfikator sprawdzianu, który ma zostać usunięty

5. Usuwanie zadania domowego
   Kwerenda SQL:
   ```sql
   DELETE FROM tests WHERE hid=:hid;
   ```

   Parametry :
      * `hid` - identyfikator zadania domowego, które ma zostać usunięte