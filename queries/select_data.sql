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