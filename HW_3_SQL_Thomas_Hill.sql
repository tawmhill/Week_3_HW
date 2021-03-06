DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS room_dept_access;

CREATE TABLE users (
	employee_id integer,
    first_name varchar(30) NOT NULL,
    department_id integer
    );
    
INSERT INTO users ( employee_id, first_name, department_id) VALUES ( 1, 'Modesto', 1);
INSERT INTO users ( employee_id, first_name, department_id) VALUES ( 2, 'Aiyne', 1);
INSERT INTO users ( employee_id, first_name, department_id) VALUES ( 3, 'Christopher', 2);
INSERT INTO users ( employee_id, first_name, department_id) VALUES ( 4, 'Cheong Woo', 2);
INSERT INTO users ( employee_id, first_name, department_id) VALUES ( 5, 'Saulat', 3);
INSERT INTO users ( employee_id, first_name, department_id) VALUES ( 6, 'Heidy', NULL);
        
CREATE TABLE departments (
	department_id integer PRIMARY KEY,
    department_name varchar(30)
    );
    
INSERT INTO departments ( department_id, department_name) VALUES ( 1, 'I.T');
INSERT INTO departments ( department_id, department_name) VALUES ( 2, 'Sales');
INSERT INTO departments ( department_id, department_name) VALUES ( 3, 'Administration');
INSERT INTO departments ( department_id, department_name) VALUES ( 4, 'Operations');
CREATE TABLE rooms (
	room_id integer PRIMARY KEY,
    room_name varchar(30) NOT NULL
    );
    
INSERT INTO rooms ( room_id, room_name) VALUES ( 1, 'Room 101');
INSERT INTO rooms ( room_id, room_name) VALUES ( 2, 'Room 102');
INSERT INTO rooms ( room_id, room_name) VALUES ( 3, 'Auditorium A');
INSERT INTO rooms ( room_id, room_name) VALUES ( 4, 'Auditorium B');

CREATE TABLE room_dept_access (
	room_id integer NOT NULL REFERENCES rooms(room_id),
    department_id integer REFERENCES departments(department_id),
    CONSTRAINT pk_room_dept_access PRIMARY KEY(room_id, department_id)
    );
    
INSERT INTO room_dept_access ( room_id, department_id) VALUES ( 1, 1);
INSERT INTO room_dept_access ( room_id, department_id) VALUES ( 2, 1);
INSERT INTO room_dept_access ( room_id, department_id) VALUES ( 2, 2);
INSERT INTO room_dept_access ( room_id, department_id) VALUES ( 3, 2);

##Next, write SELECT statements that provide the following information:
##• All groups, and the users in each group. A group should appear even if there are no users assigned 
#to the group.

SELECT d.department_name as Department, u.first_name as "Name" 
FROM departments d LEFT JOIN users u ON u.department_id = d.department_id
ORDER BY d.department_name, u.first_name;

##• All rooms, and the groups assigned to each room. The rooms should appear even if no groups have 
#been assigned to them.

SELECT room_name as Room, department_name as "Department Access"
FROM rooms r LEFT JOIN room_dept_access ra ON ra.room_id = r.room_id
LEFT JOIN departments d ON ra.department_id = d.department_id;

##• A list of users, the groups that they belong to, and the rooms to which they are assigned. 
##This should be sorted alphabetically by user, then by group, then by room.

SELECT first_name as "First Name", department_name as Deptartment, room_name as Room
FROM users u LEFT JOIN departments d ON u.department_id = d.department_id
LEFT JOIN room_dept_access ra ON ra.department_id = d.department_id
LEFT JOIN rooms r ON ra.room_id = r.room_id
ORDER BY u.first_name, d.department_name, r.room_name;