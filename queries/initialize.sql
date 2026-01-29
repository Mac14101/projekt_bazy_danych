-- Wszystkie kwerendy wymagane do utworzenia i wypełnienie bazy danych





-- Tworzenie tabel
-- Tabela użytkowników
CREATE TABLE IF NOT EXISTS users (
    uid serial  NOT NULL,
    email varchar(100)  NOT NULL,
    name varchar(50)  NOT NULL,
    surname varchar(50)  NOT NULL,
    password text  NOT NULL,
    role varchar(20)  NOT NULL,
    cid int  NULL,
    CONSTRAINT users_ak_email UNIQUE (email) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT role CHECK (role IN ('admin', 'teacher', 'student')) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT users_pk PRIMARY KEY (uid)
);

-- Tabela klas
CREATE TABLE IF NOT EXISTS classes (
    cid serial  NOT NULL,
    number int  NOT NULL,
    letter char(1)  NOT NULL,
    CONSTRAINT classes_ak_nl UNIQUE (number, letter) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT check_number CHECK (number >= 0 AND number <= 8) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT check_letter CHECK (letter = UPPER(letter)) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT classes_pk PRIMARY KEY (cid)
);

-- Tabela przedmiotów
CREATE TABLE IF NOT EXISTS subjects (
    sbid serial  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT subjects_ak_name UNIQUE (name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT subjects_pk PRIMARY KEY (sbid)
);

-- Tabela planu zajęć
CREATE TABLE IF NOT EXISTS time_table (
    ttid serial  NOT NULL,
    date date  NOT NULL,
    start_time time  NOT NULL,
    end_time time  NOT NULL,
    cid int  NOT NULL,
    tid int  NOT NULL,
    sbid int  NOT NULL,
    canceled boolean  NOT NULL DEFAULT false,
    moved boolean  NOT NULL DEFAULT false,
    CONSTRAINT time_table_pk PRIMARY KEY (ttid)
);

-- Tabela lekcji
CREATE TABLE IF NOT EXISTS lessons (
    lid serial  NOT NULL,
    ttid int  NOT NULL,
    topic varchar(200)  NOT NULL,
    description text  NULL,
    CONSTRAINT lessons_ak_ttid UNIQUE (ttid) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT lessons_pk PRIMARY KEY (lid)
);

-- Tabela obecności
CREATE TABLE IF NOT EXISTS attendance (
    sid int  NOT NULL,
    lid int  NOT NULL,
    status varchar(10)  NOT NULL DEFAULT 'undefined' CHECK (status IN ('undefined', 'present', 'absent', 'late')),
    CONSTRAINT attendance_pk PRIMARY KEY (sid,lid)
);


-- Tabela ocen
CREATE TABLE IF NOT EXISTS grades (
    gid serial  NOT NULL,
    sid int  NOT NULL,
    tid int  NOT NULL,
    sbid int  NOT NULL,
    grade varchar(10)  NOT NULL CHECK (grade IN ('ndst', 'dop', 'dst', 'db', 'bdb', 'cel', 'np', 'nb', 'o')),
    title varchar(200)  NOT NULL,
    description text  NULL,
    date date  NOT NULL DEFAULT NOW(),
    CONSTRAINT grades_pk PRIMARY KEY (gid)
);

-- Tabela sprawdzianów
CREATE TABLE IF NOT EXISTS tests (
    tsid serial  NOT NULL,
    ttid int  NOT NULL,
    title varchar(200)  NOT NULL,
    description text  NULL,
    CONSTRAINT tests_pk PRIMARY KEY (tsid)
);

-- Tabela zadań domowych
CREATE TABLE homework (
    hid serial  NOT NULL,
    cid int  NOT NULL,
    tid int  NOT NULL,
    sbid int  NOT NULL,
    title varchar(200)  NOT NULL,
    description text  NULL,
    date date  NOT NULL DEFAULT NOW(),
    CONSTRAINT homework_pk PRIMARY KEY (hid)
);

-- Tabela wiadomości
CREATE TABLE messages (
    mid serial  NOT NULL,
    snid int  NOT NULL,
    rcid int  NOT NULL,
    title varchar(200)  NOT NULL,
    content text  NOT NULL,
    pmid int  NULL,
    CONSTRAINT messages_pk PRIMARY KEY (mid)
);

-- Dodawanie kluczy obcych do tabel

-- Tabela users
ALTER TABLE users ADD CONSTRAINT classes_users
    FOREIGN KEY (cid)
    REFERENCES classes (cid)  
    ON UPDATE CASCADE
    ON DELETE SET NULL 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Tabela planu zajęć
ALTER TABLE time_table ADD CONSTRAINT time_table_classes
    FOREIGN KEY (cid)
    REFERENCES classes (cid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE time_table ADD CONSTRAINT time_table_subjects
    FOREIGN KEY (sbid)
    REFERENCES subjects (sbid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE time_table ADD CONSTRAINT time_table_users
    FOREIGN KEY (tid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE SET NULL
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Tabela lekcji
ALTER TABLE lessons ADD CONSTRAINT lessons_time_table
    FOREIGN KEY (ttid)
    REFERENCES time_table (ttid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

-- Tabela obecności
ALTER TABLE attendance ADD CONSTRAINT attendance_lessons
    FOREIGN KEY (lid)
    REFERENCES lessons (lid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;
ALTER TABLE attendance ADD CONSTRAINT attendance_students
    FOREIGN KEY (sid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;


-- Tabela ocen
ALTER TABLE grades ADD CONSTRAINT grades_students
    FOREIGN KEY (sid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE grades ADD CONSTRAINT grades_subjects
    FOREIGN KEY (sbid)
    REFERENCES subjects (sbid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE grades ADD CONSTRAINT grades_users
    FOREIGN KEY (tid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE SET NULL 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Tabela sprawdzianów
ALTER TABLE tests ADD CONSTRAINT tests_time_table
    FOREIGN KEY (ttid)
    REFERENCES time_table (ttid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Tabela zadań domowych
ALTER TABLE homework ADD CONSTRAINT homework_classes
    FOREIGN KEY (cid)
    REFERENCES classes (cid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE homework ADD CONSTRAINT homework_subjects
    FOREIGN KEY (sbid)
    REFERENCES subjects (sbid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE homework ADD CONSTRAINT homework_users
    FOREIGN KEY (tid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Tabela wiadomości
ALTER TABLE messages ADD CONSTRAINT messages_messages
    FOREIGN KEY (pmid)
    REFERENCES messages (mid)  
    ON UPDATE CASCADE
    ON DELETE SET NULL 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE messages ADD CONSTRAINT messages_users_r
    FOREIGN KEY (rcid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE SET NULL 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;
ALTER TABLE messages ADD CONSTRAINT messages_users_s
    FOREIGN KEY (snid)
    REFERENCES users (uid)  
    ON UPDATE CASCADE
    ON DELETE SET NULL 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;





-- Tworzenie widoków

-- Lista administratorów
CREATE VIEW admins_list AS 
    SELECT uid, email, name, surname
    FROM users
    WHERE role='admin'
    ORDER BY name, surname;

-- Lista nauczycieli
CREATE VIEW teachers_list AS
    SELECT uid, email, name, surname
    FROM users
    WHERE role='teacher'
    ORDER BY name, surname;

-- Lista uczniów
CREATE VIEW students_list AS
    SELECT U.uid, U.email, U.name, U.surname, CONCAT(C.number, C.letter)
    FROM users U
        LEFT JOIN classes C ON U.cid=C.cid
    WHERE role='student'
    ORDER BY C.number, C.letter, U.name, U.surname;

-- Plan zajęć oraz przeprowadzone lekcje
CREATE VIEW lessons_list AS
    SELECT TT.ttid, TT.date, TT.start_time, TT.end_time, L.topic, L.description, C.number, C.letter, T.name AS teacher_name, T.surname AS teacher_surname
    FROM time_table TT
        LEFT JOIN lessons L ON TT.ttid=L.ttid
        INNER JOIN classes C ON TT.cid=C.cid
        LEFT JOIN users T ON TT.tid=T.uid
        INNER JOIN subjects SB ON TT.sbid=SB.sbid
    ORDER BY C.number, C.letter, TT.date, TT.start_time;

-- Lista wiadomości
CREATE VIEW messages_list AS
    SELECT M.mid, M.title, M.content, M.snid AS sender_id, SN.name AS sender_name, SN.surname AS sender_surname, M.rcid AS receiver_id, RC.name receiver_name, RC.surname AS receiver_surname, PM.title AS previous_message_title, PM.content AS previous_message_content
    FROM messages M
        INNER JOIN users SN ON M.snid=SN.uid
        INNER JOIN users RC ON M.rcid=RC.uid
        LEFT JOIN messages PM ON M.pmid=PM.mid;