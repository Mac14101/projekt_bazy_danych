-- tables
-- Table: attendance
CREATE TABLE IF NOT EXISTS attendance (
    sid serial  NOT NULL,
    lid int  NOT NULL,
    status varchar(10)  NOT NULL DEFAULT 'undefined' CHECK (status IN ('undefined', 'present', 'absent', 'late')),
    CONSTRAINT attendance_pk PRIMARY KEY (sid,lid)
);

-- Table: classes
CREATE TABLE IF NOT EXISTS classes (
    cid serial  NOT NULL,
    number int  NOT NULL,
    letter char(1)  NOT NULL,
    CONSTRAINT classes_ak_nl UNIQUE (number, letter) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT check_number CHECK (number >= 0 AND number <= 8) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT check_letter CHECK (letter = UPPER(letter)) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT classes_pk PRIMARY KEY (cid)
);

-- Table: grades
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

-- Table: homework
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

-- Table: lessons
CREATE TABLE IF NOT EXISTS lessons (
   lid serial  NOT NULL,
   ttid int  NOT NULL,
   topic varchar(200)  NOT NULL,
   description text  NULL,
   CONSTRAINT lessons_ak_ttid UNIQUE (ttid) NOT DEFERRABLE  INITIALLY IMMEDIATE,
   CONSTRAINT lessons_pk PRIMARY KEY (lid)
);

-- Table: messages
CREATE TABLE messages (
   mid serial  NOT NULL,
   snid int  NOT NULL,
   rcid int  NOT NULL,
   title varchar(200)  NOT NULL,
   content text  NOT NULL,
   pmid int  NULL,
   CONSTRAINT messages_pk PRIMARY KEY (mid)
);

-- Table: students
CREATE TABLE IF NOT EXISTS students (
    sid int  NOT NULL,
    cid int  NOT NULL,
    CONSTRAINT students_pk PRIMARY KEY (sid)
);

-- Table: subjects
CREATE TABLE IF NOT EXISTS subjects (
    sbid serial  NOT NULL,
    name varchar(100)  NOT NULL,
    CONSTRAINT subjects_ak_name UNIQUE (name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT subjects_pk PRIMARY KEY (sbid)
);

-- Table: tests
CREATE TABLE IF NOT EXISTS tests (
    tsid serial  NOT NULL,
    ttid int  NOT NULL,
    title varchar(200)  NOT NULL,
    description text  NULL,
    CONSTRAINT tests_pk PRIMARY KEY (tsid)
);

-- Table: time_table
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

-- Table: users
CREATE TABLE IF NOT EXISTS users (
    uid serial  NOT NULL,
    email varchar(100)  NOT NULL,
    name varchar(50)  NOT NULL,
    surname varchar(50)  NOT NULL,
    password text  NOT NULL,
    role varchar(20)  NOT NULL,
    CONSTRAINT users_ak_email UNIQUE (email) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT role CHECK (role IN ('admin', 'teacher', 'student')) NOT DEFERRABLE INITIALLY IMMEDIATE,
    CONSTRAINT users_pk PRIMARY KEY (uid)
);

-- foreign keys
-- Reference: attendance_lessons (table: attendance)
ALTER TABLE attendance ADD CONSTRAINT attendance_lessons
    FOREIGN KEY (lid)
    REFERENCES lessons (lid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: attendance_students (table: attendance)
ALTER TABLE attendance ADD CONSTRAINT attendance_students
    FOREIGN KEY (sid)
    REFERENCES students (sid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: classes_students (table: students)
ALTER TABLE students ADD CONSTRAINT classes_students
    FOREIGN KEY (cid)
    REFERENCES classes (cid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: grades_students (table: grades)
ALTER TABLE grades ADD CONSTRAINT grades_students
    FOREIGN KEY (sid)
    REFERENCES students (sid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: grades_subjects (table: grades)
ALTER TABLE grades ADD CONSTRAINT grades_subjects
    FOREIGN KEY (sbid)
    REFERENCES subjects (sbid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: grades_users (table: grades)
ALTER TABLE grades ADD CONSTRAINT grades_users
    FOREIGN KEY (tid)
    REFERENCES users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: homework_classes (table: homework)
ALTER TABLE homework ADD CONSTRAINT homework_classes
    FOREIGN KEY (cid)
    REFERENCES classes (cid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: homework_subjects (table: homework)
ALTER TABLE homework ADD CONSTRAINT homework_subjects
    FOREIGN KEY (sbid)
    REFERENCES subjects (sbid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: homework_users (table: homework)
ALTER TABLE homework ADD CONSTRAINT homework_users
    FOREIGN KEY (tid)
    REFERENCES users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: lessons_time_table (table: lessons)
ALTER TABLE lessons ADD CONSTRAINT lessons_time_table
    FOREIGN KEY (ttid)
    REFERENCES time_table (ttid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: messages_messages (table: messages)
ALTER TABLE messages ADD CONSTRAINT messages_messages
    FOREIGN KEY (pmid)
    REFERENCES messages (mid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: messages_users_r (table: messages)
ALTER TABLE messages ADD CONSTRAINT messages_users_r
    FOREIGN KEY (rcid)
    REFERENCES users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: messages_users_s (table: messages)
ALTER TABLE messages ADD CONSTRAINT messages_users_s
    FOREIGN KEY (snid)
    REFERENCES users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: students_users (table: students)
ALTER TABLE students ADD CONSTRAINT students_users
    FOREIGN KEY (sid)
    REFERENCES users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: tests_time_table (table: tests)
ALTER TABLE tests ADD CONSTRAINT tests_time_table
    FOREIGN KEY (ttid)
    REFERENCES time_table (ttid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_table_classes (table: time_table)
ALTER TABLE time_table ADD CONSTRAINT time_table_classes
    FOREIGN KEY (cid)
    REFERENCES classes (cid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_table_subjects (table: time_table)
ALTER TABLE time_table ADD CONSTRAINT time_table_subjects
    FOREIGN KEY (sbid)
    REFERENCES subjects (sbid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_table_users (table: time_table)
ALTER TABLE time_table ADD CONSTRAINT time_table_users
    FOREIGN KEY (tid)
    REFERENCES users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;