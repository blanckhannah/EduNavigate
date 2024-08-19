--------------------------------------------
--  Authentication and Authorization
-- (Tables used by the authentication and authorization system)
--------------------------------------------
drop table if exists users, user_roles, student, parent, discipline, attendance, teacher, student_parent, student_discipline, student_teacher CASCADE;
create table users (
    username varchar(255) primary key,
    email varchar(255),
    password varchar(255)
    -- Additional fields can be added here,
    -- such as first name, last name, etc.
    -- Just also update the spring user model/dao
);

create table user_roles (
    username varchar(255),
    role varchar(255),
    primary key (username, role)
);

-- Create the admin/admin user with the ADMIN role
insert into users (username, password, email) values ('admin', '$2a$10$kRbQq1xPISiteFw/LMEoi.Cid/tKI4.flGJB.05hhtPpgIYu.LPbS', 'admin@example.com');
insert into users (username, password, email) values ('pingsterhaus', '$2a$10$OnRyWHKRFQmp6TVTUoprd.QL.Un3BjZfGHlgtWXQ9gS1izNf8FjBC', 'lpingsterhaus@gmail.com');
insert into users (username, password, email) values ('bean', '$2a$10$e6XmWYAgK7zvg1aEJavK1.GRrD3A25Sc3Ygexn7mzqRHfqiuKiljG', 'sbean@gmail.com');
insert into users (username, password, email) values ('kilpatrick', '$2a$10$GRVHjt24GdURBmfKrfWRCOa/lK0z3dSj3tjx5BNLrXSrSu8x15N7S', 'skilpatrick@gmail.com');
insert into users (username, password, email) values ('parrott', '$2a$10$xEbzZUo0PHlUD5Y8bLmqfunAKnnldytiPrkxw.sVJ6qC.M8j4gkH6', 'cparrott@gmail.com');
insert into users (username, password, email) values ('webb', '$2a$10$mPC49S0Mu4.0ILlAQtRn5utmxGB.Yb2R5Dk2D99g9E9yAoyMRAe2m', 'awebb@gmail.com');
insert into users (username, password, email) values ('jackson', '$2a$10$oKm4Fcdn.RqKZbFVZaIz4Ok4XtEs977hN4SPaeH5YmEYs1VomG74G', 'gjackson@gmail.com');
insert into user_roles (username, role) values ('admin', 'ADMIN');
insert into user_roles (username, role) values ('pinsterhaus', 'TEACHER');
insert into user_roles (username, role) values ('bean', 'TEACHER');
insert into user_roles (username, role) values ('kilpatrick', 'TEACHER');
insert into user_roles (username, role) values ('parrott', 'TEACHER');
insert into user_roles (username, role) values ('webb', 'TEACHER');
insert into user_roles (username, role) values ('jackson', 'TEACHER');

--------------------------------------------
--  Application
-- (Tables used by the application)
--------------------------------------------

-- TODO: Add your tables here!

CREATE TABLE student (
   student_id serial,
   first_name varchar(20) NOT NULL,
   last_name varchar(30) NOT NULL,
   image_path varchar(255),
   address varchar(100) NOT NULL,
   grade int NOT NULL,
   CONSTRAINT PK_student PRIMARY KEY (student_id)
);

CREATE TABLE parent (
    parent_id serial,
    first_name varchar(20) NOT NULL,
    last_name varchar(30) NOT NULL,
    address varchar(100) NOT NULL,
    phone_number varchar(20) NULL,
    CONSTRAINT PK_parent PRIMARY KEY (parent_id)
);

CREATE TABLE discipline (
    discipline_id serial,
    student_id int NOT NULL,
    referral_date date NOT NULL,
    description varchar(500) NOT NULL,
    discipline_action varchar(100) NOT NULL,
    parent_contacted boolean NOT NULL,
    CONSTRAINT PK_discipline PRIMARY KEY (discipline_id),
    CONSTRAINT FK_student FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE attendance (
    attendance_id serial,
    student_id int NOT NULL,
    attendance_date date NOT NULL,
    present boolean NOT NULL,
    tardy boolean NOT NULL,
    CONSTRAINT PK_attendance PRIMARY KEY (attendance_id),
    CONSTRAINT FK_student FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE teacher (
    teacher_id serial,
    first_name varchar(20),
    last_name varchar(30),
    email varchar(100),
	username varchar(30),
    CONSTRAINT PK_teacher PRIMARY KEY (teacher_id)
);

CREATE TABLE student_parent (
    student_id int NOT NULL,
    parent_id int NOT NULL,
    CONSTRAINT PK_student_parent PRIMARY KEY (student_id, parent_id),
    CONSTRAINT FK_student_parent_student FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT FK_student_parent_parent FOREIGN KEY (parent_id) REFERENCES parent(parent_id)
);

CREATE TABLE student_teacher (
    student_id int NOT NULL,
    teacher_id int NOT NULL,
    CONSTRAINT PK_student_teacher PRIMARY KEY (student_id, teacher_id),
    CONSTRAINT FK_student_teacher_student FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT FK_student_teacher_teacher FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Rory', 'Black', '123 Here Ln. Arrowsmith, IL 61722', 3, 'https://i.postimg.cc/cC2JD6zY/Rory-Black.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Flynn', 'Black', '123 Here Ln. Arrowsmith, IL 61722', 5, 'https://i.postimg.cc/R07nN1DY/Flynn-Black.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Janessa', 'Martin', '588 Winslow Dr. Arrowsmith, IL 61722', 0, 'https://i.postimg.cc/xCVyZTWw/Janessa-Martin.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Carter', 'Martin', '588 Winslow Dr. Arrowsmith, IL 61722', 4, 'https://i.postimg.cc/pXSj7Ljs/Carter-Martin.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Royce', 'Brooks', '5678 Par Dr. Arrowsmith, IL 61722', 1, 'https://i.postimg.cc/66mT61Q3/Royce-Brooks.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Gabrielle', 'Taylor', '7942 Golfview Dr. Arrowsmith, IL 61722', 5, 'https://i.postimg.cc/3R30p4Mx/Gabrielle-Taylor.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Oliver', 'Lewis', '646 Sangamon Ave. Arrowsmith, IL 61722', 2, 'https://i.postimg.cc/1zQ8hn3r/Oliver-Lewis.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Andy', 'Smith', '293 Sangamon Ave. Arrowsmith, IL 61722', 0, 'https://i.postimg.cc/vH0hmyVn/Andy-Smith.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Liam', 'Roberts', '9274 Dawn Cir. Arrowsmith, IL 61722', 1, 'https://i.postimg.cc/BbVjdmjj/Liam-Roberts.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Robert', 'Andrews', '4720 Lane Dr. Arrowsmith, IL 61722', 3, 'https://i.postimg.cc/wM7vcDwg/Robert-Andrews.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Peyton', 'Michaels', '819 Oval Dr. Arrowsmith, IL 61722', 4, 'https://i.postimg.cc/FRPzLTgT/Peyton-Michaels.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Ava', 'White', '678 Oval Dr. Arrowsmith, IL 61722', 5, 'https://i.postimg.cc/GmNjkjzh/AvaWhite.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Blake', 'Scott', '7943 Virginia Cir. Arrowsmith, IL 61722', 2, 'https://i.postimg.cc/j5hNk66f/Blake-Scott.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Norah', 'Carlson', '7333 Virginia Cir. Arrowsmith, IL 61722', 4, 'https://i.postimg.cc/158np1dw/Norah-Carlson.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Emily', 'Green', '123 Maple St. Arrowsmith, IL 61722', 2, 'https://i.postimg.cc/PfvcGqGr/Emily-Green.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Jack', 'Brown', '456 Oak St. Arrowsmith, IL 61722', 3, 'https://i.postimg.cc/KzRW8GRf/Jack-Brown.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Olivia', 'Johnson', '789 Pine St. Arrowsmith, IL 61722', 1, 'https://i.postimg.cc/0NNWVkdv/Olivia-Johnson.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Lucas', 'Williams', '101 Birch St. Arrowsmith, IL 61722', 4, 'https://i.postimg.cc/wThGvbTC/Lucas-Williams.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Sophia', 'Garcia', '202 Cedar St. Arrowsmith, IL 61722', 5, 'https://i.postimg.cc/j2fkyM6J/Sophia-Garcia.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Ethan', 'Martinez', '303 Elm St. Arrowsmith, IL 61722', 0, 'https://i.postimg.cc/HkbcFXz4/Ethan-Martinez.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Mia', 'Rodriguez', '404 Spruce St. Arrowsmith, IL 61722', 2, 'https://i.postimg.cc/fTGSHBcR/Mia-Rodriguez.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Noah', 'Wilson', '505 Fir St. Arrowsmith, IL 61722', 3, 'https://i.postimg.cc/KYs9V6JM/Noah-Wilson.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Ava', 'Lopez', '606 Pine St. Arrowsmith, IL 61722', 4, 'https://i.postimg.cc/L4ktZdL3/AvaLopez.jpg');
INSERT INTO student (first_name, last_name, address, grade, image_path) VALUES ('Liam', 'Martinez', '707 Maple St. Arrowsmith, IL 61722', 1, 'https://i.postimg.cc/ZRBfhwMD/Liam-Martinez.jpg');


INSERT INTO parent (first_name, last_name, address) VALUES ('Lynda', 'Black', '123 Here Ln. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Clarissa', 'Martin', '588 Winslow Dr. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Abigail', 'Brooks', '5678 Par Dr. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Erin', 'Taylor', '7942 Golfview Dr. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Jamie', 'Lewis', '646 Sangamon Ave. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Samantha', 'Smith', '293 Sangamon Ave. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Isabelle', 'Roberts', '9274 Dawn Cir. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Trent', 'Andrews', '4720 Lane Dr. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address, phone_number) VALUES ('Blake', 'Michaels', '819 Oval Dr. Arrowsmith, IL 61722', 2178997456);
INSERT INTO parent (first_name, last_name, address, phone_number) VALUES ('Jordan',  'White', '678 Oval Dr. Arrowsmith, IL 61722', 7391943758);
INSERT INTO parent (first_name, last_name, address, phone_number) VALUES ('Marissa',  'White', '678 Oval Dr. Arrowsmith, IL 61722', 9365926587);
INSERT INTO parent (first_name, last_name, address, phone_number) VALUES ('Kyle', 'Scott', '7943 Virginia Cir. Arrowsmith, IL 61722', 74027467592);
INSERT INTO parent (first_name, last_name, address, phone_number) VALUES ('Shannon', 'Carlson', '7333 Virginia Cir. Arrowsmith, IL 61722', 9372226756);
INSERT INTO parent (first_name, last_name, address) VALUES ('Alice', 'Green', '123 Maple St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Bob', 'Brown', '456 Oak St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Carol', 'Johnson', '789 Pine St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('David', 'Williams', '101 Birch St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Eva', 'Garcia', '202 Cedar St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Frank', 'Martinez', '303 Elm St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Grace', 'Rodriguez', '404 Spruce St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Henry', 'Wilson', '505 Fir St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Ivy', 'Lopez', '606 Pine St. Arrowsmith, IL 61722');
INSERT INTO parent (first_name, last_name, address) VALUES ('Jack', 'Martinez', '707 Maple St. Arrowsmith, IL 61722');


INSERT INTO teacher (first_name, last_name, email, username) VALUES ('Lindsey', 'Pingsterhaus', 'lpingsterhaus@gmail.com', 'pingsterhaus');
INSERT INTO teacher (first_name, last_name, email, username) VALUES ('Samantha', 'Bean', 'sbean@gmail.com', 'bean');
INSERT INTO teacher (first_name, last_name, email, username) VALUES ('Shelby', 'Kilpatrick', 'skilpatrick@gmail.com', 'kilpatrick');
INSERT INTO teacher (first_name, last_name, email, username) VALUES ('Catie', 'Parrott', 'cparrott@gmail.com', 'parrott');
INSERT INTO teacher (first_name, last_name, email, username) VALUES ('April', 'Webb', 'awebb@gmail.com', 'webb');
INSERT INTO teacher (first_name, last_name, email, username) VALUES ('Grace', 'Jackson', 'gjackson@gmail.com', 'jackson');


INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (1, '2024-09-15', 'Student was continuously talking out of turn and disrupting the flow of the lesson during the entire class period. Despite multiple warnings, the behavior persisted, causing distraction for other students and interruption of the teaching process.', 'Warning', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (2, '2024-08-20', 'Student threatened physical harm to a classmate during a group activity. The threat involved explicit verbal statements indicating intent to inflict injury, which caused significant concern among peers and staff.', 'Suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (3, '2024-10-10', 'During lunch period, student made several inappropriate comments to classmates, which included derogatory remarks and insults. The comments were disruptive and made others feel uncomfortable and unsafe.', 'Lunch/Recess Detention', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (4, '2024-11-05', 'Student repeatedly refused to follow established safety protocols during a science lab experiment, leading to potential hazards and increased risk for themselves and others. Despite numerous instructions, the student’s behavior jeopardized the safety of the entire class.', 'Office visit', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (5, '2024-12-12', 'Student used foul and offensive language during multiple class sessions, creating a hostile environment for classmates and staff. The language was inappropriate for the classroom setting and violated school conduct policies.', 'Suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (6, '2024-07-15', 'Student was caught skipping class on multiple occasions throughout the week. This pattern of truancy included leaving the classroom without permission and avoiding attendance during scheduled lessons.', 'Detention', false);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (7, '2024-10-20', 'Student intentionally damaged several pieces of classroom equipment, including breaking a projector and tearing pages from textbooks. The actions were deliberate and resulted in significant disruption to the learning environment.', 'Community Service', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (8, '2024-11-25', 'Student has been repeatedly late to class without a valid excuse. This consistent tardiness has affected the student’s ability to participate fully in lessons and disrupted the class routine.', 'Phone call home', false);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (9, '2024-09-10', 'Student was involved in a verbal altercation with a teacher, involving raised voices and disrespectful language. The conflict occurred during a classroom discussion and escalated despite attempts to de-escalate the situation.', 'In-school suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (10, '2024-10-30', 'Student has repeatedly refused to complete assigned homework over the past month. This refusal to adhere to academic responsibilities has led to missed assignments and lower academic performance.', 'Detention', false);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (1, '2024-10-05', 'Student engaged in disruptive behavior during group work, including talking loudly and making inappropriate comments. The behavior was persistent and affected the productivity and focus of the entire group.', 'Lunch/Recess Detention', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (3, '2024-11-15', 'Student was caught using a mobile phone during class despite clear instructions that electronic devices were not permitted. The student’s use of the phone led to distractions and interruptions in the learning environment.', 'Office visit', false);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (8, '2024-12-01', 'Student participated in a food fight in the cafeteria, throwing food and causing a mess. The behavior led to significant cleanup efforts and affected the dining experience for other students.', 'Suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (8, '2024-12-20', 'Student displayed aggressive behavior towards peers, including shouting and pushing. The aggression occurred during recess and led to conflicts and disruptions among students.', 'Phone call home', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (10, '2024-12-05', 'Student disregarded classroom rules on multiple occasions, including talking during instructions and not following group activity guidelines. The repeated disregard for rules affected the classroom management.', 'Detention', false);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (1, '2024-11-10', 'Student engaged in an argument with a classmate during a group project. The argument escalated to shouting and included personal insults. Despite efforts to de-escalate the situation, the conflict continued and disrupted the entire group activity.', 'Office visit', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (1, '2024-12-08', 'Student was found bullying a younger student in the playground area. The bullying included name-calling and exclusion from group activities, which caused emotional distress to the victim.', 'Suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (1, '2024-12-22', 'Student was caught vandalizing school property by drawing graffiti on the bathroom walls. The vandalism required significant cleaning and repair, and was considered a serious breach of school conduct policies.', 'Community Service', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (3, '2024-09-18', 'Student exhibited disruptive behavior during a classroom presentation by repeatedly interrupting and making distracting noises. The behavior impacted the ability of other students to concentrate and the quality of the presentation.', 'Lunch/Recess Detention', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (3, '2024-10-25', 'Student was found cheating on a major exam by using unauthorized materials and receiving answers from a peer. The cheating was discovered during the exam review process and affected the integrity of the testing environment.', 'In-school suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (3, '2024-11-30', 'Student was involved in a physical altercation with another student in the gym during a physical education class. The altercation included pushing and shoving, and required intervention from staff to separate the students.', 'Suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (8, '2024-08-22', 'Student was found stealing items from other students’ lockers. The theft was discovered after multiple complaints from peers about missing personal items, leading to a school investigation.', 'Suspension', true);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (8, '2024-09-30', 'Student was caught engaging in disruptive behavior during a field trip by running around and ignoring instructions from chaperones. The behavior caused safety concerns and disrupted the planned activities.', 'Detention', false);
INSERT INTO discipline (student_id, referral_date, description, discipline_action, parent_contacted) VALUES (8, '2024-11-15', 'Student was involved in a verbal confrontation with a teacher regarding classroom rules. The confrontation included loud arguments and defiance towards authority figures, affecting the classroom environment.', 'Office visit', true);


INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-21', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-23', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-21', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-22', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-23', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-23', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-25', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-26', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-25', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-25', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-23', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-26', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-27', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-28', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-29', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (1, '2023-08-30', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-27', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-28', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-29', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (2, '2023-08-30', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-27', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-28', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-29', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (3, '2023-08-30', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-27', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-28', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-29', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (4, '2023-08-30', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-27', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-28', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-29', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (5, '2023-08-30', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-27', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-28', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-29', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (6, '2023-08-30', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (7, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (7, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (7, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (7, '2023-08-27', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (7, '2023-08-28', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (15, '2023-08-21', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (15, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (15, '2023-08-23', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (15, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (15, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (15, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (16, '2023-08-21', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (16, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (16, '2023-08-23', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (16, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (16, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (16, '2023-08-26', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (17, '2023-08-21', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (17, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (17, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (17, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (17, '2023-08-25', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (17, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (18, '2023-08-21', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (18, '2023-08-22', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (18, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (18, '2023-08-24', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (18, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (18, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (19, '2023-08-21', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (19, '2023-08-22', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (19, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (19, '2023-08-24', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (19, '2023-08-25', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (19, '2023-08-26', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (20, '2023-08-21', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (20, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (20, '2023-08-23', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (20, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (20, '2023-08-25', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (20, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (21, '2023-08-21', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (21, '2023-08-22', false, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (21, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (21, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (21, '2023-08-25', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (21, '2023-08-26', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (22, '2023-08-21', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (22, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (22, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (22, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (22, '2023-08-25', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (22, '2023-08-26', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (23, '2023-08-21', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (23, '2023-08-22', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (23, '2023-08-23', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (23, '2023-08-24', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (23, '2023-08-25', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (23, '2023-08-26', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (24, '2023-08-21', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (24, '2023-08-22', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (24, '2023-08-23', true, true);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (24, '2023-08-24', false, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (24, '2023-08-25', true, false);
INSERT INTO attendance (student_id, attendance_date, present, tardy) VALUES (24, '2023-08-26', true, false);


INSERT INTO student_parent (student_id, parent_id) VALUES (1, 1);
INSERT INTO student_parent (student_id, parent_id) VALUES (2, 1);
INSERT INTO student_parent (student_id, parent_id) VALUES (3, 2);
INSERT INTO student_parent (student_id, parent_id) VALUES (4, 2);
INSERT INTO student_parent (student_id, parent_id) VALUES (5, 3);
INSERT INTO student_parent (student_id, parent_id) VALUES (6, 4);
INSERT INTO student_parent (student_id, parent_id) VALUES (7, 5);
INSERT INTO student_parent (student_id, parent_id) VALUES (8, 6);
INSERT INTO student_parent (student_id, parent_id) VALUES (9, 7);
INSERT INTO student_parent (student_id, parent_id) VALUES (10, 8);
INSERT INTO student_parent (student_id, parent_id) VALUES (11, 9);
INSERT INTO student_parent (student_id, parent_id) VALUES (12, 10);
INSERT INTO student_parent (student_id, parent_id) VALUES (12, 11);
INSERT INTO student_parent (student_id, parent_id) VALUES (13, 12);
INSERT INTO student_parent (student_id, parent_id) VALUES (14, 13);
INSERT INTO student_parent (student_id, parent_id) VALUES (15, 13); 
INSERT INTO student_parent (student_id, parent_id) VALUES (16, 14);
INSERT INTO student_parent (student_id, parent_id) VALUES (17, 15);
INSERT INTO student_parent (student_id, parent_id) VALUES (18, 16);
INSERT INTO student_parent (student_id, parent_id) VALUES (19, 17);
INSERT INTO student_parent (student_id, parent_id) VALUES (20, 18);
INSERT INTO student_parent (student_id, parent_id) VALUES (21, 19);
INSERT INTO student_parent (student_id, parent_id) VALUES (22, 20);
INSERT INTO student_parent (student_id, parent_id) VALUES (23, 21);
INSERT INTO student_parent (student_id, parent_id) VALUES (24, 22);


INSERT INTO student_teacher (student_id, teacher_id) VALUES (3, 1);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (8, 1);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (5, 2);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (9, 2);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (7, 3);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (13, 3);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (1, 4);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (10, 4);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (4, 5);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (11, 5);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (14, 5);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (2, 6);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (6, 6);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (12, 6);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (15, 1); 
INSERT INTO student_teacher (student_id, teacher_id) VALUES (16, 2); 
INSERT INTO student_teacher (student_id, teacher_id) VALUES (17, 3);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (18, 4); 
INSERT INTO student_teacher (student_id, teacher_id) VALUES (19, 5); 
INSERT INTO student_teacher (student_id, teacher_id) VALUES (20, 6); 
INSERT INTO student_teacher (student_id, teacher_id) VALUES (21, 1); 
INSERT INTO student_teacher (student_id, teacher_id) VALUES (22, 2);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (23, 3);
INSERT INTO student_teacher (student_id, teacher_id) VALUES (24, 4);