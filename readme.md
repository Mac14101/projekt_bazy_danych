# Spis treści

1. [System e-dziennik](#system-e-dziennik)
2. [Tabele](#tabele)
3. [Widoki](#widoki)

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

## Tabele

1. Użytkownicy(users)
    Tabela przechowująca konta użytkowników aplikacji. Zawiera dane używane do uwierzytelniania, podczas używania aplikacji, oraz dane personalne użytkownika.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| uid | SERIAL | - | Unikatowy identyfikator przypisany do użytkownika |
| email | VARCHAR | 100 | Adres e-mail użytkownika. |
| name | VARCHAR | 50 | Imie użytkownika. |
| surname | VARCHAR | 50 | Nazwisko użytkownika. |
| password | TEXT | - | Hasło do konta użytkownika. |
| role | VARCHAR | 20 | Rola użytkownika (np. admin, student). |
| cid | INTEGER | - | Identyfikator klasy (tylko dla użytkowników o roli student). |

Dodatkowe informacje :
* Klucz główny : `uid`
* Klucze obce :
    * `cid`
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
    * `cid` - tylko użytkownicy z rolą student
* Wartości domyślne :
    * `cid` - domyślnie **NULL**

2. Klasy(classes)
    Tabela przechowująca listę klas. Może istnieć maksymalnie jedna klasa o wybranym numerze i literze (np. 1A).

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| cid | SERIAL | - | Unikatowy identyfikator klasy. |
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

3. Przedmioty(subjects)
   Tabela przechowująca listę przedmiotów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| sbid | SERIAL | - | Identyfikator przedmiotu. |
| name | VARCHAR | 100 | Nazwa przedmiotu. |

Dodatkowe informacje :
* Klucz główny : `sbid`
* Obowiązkowe kolumny : 
    * `name`.
* Ograniczenia :
    * `name` - unikalna wartość

4. Plan zajęć(time_table)
    Tabela przechowująca zajęcia z planu zajęć. Rekord odpowiada jednym zajęciom odbywającym się w zadanym dniu i godzinie. Zajęcia mogą być przenoszone między godzinami lub odwoływane.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| ttid | SERIAL | - | Identyfikator zajęć w planie zajęć. |
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

5. Lekcje(lessons)
    Tabela zawiera lekcje, które zostały przeprowadzone przez nauczycieli. Lekcja jest przypisana do zajęć z planu zajęć.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| lid | SERIAL | - | Identyfikator lekcji. |
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
* Ograniczenia :
    * `ttid` - wartość unikalna
* Dodatkowe warunki :
    * `ttid` - lekcja nie może być przypisana do odwołanych zajęć, wartość nie może być zmieniana
* Triggery :
    * *lessons_insert_table* - trigger wywoływany przy dodawaniu rekordu do tabeli, sprawdza czy zajęcia z planu zajęć ne są odwołane
    * *lesson_insert_attendance* - trigger wywoływany przy dodawaniu rekordu do tabeli, dodaje rekordy do tabeli attendance ze statusem **undefined** dla wszystkich uczniów których dotyczy lekcja

6. Obecność(attendance)
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


7. Oceny(grades)
    Tabela zawiera listę ocen uczniów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| gid | SERIAL | - | Identyfikator oceny |
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

8. Sprawdziany(tests)
    Tabela zawierając listę sprawdzianów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| tsid | SERIAL | - | Identyfikator sprawdzianu |
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

9. Zadanie domowe(homework)
    Tabela zawierająca listę zadań domowych.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| hid | SERIAL | - | Identyfikator zadania domowego. |
| cid | INTEGER | - | Identyfikator klasy, której dotyczy zadanie domowe. |
| tid | INTEGER | - | Identyfikator nauczyciela, który zadał zadanie domowe. |
| sbid | INTEGER | - | Identyfikator przedmiotu, którego dotyczy zadanie domowe. |
| title | VARCHAR | 200 | Tytuł zadania domowego. |
| description | TEXT | - | Opis zadania domowego. |
| date | DATE | - | Data, określająca termin oddania zadania domowego. |

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

10. Wiadomości(messages)
    Tabela zawierająca wiadomości wysyłane przez użytkowników. Wiadomość może być odpowiedzią do innej wiadomości poprzez ustawienie pola `pmid`.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| mid | SERIAL | - | Identyfikator wiadomości. |
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

1. Lista administratorów(admins_list)
    Widok zawierający listę użytkowników o roli administratora. Lista posortowana jest alfabetycznie.

    Kwerenda SQL :
    ```sql
    SELECT uid, email, name, surname
    FROM users
    WHERE role='admin'
    ORDER BY name, surname;
    ```

2. Lista nauczycieli(teachers)
    Widok zawierający listę użytkowników o roli nauczyciela. Lista posortowana jest alfabetycznie.

    Kwerenda SQL :
    ```sql
    SELECT uid, email, name, surname
    FROM users
    WHERE role='teacher'
    ORDER BY name, surname;
    ```
3. Lista uczniów(students_list)
    Widok zawierający listę użytkowników o roli ucznia. Lista posortowana jest według klas oraz alfabetycznie względem imion nazwisk.

    Kwerenda SQL :
    ```sql
    SELECT U.uid, U.email, U.name, U.surname, CONCAT(C.number, C.letter) AS 'class'
    FROM users U
        LEFT JOIN classes C ON U.cid=C.cid
    WHERE role='student'
    ORDER BY C.number, C.letter, U.name, U.surname;
    ```
4. Plan zajęć oraz przeprowadzone lekcje(lessons_list)
    Widok zawierający plan zajęć z przypisanymi lekcjami, które zostały przeprowadzone przez nauczycieli. Plan zajęć jest posortowany według klas.

    Kwerenda SQL :
    ```sql
    SELECT TT.ttid, TT.date, TT.start_time, TT.end_time, SB.name AS subject_name, CONCAT(C.number, C.letter) AS 'class', L.topic, L.description, T.name AS teacher_name, T.surname AS teacher_surname
    FROM time_table TT
        LEFT JOIN lessons L ON TT.ttid=L.ttid
        INNER JOIN classes C ON TT.cid=C.cid
        LEFT JOIN users T ON TT.tid=T.uid
        INNER JOIN subjects SB ON TT.sbid=SB.sbid
    ORDER BY C.number, C.letter, TT.date, TT.start_time;
    ```
5. Lista wiadomości(messages_list)
    Widok zawierający listę wiadomości oraz przypisane poprzednie wiadomości, których dotyczą.

    Kwerenda SQL:
    ```sql
    SELECT M.mid, M.title, M.content, M.snid AS sender_id, SN.name AS sender_name, SN.surname AS sender_surname, M.rcid AS receiver_id, RC.name receiver_name, RC.surname AS receiver_surname, PM.title AS previous_message_title, PM.content AS previous_message_content
    FROM messages M
        INNER JOIN users SN ON M.snid=SN.uid
        INNER JOIN users RC ON M.rcid=RC.uid
        LEFT JOIN messages PM ON M.pmid=PM.mid;
    ```
