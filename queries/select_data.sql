-- Uczniowie wybranej klasy
SELECT uid, email, name, surname 
FROM students_list 
WHERE class = :class_name;

-- Plan zajęć dla klasy na konkretny dzień
SELECT start_time, end_time, subject_name, teacher_surname, topic 
FROM lessons_list 
WHERE class = :class_name AND date = :date;

-- Wszystkie lekcje prowadzone przez danego nauczyciela
SELECT date, start_time, subject_name, class, topic 
FROM lessons_list 
WHERE teacher_surname = :surname 
ORDER BY date, start_time;

-- Skrzynka odbiorcza konkretnego użytkownika
SELECT mid, title, content, sender_name, sender_surname, previous_message_title
FROM messages_list 
WHERE receiver_id = :user_id 
ORDER BY mid DESC;

-- Historia konwersacji między dwoma użytkownikami
SELECT sender_name, sender_surname, title, content
FROM messages_list
WHERE (sender_id = :user_a AND receiver_id = :user_b)
   OR (sender_id = :user_b AND receiver_id = :user_a)
ORDER BY mid ASC;

-- Lista wszystkich nauczycieli uczących dany przedmiot
SELECT DISTINCT teacher_name, teacher_surname 
FROM lessons_list 
WHERE subject_name = :subject_name;

-- Statystyka liczby uczniów w każdej klasie
SELECT class, COUNT(*) as student_count
FROM students_list
GROUP BY class
ORDER BY class;

-- Lista uczniów nie należących do każdej klasy
SELECT name, surname, email
FROM students_list
WHERE class IS NULL;

-- Oceny konkretnego ucznia wraz z nazwą przedmiotu i nazwiskiem nauczyciela, który ją wystawił
SELECT 
    s.name AS subject_name, 
    g.grade, 
    g.title AS grade_title, 
    g.date AS grade_date, 
    u_teacher.surname AS teacher_surname
FROM grades g
JOIN subjects s ON g.sbid = s.sbid
JOIN users u_teacher ON g.tid = u_teacher.uid
WHERE g.sid = :student_id
ORDER BY g.date DESC;

-- Sprawdziany dla konkretnej klasy, uwzględniając datę z planu zajęć i nazwę przedmiotu
SELECT 
    t.title AS test_title, 
    t.description, 
    tt.date AS test_date, 
    s.name AS subject_name
FROM tests t
JOIN time_table tt ON t.ttid = tt.ttid
JOIN subjects s ON tt.sbid = s.sbid
WHERE tt.cid = :cid
ORDER BY tt.date ASC;

-- Zadania domowe dla konkretnej klasy z informacją, kto je zadał i z jakiego są przedmiotu
SELECT 
    h.title, 
    h.description, 
    h.date AS assigned_date, 
    s.name AS subject_name, 
    u.surname AS teacher_surname
FROM homework h
JOIN subjects s ON h.sbid = s.sbid
JOIN users u ON h.tid = u.uid
WHERE h.cid = :cid
ORDER BY h.date DESC;

-- Lista obecności na konkretnej lekcji (dla nauczyciela)
SELECT 
    u.name, 
    u.surname, 
    a.status
FROM attendance a
JOIN users u ON a.sid = u.uid
WHERE a.lid = :lid
ORDER BY u.surname ASC;

-- Wszystkie nieobecności i spóźnienia danego ucznia
SELECT 
    tt.date, 
    s.name AS subject_name, 
    l.topic, 
    a.status
FROM attendance a
JOIN lessons l ON a.lid = l.lid
JOIN time_table tt ON l.ttid = tt.ttid
JOIN subjects s ON tt.sbid = s.sbid
WHERE a.sid = :student_id AND a.status IN ('absent', 'late')
ORDER BY tt.date DESC;
