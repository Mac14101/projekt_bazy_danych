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
    SELECT U.uid, U.email, U.name, U.surname, CONCAT(C.number, C.letter) AS class
    FROM users U
        LEFT JOIN classes C ON U.cid=C.cid
    WHERE role='student'
    ORDER BY C.number, C.letter, U.name, U.surname;

-- Plan zajęć oraz przeprowadzone lekcje
CREATE VIEW lessons_list AS
    SELECT TT.ttid, TT.date, TT.start_time, TT.end_time, SB.name AS subject_name, CONCAT(C.number, C.letter) AS class, L.topic, L.description, T.name AS teacher_name, T.surname AS teacher_surname
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