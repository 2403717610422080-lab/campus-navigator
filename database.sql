-- ====================================================================
-- FIND MY CLASSROOM - CAMPUS NAVIGATOR
-- MySQL Database Schema & Sample Dataset
-- ====================================================================

DROP DATABASE IF EXISTS campus_navigator;
CREATE DATABASE campus_navigator CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campus_navigator;

-- --------------------------------------------------------------------
-- 1. USERS TABLE
-- --------------------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    student_id VARCHAR(50) DEFAULT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(100) DEFAULT 'Computer Science',
    year VARCHAR(20) DEFAULT '3rd Year',
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'STAFF', 'ADMIN') NOT NULL DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 2. CLASSROOMS TABLE
-- --------------------------------------------------------------------
CREATE TABLE classrooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(50) NOT NULL UNIQUE,
    room_name VARCHAR(150) NOT NULL,
    block VARCHAR(50) NOT NULL,
    floor VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL,
    room_type ENUM('Classroom', 'Laboratory', 'Seminar Hall', 'Auditorium', 'Faculty Room', 'Office') NOT NULL,
    capacity INT NOT NULL DEFAULT 60,
    facilities TEXT,
    description TEXT,
    navigation_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 3. CAMPUS_LOCATIONS TABLE
-- --------------------------------------------------------------------
CREATE TABLE campus_locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL,
    location_type VARCHAR(50) NOT NULL,
    block VARCHAR(50) DEFAULT 'Campus Ground',
    floor VARCHAR(50) DEFAULT 'Ground Floor',
    description TEXT,
    key_features TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 4. ROUTES TABLE
-- --------------------------------------------------------------------
CREATE TABLE routes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    route_description TEXT NOT NULL,
    estimated_time VARCHAR(50) DEFAULT '2-3 mins',
    steps TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ====================================================================
-- SAMPLE SEED DATA
-- ====================================================================

-- 1. Users (Admin, Staff, Student)
INSERT INTO users (id, name, student_id, email, department, year, username, password, role) VALUES
(1, 'Campus Administrator', 'ADM-001', 'admin@campus.edu', 'Campus Administration', 'Faculty', 'admin', 'admin123', 'ADMIN'),
(2, 'Prof. Alan Turing', 'STF-102', 'staff@campus.edu', 'Computer Science', 'Faculty', 'staff', 'staff123', 'STAFF'),
(3, 'John Doe', 'STU-2024-001', 'student@campus.edu', 'Computer Science', '3rd Year', 'student', 'student123', 'STUDENT'),
(4, 'Sarah Connor', 'STU-2024-045', 'sarah.c@campus.edu', 'Information Technology', '2nd Year', 'sarah', 'student123', 'STUDENT'),
(5, 'David Warner', 'STU-2024-089', 'david.w@campus.edu', 'Electronics', '4th Year', 'david', 'student123', 'STUDENT');

-- 2. Classrooms, Labs, Seminar Halls & Faculty Rooms
INSERT INTO classrooms (id, room_number, room_name, block, floor, department, room_type, capacity, facilities, description, navigation_path) VALUES
(1, 'A101', 'Introductory Computing Hall', 'A Block', '1st Floor', 'Computer Science', 'Classroom', 65, 'Projector, Smart Board, Wi-Fi, Air Conditioning, Audio System', 'Spacious lecture hall equipped for computer programming and theory classes.', 'Main Gate → East Walkway → A Block Entrance → 1st Floor Left Wing → Room A101'),
(2, 'A102', 'Algorithms Lecture Room', 'A Block', '1st Floor', 'Computer Science', 'Classroom', 60, 'High-Res Projector, Wi-Fi, Whiteboard, Speaker Setup', 'Designated lecture room for Data Structures and Algorithm design lectures.', 'Main Gate → East Walkway → A Block Entrance → 1st Floor Left Wing → Room A102'),
(3, 'A201', 'Software Engineering Class', 'A Block', '2nd Floor', 'Computer Science', 'Classroom', 70, 'Smart Interactive Screen, Wi-Fi, Podium Mic, AC', 'Primary hall for 3rd and 4th year Software Engineering electives.', 'Main Gate → A Block Entrance → Central Staircase / Elevator to 2nd Floor → Turn Right → Room A201'),
(4, 'A202', 'Cyber Security Center', 'A Block', '2nd Floor', 'Information Technology', 'Classroom', 55, 'Dual Monitors, Wi-Fi 6, Smart Board, Biometric Access', 'Dedicated smart classroom for Information Security and Cryptography courses.', 'Main Gate → A Block Entrance → Central Staircase to 2nd Floor → Turn Right → Room A202'),
(5, 'A204', 'Web Technology & Cloud Class', 'A Block', '2nd Floor', 'Computer Science', 'Classroom', 60, 'Projector, Wi-Fi, Smart Board, Air Conditioning, Power Outlets at Desks', 'Main smart room for Web Technology, Full Stack development, and Cloud Computing.', 'Main Gate → A Block Entrance → Central Staircase to 2nd Floor → Walk down North Corridor → Room A204 on Right'),
(6, 'A205', 'AI & Machine Learning Studio', 'A Block', '2nd Floor', 'Computer Science', 'Classroom', 60, '4K Laser Projector, High-Speed Wi-Fi, Surround Audio, Ergonomic Seating', 'Interactive multimedia classroom for Deep Learning and Data Science lectures.', 'Main Gate → A Block Entrance → 2nd Floor North Corridor → Room A205'),

(7, 'B101', 'Circuit Theory & Digital Logic', 'B Block', '1st Floor', 'Electronics', 'Classroom', 65, 'Digital Overhead Projector, Wi-Fi, Digital Oscilloscope demo desk', 'Standard engineering lecture hall for analog and digital electronics.', 'Main Gate → Central Fountain Plaza → B Block Entrance → 1st Floor West Wing → Room B101'),
(8, 'B201', 'Microprocessors & Embedded Class', 'B Block', '2nd Floor', 'Electronics', 'Classroom', 60, 'Smart Board, High-Speed LAN, Workbench Demo Unit', 'Classroom tailored for micro-controllers and embedded systems design courses.', 'Main Gate → B Block Entrance → West Staircase to 2nd Floor → Room B201'),
(9, 'B305', 'VLSI Design & Communication Hall', 'B Block', '3rd Floor', 'Electronics', 'Classroom', 75, 'Acoustic Panels, Projector, Wi-Fi, Central Air Conditioning', 'Large tiered lecture hall for Telecommunication and VLSI Design classes.', 'Main Gate → Central Plaza → B Block Lobby → Elevator to 3rd Floor → Room B305'),
(10, 'B306', 'Signals & Systems Seminar Room', 'B Block', '3rd Floor', 'Electronics', 'Seminar Hall', 90, 'Dual Projectors, Wireless Handheld Mics, Podium, Video Conferencing', 'Used for departmental presentations, guest seminars, and workshops.', 'Main Gate → B Block Lobby → Elevator to 3rd Floor → East Corridor → Room B306'),

(11, 'C101', 'Engineering Mechanics Hall', 'C Block', '1st Floor', 'Mechanical', 'Classroom', 70, 'Drafting Display, Projector, Whiteboards, Heavy-duty work benches', 'Foundation lecture room for Mechanical and Civil engineering students.', 'Main Gate → South Promenade → C Block Main Lobby → 1st Floor Ground Corridor → Room C101'),
(12, 'C202', 'Thermodynamics & Fluid Dynamics', 'C Block', '2nd Floor', 'Mechanical', 'Classroom', 65, 'Smart Projector, Wi-Fi, Demonstration Stand', 'Engineering lecture classroom equipped with digital simulation displays.', 'Main Gate → C Block Lobby → Staircase B to 2nd Floor → Room C202'),
(13, 'C301', 'CAD / CAM Design Class', 'C Block', '3rd Floor', 'Mechanical', 'Classroom', 60, 'Workstation Desks, 4K Projector, High-Speed Network', 'Theory and demonstration room for Computer Aided Manufacturing.', 'Main Gate → C Block Lobby → Elevator to 3rd Floor → Room C301'),

(14, 'LAB-A1', 'Web Technology & Internet Lab', 'A Block', '1st Floor', 'Computer Science', 'Laboratory', 45, '45 Core i7 PC Terminals, Linux/Windows Dual Boot, Gigabit LAN, Projector', 'Equipped for Java, Servlets, JSP, Web Technology, and PHP practical labs.', 'Main Gate → A Block Entrance → 1st Floor East Wing → LAB-A1 (Glass Door)'),
(15, 'LAB-A2', 'Database Systems & SQL Lab', 'A Block', '1st Floor', 'Computer Science', 'Laboratory', 45, '45 High-Spec Workstations, Oracle/MySQL Server Setup, Smart TV Screen', 'Laboratory for Database Management Systems and Big Data analytics.', 'Main Gate → A Block Entrance → 1st Floor East Wing → Next to LAB-A1'),
(16, 'LAB-NET', 'Networking & Cloud Computing Lab', 'A Block', '3rd Floor', 'Information Technology', 'Laboratory', 40, 'Cisco Routers, Switches, Cloud Server Access, Patch Panels', 'Dedicated facility for hands-on computer network configuration and packet analysis.', 'Main Gate → A Block Entrance → Elevator to 3rd Floor → South Wing → LAB-NET'),
(17, 'LAB-ECE', 'Digital Signal Processing Lab', 'B Block', '2nd Floor', 'Electronics', 'Laboratory', 35, 'DSP Kits, Function Generators, CROs, MATLAB Workstations', 'Electronics hardware and signal simulation laboratory.', 'Main Gate → B Block → 2nd Floor West Wing → LAB-ECE'),

(18, 'AUD-MAIN', 'Sir C.V. Raman Grand Auditorium', 'Administrative Block', 'Ground Floor', 'General', 'Auditorium', 500, 'State-of-the-art Surround Sound, Stage Lighting, Dual 4K Laser Screens, Central AC', 'Main campus venue for conferences, cultural fests, orientations, and convocation.', 'Main Gate → Direct straight path across Central Courtyard → Administrative Block Entrance'),
(19, 'SEM-CS', 'Alan Turing Seminar Hall', 'A Block', '3rd Floor', 'Computer Science', 'Seminar Hall', 120, 'Dolby Audio, Video Conferencing, Tiered Theater Seating, Smart Podium', 'Departmental seminar hall for project vivas, paper presentations, and tech talks.', 'Main Gate → A Block → Elevator to 3rd Floor → Center Foyer → Alan Turing Hall'),
(20, 'FAC-CS', 'Computer Science Faculty Lounge & HOD Office', 'A Block', '1st Floor', 'Computer Science', 'Faculty Room', 25, 'Meeting Table, Wi-Fi, Discussion Cubicles, Department Archive', 'Offices of the CS Department Head, Faculty advisors, and student mentors.', 'Main Gate → A Block Entrance → 1st Floor Main Foyer → Room 105 (Faculty Room)');

-- 3. Campus Locations (Blocks, Amenities, Centers)
INSERT INTO campus_locations (id, location_name, location_type, block, floor, description, key_features) VALUES
(1, 'Main Gate & Security Post', 'Entrance', 'Campus Perimeter', 'Ground Floor', 'Primary entry and exit point for students, staff, and campus visitors.', 'Security checkpoint, visitor registration, shuttle drop-off'),
(2, 'A Block (Science & Computing)', 'Academic Block', 'A Block', '4 Floors (G+3)', 'Houses Computer Science and Information Technology departments, computing labs, and seminar halls.', 'CS Labs, Web Tech Lab, Turing Seminar Hall, HOD Office'),
(3, 'B Block (Electronics & Electrical)', 'Academic Block', 'B Block', '4 Floors (G+3)', 'Houses Electronics & Communication and Electrical Engineering departments.', 'DSP Lab, Embedded Systems Lab, VLSI Research Cell'),
(4, 'C Block (Mechanical & Civil)', 'Academic Block', 'C Block', '4 Floors (G+3)', 'Houses Mechanical, Civil Engineering, and robotics workshops.', 'CAD/CAM Lab, Machine Shop, Fluid Mechanics Lab'),
(5, 'Central Library', 'Facility', 'Central Building', '3 Floors (G+2)', 'Three-storey digital and print resource center with over 50,000 books and research journals.', 'Digital Library, Quiet Reading Zones, Discussion Pods, Wi-Fi'),
(6, 'Administrative Block', 'Administrative', 'Admin Block', '2 Floors (G+1)', 'Principal office, Registrar, Admissions, Accounts, Examination Cell, and Main Auditorium.', 'Auditorium, Accounts Section, Examination Cell, Registrar'),
(7, 'Campus Cafeteria & Food Court', 'Recreation', 'Near Student Center', 'Ground Floor', 'Spacious multi-cuisine food court serving snacks, meals, and beverages.', 'Indoor/Outdoor Seating, Juice Bar, Coffee Lounge'),
(8, 'Sports Complex & Gymnasium', 'Recreation', 'West Campus', 'Ground Floor', 'Indoor badminton courts, table tennis, basketball court, and modern fitness center.', 'Gym, Basketball Court, Locker Rooms, Sports Equipment Counter'),
(9, 'Student Parking Zone', 'Facility', 'South Gate Area', 'Ground Floor', 'Designated parking for two-wheelers and four-wheelers with security surveillance.', '24/7 CCTV, EV Charging Points, Covered Bike Parking');

-- 4. Routes (Pre-computed navigation pathways)
INSERT INTO routes (id, source, destination, route_description, estimated_time, steps) VALUES
(1, 'Main Gate', 'A Block (Room A204)', 'Head straight from Main Gate along the East Tree-lined Walkway into A Block entrance. Take the central stairs or elevator to the 2nd floor, and proceed down the north hallway.', '2 mins', '1. Enter via Main Gate\n2. Walk 60m along East Walkway\n3. Enter A Block main foyer\n4. Take central stairs or elevator to 2nd Floor\n5. Walk down North Corridor: Room A204 is on your right.'),
(2, 'Main Gate', 'Central Library', 'Walk straight past the Central Lawn fountain. The Central Library entrance is situated directly opposite the main courtyard.', '2 mins', '1. Enter via Main Gate\n2. Walk straight across the Central Courtyard (80m)\n3. Cross the Fountain Plaza\n4. Library double glass doors are directly ahead on Ground Floor.'),
(3, 'Main Gate', 'B Block (Room B305)', 'Walk along the Central Courtyard, take the West pathway to B Block entrance, and take the elevator to the 3rd floor.', '3 mins', '1. Enter via Main Gate\n2. Follow West pathway around Central Lawn (90m)\n3. Enter B Block main entrance\n4. Take elevator to 3rd Floor\n5. Turn right: Room B305 is at the end of the hall.'),
(4, 'A Block', 'Campus Cafeteria', 'Exit A Block from the West ground exit and follow the paved path past the Student Activity Center directly to the Food Court.', '1.5 mins', '1. Exit A Block Ground Floor West Doors\n2. Walk along the covered canopy (50m)\n3. Cafeteria entrance is on the left.'),
(5, 'Central Library', 'Sir C.V. Raman Auditorium', 'Exit the Library, turn left towards the Administrative Block, and enter the main portico.', '1 min', '1. Exit Library main entrance\n2. Turn left toward Admin Block\n3. Enter main double wooden doors: Auditorium is on the Ground Floor.');
