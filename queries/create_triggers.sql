-- Funkcje i Triggery
-- Funkcja do triggerow tabeli time_table
CREATE OR REPLACE FUNCTION time_table_logic_func()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT role FROM users WHERE uid = NEW.tid) != 'teacher' THEN
        RAISE EXCEPTION 'Użytkownik o ID % nie jest nauczycielem.', NEW.tid;
    END IF;

    IF EXISTS (
        SELECT 1 FROM time_table
        WHERE cid = NEW.cid 
          AND date = NEW.date
          AND canceled = false 
          AND (TG_OP = 'INSERT' OR ttid != NEW.ttid)
          AND NEW.start_time < end_time 
          AND NEW.end_time > start_time
    ) THEN
        RAISE EXCEPTION 'Klasa o ID % ma już zaplanowane inne zajęcia w tym terminie (%, % - %).', 
            NEW.cid, NEW.date, NEW.start_time, NEW.end_time;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger wywoływany podczas wstawiania rekordu do tabeli, sprawdza czy klasa o podanym numerze id ma zaplanowane zajęcia w podanym czasie, oraz czy użytkownik o podanym identyfikatorze ma rolę teacher
CREATE TRIGGER time_table_insert_trigger
BEFORE INSERT ON time_table
FOR EACH ROW
EXECUTE FUNCTION time_table_logic_func();

-- Trigger wywoływany podczas aktualizacji rekordu z tabeli, sprawdza czy klasa o podanym numerze id ma zaplanowane zajęcia w podanym czasie, oraz czy użytkownik o podanym identyfikatorze ma rolę teacher
CREATE TRIGGER time_table_update_trigger
BEFORE UPDATE ON time_table
FOR EACH ROW
EXECUTE FUNCTION time_table_logic_func();

-- Funkcja do triggera sprawdza odwołane zajęcia
CREATE OR REPLACE FUNCTION lessons_insert_table_func()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF (SELECT canceled FROM time_table WHERE ttid = NEW.ttid) = TRUE THEN
            RAISE EXCEPTION 'Nie można przypisać lekcji do zajęć, które są odwołane (ttid: %).', NEW.ttid;
        END IF;
    END IF;

    IF (TG_OP = 'UPDATE') THEN
        IF NEW.ttid <> OLD.ttid THEN
            RAISE EXCEPTION 'Wartość ttid w tabeli lessons jest stała i nie może zostać zmieniona.';
        END IF;
  
        IF (SELECT canceled FROM time_table WHERE ttid = NEW.ttid) = TRUE THEN
            RAISE EXCEPTION 'Nie można edytować lekcji przypisanej do odwołanych zajęć.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger wywoływany przy dodawaniu rekordu do tabeli, sprawdza czy zajęcia z planu zajęć ne są odwołane, wartość nie może być zmieniana
CREATE TRIGGER lessons_insert_table_trigger
BEFORE INSERT OR UPDATE ON lessons
FOR EACH ROW
EXECUTE FUNCTION lessons_insert_table_func();

-- Funkcja do triggera do dodawania rekordow do tabeli attendance ze statusem undefined
CREATE OR REPLACE FUNCTION lesson_insert_attendance_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO attendance (sid, lid, status)
    SELECT u.uid, NEW.lid, 'undefined'
    FROM users u
    JOIN time_table tt ON u.cid = tt.cid
    WHERE tt.ttid = NEW.ttid 
      AND u.role = 'student';

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger wywoływany przy dodawaniu rekordu do tabeli, dodaje rekordy do tabeli attendance ze statusem undefined dla wszystkich uczniów których dotyczy lekcja
CREATE TRIGGER lesson_insert_attendance_trigger
AFTER INSERT ON lessons
FOR EACH ROW
EXECUTE FUNCTION lesson_insert_attendance_func();

-- Funkcja do triggerow tabeli grades_table
CREATE OR REPLACE FUNCTION grades_table_logic_func()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT role FROM users WHERE uid = NEW.sid) != 'student' THEN
        RAISE EXCEPTION 'BŁĄD: Użytkownik o ID % (sid) nie jest uczniem. Tylko studenci mogą otrzymywać oceny.', NEW.sid;
    END IF;

    IF (SELECT role FROM users WHERE uid = NEW.tid) != 'teacher' THEN
        RAISE EXCEPTION 'BŁĄD: Użytkownik o ID % (tid) nie jest nauczycielem. Tylko nauczyciele mogą wystawiać oceny.', NEW.tid;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger wywoływany podczas wstawiania rekordu do tabeli, sprawdza czy uczeń o podanym id faktycznie posiada rolę student, oraz czy nauczyciel o podanym id faktycznie posiada rolę teacher
CREATE TRIGGER grades_table_insert_trigger
BEFORE INSERT ON grades
FOR EACH ROW
EXECUTE FUNCTION grades_table_logic_func();

-- Trigger wywoływany podczas aktualizacji rekordu z tabeli, sprawdza czy uczeń o podanym id faktycznie posiada rolę student, oraz czy nauczyciel o podanym id faktycznie posiada rolę teacher
CREATE TRIGGER grades_table_update_trigger
BEFORE UPDATE ON grades
FOR EACH ROW

EXECUTE FUNCTION grades_table_logic_func();
