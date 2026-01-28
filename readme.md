# System e-dziennik

Celem projektu jest utworzenie systemu bazy danych **PostreSQL** dla aplikacji e-dziennika. Baza danych przechowuje :
* konta użytkowników korzystających z systemu
* listę klas w szkole
* listę uczniów (przypisanie uczniów do klas)
* listę przedmiotów
* tygodniowy plan zajęć klas
* rozpiska lekcji klas do końca roku szkolnego
* listy obecności uczniów na zajęciach
* listę ocen uczniów
* terminy sprawdzianów

## Tabele w bazie danych

1. Użytkownicy(users)
   Tabela przechowująca konta użytkowników aplikacji. Zawiera dane używane do uwierzytelniania, podczas używania aplikacji, oraz dane personalne użytkownika.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| uid | INTEGER | - | Unikatowy identyfikator przypisany do użytkownika |
| email | VARCHAR | 100 | Adres e-mail użytkownika. |
| name | VARCHAR | 50 | Imie użytkownika. |
| surname | VARCHAR | 50 | Nazwisko użytkownika. |
| password | TEXT | - | Hasło do konta użytkownika. |
| role | VARCHAR | 20 | Rola użytkownika (np. admin, student). |

Dodatkowe informacje :
* Klucz główny : `uid`
* Obowiązkowe kolumny :
   * `email`
   * `name`
   * `surname`
   * `password`
   * `role`
* Ograniczenia :
   * `email` - unikalna wartość
   * `role` - wartość z listy roli : 
      * admin - administrator systemu
      * teacher - nauczyciel
      * student - uczeń

2. Klasy(classes)
   Tabela przechowująca listę klas. Może istnieć maksymalnie jedna klasa o wybranym numerze i literze (np. 1A).

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| cid | INTEGER | - | Unikatowy identyfikator klasy. |
| number | INTEGER | - | Numer klasy (np. 1, 2, 7). |
| letter | CHAR | 1 | Litera klasy (np. A, B, D). |

Dodatkowe informacje :
* Klucz główny : `cid`
* Obowiązkowe kolumny : 
   * `number`
   * `letter`.
* Ograniczenia : 
   * `number` - cyfra z przedziału 0-8
   * `letter` - wielka litera (np. A, B, D, G)
   * (`number`, `letter`) - wartość unikalna

3. Uczniowie(students)
   Tabela przechowująca przypisanie uczniów do klas. Uczeń może być przypisany tylko do jednej klasy.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| sid | INTEGER | - | Identyfikator ucznia. |
| cid | INTEGER | - | Identyfikator klasy. |

Dodatkowe informacje :
* Klucze obce :
   * `sid`
   * `cid`
* Obowiązkowe kolumny : 
   * `sid`
   * `cid`.
* Ograniczenia : 
   * `sid` - wartość unikalna
* Dodatkowe warunki :
   * `sid` - użytkownik o tym identyfikatorze musi mieć rolę **student**
* Triggery : 
   * *students_table_insert_trigger* - trigger wywoływany podczas wstawiania rekordu do tabeli, sprawdza czy użytkownik o podanym identyfikatorze ma rolę **student**
   * *students_table_update_trigger* - trigger wywoływany podczas aktualizacji rekordu w tabeli, sprawdza czy użytkownik o podanym identyfikatorze ma rolę **student**

4. Przedmioty(subjects)
   Tabela przechowująca listę przedmiotów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| sbid | INTEGER | - | Identyfikator przedmiotu. |
| name | VARCHAR | 100 | Nazwa przedmiotu. |

Dodatkowe informacje :
* Klucz główny : `sbid`
* Obowiązkowe kolumny : 
   * `name`.
* Ograniczenia :
   * `name` - unikalna wartość

5. Plan zajęć(time_table)
   Tabela przechowująca zajęcia z planu zajęć. Rekord odpowiada jednym zajęciom odbywającym się w zadanym dniu i godzinie. Zajęcia mogą być przenoszone między godzinami lub odwoływane.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| ttid | INTEGER | - | Identyfikator zajęć w planie zajęć. |
| date | DATE | - | Dzień, w którym mają odbywać się zajęcia. |
| start_time | TIME | - | Godzina rozpoczęcia zajęć. |
| end_time | TIME | - | Godzina zakończenia zajęć. |
| cid | INTEGER | - | Identyfikator klasy, której dotyczą zajęcia. |
| tid | INTEGER | - | Identyfikator nauczyciela, który prowadzi zajęcia. |
| sbid | INTEGER | - | Identyfikator przedmiotu. |
| canceled | BOOLEAN | - | Flaga informująca czy zajęcia zostały odwołane. |
| moved | BOOLEAN | - | Flaga informująca czy zajęcia zostały przesunięte (np. odbywają się w innym dniu lub o innej godzinie). | 

Dodatkowe informacje : 
* Klucz główny : `ttid`
* Klucze obce : 
   * `cid`
   * `tid`
   * `sbid`
* Obowiązkowe kolumny : 
   * `date`
   * `start_time`
   * `end_time`
   * `cid`
   * `tid`
   * `sbid`
* Domyślne wartości : 
   * `canceled` - domyślnie **false**
   * `moved` - domyślnie **false**
* Dodatkowe warunki :
   * (`date`, `start_time`, `end_time`) - klasa nie może mieć w tym czasie innych zajęć
   * `tid` - użytkownik o tym identyfikatorze musi mieć rolę **teacher**
* Triggery :
   * *time_table_insert_trigger* - trigger wywoływany podczas wstawiania rekordu do tabeli, sprawdza czy klasa o podanym numerze id ma zaplanowane zajęcia w podanym czasie, oraz czy użytkownik o podanym identyfikatorze ma rolę **teacher**
   * *time_table_update_trigger* - trigger wywoływany podczas aktualizacji rekordu z tabeli, sprawdza czy klasa o podanym numerze id ma zaplanowane zajęcia w podanym czasie, oraz czy użytkownik o podanym identyfikatorze ma rolę **teacher**

6. Lekcje(lessons)
   Tabela zawiera lekcje, które zostały przeprowadzone przez nauczycieli. Lekcja jest przypisana do zajęć z planu zajęć.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| lid | INTEGER | - | Identyfikator lekcji. |
| ttid | INTEGER | - | Identyfikator zajęć w planie zajęć. |
| topic | VARCHAR | 200 | Temat lekcji. |
| description | TEXT | - | Opis lekcji. |

Dodatkowe informacje : 
* Klucz główny : `lid`
* Klucze obce : 
   * `ttid` - Identyfikator zajęć w planie zajęć.
* Obowiązkowe kolumny : 
   * `ttid`
   * `topic`
* Wartości domyślne :
   * `description` - domyślnie **NULL**

7. Obecność(attendance)
   Tabela zawiera listę obecności uczniów na lekcji. Obecność dla uczniów jest dodawana automatycznie po utworzeniu lekcji dla wszystkich uczniów z klasy, status ustawiany jest jako niezdefiniowany (**undefined**).

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| sid | INTEGER | - | Identyfikator ucznia |
| lid | INTEGER | - | Identyfikator lekcji. |
| status | VARCHAR | 10 | Status obecności (np. present, absent) |

Dodatkowe informacje : 
* Klucze obce :
   * `sid`
   * `lid`
* Obowiązkowe kolumny : 
   * `sid`
   * `lid`
   * `status`
* Ograniczenia : 
   * `status` - wartość z listy statusów obecności : 
      * undefined
      * present
      * absent
      * late


8. Oceny(grades)
   Tabela zawiera listę ocen uczniów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| gid | INTEGER | - | Identyfikator oceny |
| sid | INTEGER | - | Identyfikator ucznia |
| tid | INTEGER | - | Identyfikator nauczyciela, który dodał ocenę. |
| sbid | INTEGER | - | Identyfikator przedmiotu, którego dotyczy ocena. |
| grade | VARCHAR | 10 | Ocena (np. bdb, dop, nb, np). |
| title | VARCHAR | 200 | Tytuł oceny. |
| description | TEXT | - | Opis oceny. |
| date | DATE | - | Data wystawienia oceny. |

Dodatkowe informacje : 
* Klucz główny : `gid`
* Klucze obce : 
   * `sid`
   * `tid`
   * `sbid`
* Obowiązkowe kolumny :
   * `sid`
   * `tid`
   * `sbid`
   * `grade`
   * `title`
* Wartości domyślne : 
   * `description` - domyślnie **NULL**
   * `date` - domyślnie **NOW()**
* Ograniczenia : 
   * `grade` - wartość z listy ocen : 
      * ndst (1)
      * dop (2)
      * dst (3)
      * db (4)
      * bdb (5)
      * cel (6)
      * np (nie przygotowany)
      * nb (brak oceny np. nieobecny na sprawdzianie)
      * o (inne)
* Dodatkowe warunki :
   * `sid` - użytkownik o tym identyfikatorze musi mieć rolę **student**
   * `tid` - użytkownik o tym identyfikatorze musi mieć rolę **teacher**
* Triggery : 
   * *grades_table_insert_trigger* - - trigger wywoływany podczas wstawiania rekordu do tabeli, sprawdza czy uczeń o podanym id faktycznie posiada rolę **student**, oraz czy nauczyciel o podanym id faktycznie posiada rolę **teacher**
   * *grades_table_update_trigger* - - trigger wywoływany podczas aktualizacji rekordu z tabeli, sprawdza czy uczeń o podanym id faktycznie posiada rolę **student**, oraz czy nauczyciel o podanym id faktycznie posiada rolę **teacher**


9. Sprawdziany(tests)
   Tabela zawierając listę sprawdzianów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| tsid | INTEGER | - | Identyfikator sprawdzianu |
| ttid | INTEGER | - | Identyfikator zajęć z planu zajęć. |
| title | VARCHAR | 200 | Tytuł sprawdzianu. |
| description | TEXT | - | Opis sprawdzianu. |

Dodatkowe informacje :
* Klucz główny : `tsid`
* Klucze obce : 
   * `ttid`
* Obowiązkowe kolumny : 
   * `ttid`
   * `title`
* Domyślne wartości :
   * `description` - domyślnie **NULL**

10. Zadanie domowe(homework)
   Tabela zawierająca listę zadań domowych.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| hid | INTEGER | - | Identyfikator zadania domowego. |
| cid | INTEGER | - | Identyfikator klasy, której dotyczy zadanie domowe. |
| tid | INTEGER | - | Identyfikator nauczyciela, który zadał zadanie domowe. |
| sbid | INTEGER | - | Identyfikator przedmiotu, którego dotyczy zadanie domowe. |
| title | VARCHAR | 200 | Tytuł zadania domowego. |
| description | TEXT | - | Opis zadania domowego. |
| date | TEXT | - | Data, określająca termin oddania zadania domowego. |

Dodatkowe informacje :
* Klucz główny `hid`
* Klucze obce :
   * `cid`
   * `tid`
   * `sbid`
* Obowiązkowe kolumny :
   * `cid`
   * `tid`
   * `sbid`
   * `title`
* Domyślne wartości : 
   * `description` - domyślnie **NULL**
   * `date` - domyślnie **NOW()**



11. Wiadomości(messages)
   Tabela zawierająca wiadomości wysyłane przez użytkowników. Wiadomość może być odpowiedzią do innej wiadomości poprzez ustawienie pola `pmid`.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| mid | INTEGER | - | Identyfikator wiadomości. |
| snid | INTEGER | - | Identyfikator nadawcy wiadomości. |
| rcid | INTEGER | - | Identyfikator odbiorcy wiadomości. |
| title | VARCHAR | 200 | Tytuł wiadomości. |
| content | TEXT | - | Zawartość wiadomości. |
| pmid | INTEGER | - | Identyfikator poprzedniej wiadomości. |

Dodatkowe informacje :
* Klucz główny : `mid`
* Klucze obce :
   * `snid`
   * `rcid`
   * `pmid`
* Obowiązkowe kolumny :
   * `snid`
   * `rcid`
   * `title`
   * `content`
* Domyślne wartości :
   * `pmid` - domyślnie **NULL**

## Widoki

1. Lista administratorów
   Widok zawierający listę użytkowników o roli administratora. Lista posortowana jest alfabetycznie.

   Kwerenda SQL :
   ```sql
   SELECT uid, email, name, surname
   FROM users
   WHERE role='admin'
   ORDER BY name, surname;;
   ```

2. Lista nauczycieli
   Widok zawierający listę użytkowników o roli nauczyciela. Lista posortowana jest alfabetycznie.

   Kwerenda SQL :
   ```sql
   SELECT uid, email, name, surname
   FROM users
   WHERE role='teacher'
   ORDER BY name, surname;
   ```
3. Lista uczniów
   Widok zawierający listę użytkowników o roli ucznia. Lista posortowana jest według klas oraz alfabetycznie względem imion nazwisk.

   Kwerenda SQL :
   ```sql
   SELECT U.uid, U.email, U.name, U.surname, C.number, C.letter
   FROM users U
      LEFT JOIN students S ON U.uid=S.sid
      INNER JOIN classes C ON S.cid=C.cid
   WHERE role='admin'
   ORDER BY C.number, C.letter, U.name, U.surname;
   ```
4. Plan zajęć oraz przeprowadzone lekcje
   Widok zawierający plan zajęć z przypisanymi lekcjami, które zostały przeprowadzone przez nauczycieli. Plan zajęć jest posortowany według klas.

   Kwerenda SQL :
   ```sql
   SELECT TT.ttid, TT.date, TT.start_time, TT.end_time, L.topic, L.description, C.number, C.letter, T.name AS teacher_name, T.teacher_surname AS tsurname
   FROM time_table TT
      LEFT JOIN lessons L ON TT.ttid=L.ttid
      INNER JOIN classes C ON TT.cid=C.cid
      INNER JOIN users T ON TT.tid=T.uid
      INNER JOIN subjects SB ON TT.sbid=SB.sbid
   ORDER BY C.number, C.letter, TT.date, TT.startTime; 
   ```
5. Lista wiadomości
   Widok zawierający listę wiadomości oraz przypisane poprzednie wiadomości, których dotyczą.
   
   Kwerenda SQL:
   ```sql
   SELECT M.mid, M.title, M.content, M.snid AS sender_id, SN.name AS sender_name, SN.surname AS sender_surname, M.rcid AS receiver_id, RC.name receiver_name, RC.surname AS receiver_surname, PM.title, PM.content
   FROM messages M
      INNER JOIN users SN ON M.snid=SN.uid
      INNER JOIN users RC ON M.rcid=RC.uid
      LEFT JOIN messages PM ON M.pmid=PM.mid;
   ```