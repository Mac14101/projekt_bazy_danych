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
   Tabela przechowująca konta użytkowników aplikacji.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| uid | INTEGER | - | Unikatowy identyfikator przypisany do użytkownika |
| email | VARCHAR | 100 | Adres e-mail użytkownika. |
| name | VARCHAR | 50 | Imie użytkownika. |
| surname | VARCHAR | 50 | Nazwisko użytkownika. |
| password | TEXT | - | Hasło do konta użytkownika. |
| role | VARCHAR | 20 | Rola użytkownika (np. admin, student). |

Dodatkowe informacje :
* Klucz główny : Kolumna `uid` jest unikalnym identyfikatorem każdego konta.
* Obowiązkowe kolumny : Podczas tworzenia nowego konta należy podać wartości pól `email`, `name`, `surname`, `password` oraz `role`.
* Kolumna `email` : Adres e-mail musi być unikalny.
* Kolumna `role` : Rola użytkownika musi być wybraną rolą z podanych:
   * admin - administrator systemu
   * teacher - nauczyciel
   * student - uczeń

2. Klasy(classes)
   Tabela przechowująca listę klas.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| cid | INTEGER | - | Unikatowy identyfikator klasy. |
| number | INTEGER | - | Numer klasy (np. 1, 2, 7). |
| letter | CHAR | 1 | Litera klasy (np. A, B, D). |

Dodatkowe informacje :
* Klucz główny : Kolumna `cid` jest unikalnym identyfikatorem klasy.
* Obowiązkowe kolumny : Podczas wstawiania nowej klasy do tabeli należy podać wartości pól `number` i `letter`.
* Kolumna `number` : Kolumna zawiera cyfrę z przedziału 0-8.
* Kolumna `letter` : Kolumna zawiera pojedynczą wielką literę (np. A, B, F).

3. Uczniowie(students)
   Tabela przechowująca przypisanie uczniów do klas.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| sid | INTEGER | - | Identyfikator ucznia. |
| cid | INTEGER | - | Identyfikator klasy. |

Dodatkowe informacje :
* Klucze obce :
   * Kolumna `sid` - Identyfikator konta ucznia (kolumna `uid` w tabeli *users*).
   * Kolumna `cid` - Identyfikator klasy (kolumna `cid` w tabeli *classes*).
* Obowiązkowe kolumny : Podczas przypisywania ucznia do klasy należy podać wartości pól `sid` oraz `cid`.
* Kolumna `sid` : Kolumna musi zawierać identyfikator użytkownika, którego rola to 'student'.

4. Przedmioty(subjects)
   Tabela przechowująca listę przedmiotów.

| Nazwa kolumny | Typ | Długość | Opis |
|-|-|-|-|
| sbid | INTEGER | - | Identyfikator przedmiotu. |
| name | VARCHAR | 100 | Nazwa przedmiotu. |

Dodatkowe informacje :
* Klucz główny : Kolumna `sbid` jest unikalnym identyfikatorem przedmiotu.
* Obowiązkowe kolumny : Podczas dodawania przedmiotu należy podać wartość pola `name`.

5. Plan zajęć(time_table)
   Tabela przechowująca plan zajęć.

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
* Klucz główny : Kolumna `ttid` jest unikalnym identyfikatorem zajęć.
* Obowiązkowe kolumny : Podczas dodawania nowych zajęć należy podać wartości pól `date`, `start_time`, `end_time`, `cid`, `tid` oraz `sbid`.
* Klucze obce : 
   * Kolumna `cid` - Identyfikator klasy (kolumna `cid` w tabeli *classes*).
   * Kolumna `tid` - Identyfikator nauczyciela (kolumna `uid` w tabeli *users*).
   * Kolumna `sbid` - Identyfikator przedmiotu (kolumna `sbid` w tabeli *subjects*).
* Kolumna `tid` : Kolumna musi zawierać identyfikator użytkownika, którego rola to 'teacher'.