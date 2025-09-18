USE ITIexaminationSystem;
GO

------------------------------------------------------------
-- 1) Department
------------------------------------------------------------
INSERT INTO Department (DeptID, DeptName, IsActive)
VALUES
    (1,'Industrial Systems',1),
    (2,'Content Development',1),
    (3,'Cyber Security & Infrastructure',1),
    (4,'Information Systems',1),
    (5,'Software Engineering',1),
    (6,'Cognitive Computing $ AI',1),
    (7,'Software Testing & Validation',1);
------------------------------------------------------------

------------------------------------------------------------
-- 2) Track
------------------------------------------------------------
INSERT INTO Track (TrackID, TrackName, Dept_ID, TotalHours, [Description], IsActive)
VALUES
(1,'Digital IC Design',1,972,'This track focuses on teaching participants the principles and techniques of designing digital integrated circuits (ICs). It covers topics such as digital logic design, RTL, coding, synthesis, verification, and physical design. Participants will gain hands-on experience with industry-standard EDA (Electronic Design Automation) tools and methodologies.',1),
(2,'Industrial Automation',1,984,'The Industrial Automation track covers topics such as control systems, programmable logic controllers (PLCs), human-machine interfaces (HMIs), industrial networks, and robotics. Participants gain practical experience in designing, implementing, and troubleshooting automation solutions for manufacturing, process control, and industrial monitoring applications.',1),
(3,'Game Programming',2,900,'The Game Programming track trains individuals in game development, starting with basic common concepts and advancing to state-of-the-art engines. It covers not just mobile, console, and PC, but also extended reality (VR/AR). Graduates can apply their skills to simulations, architecture, education, and more. The track includes learning advanced game engines (Unity, Unreal) and programming languages (C++ and C#), equipping graduates with versatile capabilities beyond traditional gaming.',1),
(4,'3D Animation',2,972,'The 3D Animation track focuses on teaching participants the skills and techniques required to create immersive and realistic 3D animations. It covers various aspects such as modeling, texturing, rigging, and animation. Participants will gain hands-on experience using industry-standard software to bring their creative visions to life in the world of 3D animation.',1),
(5,'System Aministration',3,1506,'The Systems Administration track covers topics such as system installation, configuration, maintenance, and troubleshooting. Participants gain practical experience in managing and supporting various types of computer systems, including servers, networks, and operating systems. Participants also learn about backup and recovery strategies, virtualization, cloud computing, and monitoring systems to optimize system performance and availability.',1),
(6,'Cyber Security',3,1506,'This track focuses on teaching participants the principles of securing digital systems and networks from cyber threats. It covers topics such as network security, cryptography, ethical hacking, incident response, and risk management. Participants will gain hands-on experience in identifying vulnerabilities, implementing security measures, and mitigating risks. The track emphasizes best practices for protecting data, ensuring privacy, and maintaining the integrity of information systems.',1),
(7,'Data Management',4,957,'The Data Management track focuses on teaching participants the principles and techniques of effectively managing and organizing data. It covers topics such as data modeling, database design, data integration, data governance, and data quality management. Participants will gain practical skills in data manipulation, storage, retrieval, and analysis. The track emphasizes best practices for ensuring data accuracy, consistency, security, and compliance with regulatory requirements.',1),
(8,'Data Science',4,960,'This track focuses on teaching the fundamental concepts of data science. It covers topics such as data exploration, data preprocessing, statistical analysis, machine learning, and data visualization. Participants will gain hands-on experience with popular tools and languages used in data science. The track emphasizes practical application of data science techniques in solving real-world problems, extracting insights from data, and making data-driven decisions.',1),
(9,'Open Source Applications Development',5,1110,'The Open Source Applications Development track focuses on developing applications using open source technologies and frameworks. It covers topics such as open source software, collaborative development, version control, and community engagement. The track emphasizes the importance of open collaboration, transparency, and community-driven innovation in software development. Graduates are equipped with skills to create and enhance applications in the open source ecosystem.',1),
(10,'Web & UI Development',5,1014,'The Web & User Interface Development track focuses on topics such as HTML, CSS, JavaScript, responsive design, front-end frameworks, and UI/UX principles. Participants gain practical experience in building interactive and visually appealing websites and web applications. They learn to create user-friendly interfaces, optimize web performance, and ensure cross-browser compatibility.',1),
(11,'AI & Machine Learning',6,1431,'The AI and Machine Learning track provides a comprehensive understanding of AI and its applications. It covers concepts like supervised/unsupervised learning, neural networks, deep learning, and natural language processing. Practical aspects include data preprocessing, model evaluation, and optimization. Participants gain hands-on experience and a solid foundation in AI principles. Prerequisites: basic programming, statistics, and linear algebra.',1),
(12,'Software Testing & Quality Assurance',7,1100,'This program delves into the core of software testing and QA, empowering you to become a versatile professional. Master various testing roles, from functional testers ensuring software behaves as intended, to automation testers streamlining processes with code. Identify bugs like a pro, guarantee functionality, and champion user satisfaction. Become a key player in building high-quality software and shaping exceptional user experiences',1);
------------------------------------------------------------

------------------------------------------------------------
-- 3) Branch
------------------------------------------------------------
INSERT INTO Branch (BranchID, BranchName)
VALUES
 (1,'Smart Village'),(2,'New Capital'),(3,'Cairo University'),(4,'Alexandria'),(5,'Assiut'),(6,'Aswan'),(7,'Beni Suef'),
 (8,'Fayoum'),(9,'Ismailia'),(10,'Mansoura'),(11,'Menofia'),(12,'Minya'),(13,'Qena'),(14,'Sohag'),(15,'Tanta'),(16,'Zagazig'),
 (17,'New Valley'),(18,'Damanhour'),(19,'Al Arish'),(20,'Banha'),(21,'Port Said');
------------------------------------------------------------

------------------------------------------------------------
-- 4) Class  (table is (Branch_ID, Class_Number))
------------------------------------------------------------
INSERT INTO [Class] (Branch_ID, Class_Number) 
VALUES
 (1,'SV-101'),(1,'SV-102'),(1,'SV-103'),(1,'SV-104'),(1,'SV-105'),
 (2,'NC-201'),(2,'NC-202'),(2,'NC-203'),(2,'NC-204'),(2,'NC-205'),
 (3,'CU-301'),(3,'CU-302'),(3,'CU-303'),(3,'CU-304'),(3,'CU-305'),
 (4,'ALX-401'),(4,'ALX-402'),(4,'ALX-403'),(4,'ALX-404'),(4,'ALX-405'),
 (5,'AST-501'),(5,'AST-502'),(5,'AST-503'),(5,'AST-504'),(5,'AST-505'),
 (6,'ASN-601'),(6,'ASN-602'),(6,'ASN-603'),(6,'ASN-604'),(6,'ASN-605'),
 (7,'BS-701'),(7,'BS-702'),(7,'BS-703'),(7,'BS-704'),(7,'BS-705'),
 (8,'FY-801'),(8,'FY-802'),(8,'FY-803'),(8,'FY-804'),(8,'FY-805'),
 (9,'IS-901'),(9,'IS-902'),(9,'IS-903'),(9,'IS-904'),(9,'IS-905'),
 (10,'MAN-1001'),(10,'MAN-1002'),(10,'MAN-1003'),(10,'MAN-1005'),(10,'MAN-1004'),
 (11,'MN-1101'),(11,'MN-1102'),(11,'MN-1103'),(11,'MN-1104'),(11,'MN-1105'),
 (12,'MY-1201'),(12,'MY-1202'),(12,'MY-1203'),(12,'MY-1204'),(12,'MY-1205'),
 (13,'QN-1301'),(13,'QN-1302'),(13,'QN-1303'),(13,'QN-1304'),(13,'QN-1305'),
 (14,'SH-1401'),(14,'SH-1402'),(14,'SH-1403'),(14,'SH-1404'),(14,'SH-1405'),
 (15,'TN-1501'),(15,'TN-1502'),(15,'TN-1504'),(15,'TN-1505'),(15,'TN-1503'),
 (16,'ZG-1601'),(16,'ZG-1602'),(16,'ZG-1603'),(16,'ZG-1604'),(16,'ZG-1605'),
 (17,'NV-1701'),(17,'NV-1702'),(17,'NV-1703'),(17,'NV-1704'),(17,'NV-1705'),
 (18,'DM-1801'),(18,'DM-1802'),(18,'DM-1803'),(18,'DM-1804'),(18,'DM-1805'),
 (19,'AR-1901'),(19,'AR-1902'),(19,'AR-1903'),(19,'AR-1904'),(19,'AR-1905'),
 (20,'BH-2001'),(20,'BH-2002'),(20,'BH-2004'),(20,'BH-2003'),(20,'BH-2005'),
 (21,'PS-2101'),(21,'PS-2102'),(21,'PS-2103'),(21,'PS-2104'),(21,'PS-2105');
------------------------------------------------------------

------------------------------------------------------------
-- 5) Intake  (table uses IsActive BIT, not [Status])
-- Map Archived->0, Ongoing->1
------------------------------------------------------------
INSERT INTO Intake (IntakeID, IntakeName, StartDate, EndDate, IsActive)
VALUES
 (1,'Intake 1','1993-04-01','1993-12-31',0),
 (2,'Intake 2','1993-10-01','1994-06-30',0),
 (3,'Intake 3','1994-04-01','1994-12-31',0),
 (4,'Intake 4','1994-10-01','1995-06-30',0),
 (5,'Intake 5','1995-04-01','1995-12-31',0),
 (6,'Intake 6','1995-10-01','1996-06-30',0),
 (7,'Intake 7','1996-04-01','1996-12-31',0),
 (8,'Intake 8','1996-10-01','1997-06-30',0),
 (9,'Intake 9','1997-04-01','1997-12-31',0),
 (10,'Intake 10','1997-10-01','1998-06-30',0),
 (11,'Intake 11','1998-04-01','1998-12-31',0),
 (12,'Intake 12','1998-10-01','1999-06-30',0),
 (13,'Intake 13','1999-04-01','1999-12-31',0),
 (14,'Intake 14','1999-10-01','2000-06-30',0),
 (15,'Intake 15','2000-04-01','2000-12-31',0),
 (16,'Intake 16','2000-10-01','2001-06-30',0),
 (17,'Intake 17','2001-04-01','2001-12-31',0),
 (18,'Intake 18','2001-09-01','2002-05-31',0),
 (19,'Intake 19','2002-04-01','2002-12-31',0),
 (20,'Intake 20','2002-10-01','2003-06-30',0),
 (21,'Intake 21','2003-04-01','2004-08-31',0),
 (22,'Intake 22','2003-10-01','2004-06-30',0),
 (23,'Intake 23','2004-04-01','2005-08-31',0),
 (24,'Intake 24','2004-10-01','2005-06-30',0),
 (25,'Intake 25','2005-04-01','2006-08-31',0),
 (26,'Intake 26','2005-10-01','2006-06-30',0),
 (27,'Intake 27','2006-10-01','2007-06-30',0),
 (28,'Intake 28','2007-10-01','2008-06-30',0),
 (29,'Intake 29','2008-10-01','2009-06-30',0),
 (30,'Intake 30','2009-10-01','2010-06-30',0),
 (31,'Intake 31','2010-10-01','2011-06-30',0),
 (32,'Intake 32','2011-10-01','2012-06-30',0),
 (33,'Intake 33','2012-10-01','2013-06-30',0),
 (34,'Intake 34','2013-10-01','2014-06-29',0),
 (35,'Intake 35','2014-10-01','2015-06-30',0),
 (36,'Intake 36','2015-10-01','2016-06-30',0),
 (37,'Intake 37','2016-10-01','2017-06-30',0),
 (38,'Intake 38','2017-10-01','2018-06-30',0),
 (39,'Intake 39','2018-10-01','2019-06-30',0),
 (40,'Intake 40','2019-10-01','2020-06-30',0),
 (41,'Intake 41','2020-10-01','2021-06-30',0),
 (42,'Intake 42','2021-10-10','2022-06-30',0),
 (43,'Intake 43','2022-10-02','2023-06-30',0),
 (45,'Intake 45','2024-10-13','2025-06-30',0),
 (46,'Intake 46','2025-10-12','2026-06-30',1);
------------------------------------------------------------

------------------------------------------------------------
-- 6) Open
------------------------------------------------------------
INSERT INTO [Open] (Track_ID, Intake_ID, Branch_ID)
VALUES
(1,1,1),(2,1,2),(3,2,3),(4,2,4),(5,3,5),(6,3,6),(7,4,7),(8,4,8),(9,5,9),(10,5,10),(11,6,11),(12,6,12),(1,7,13),(2,7,14),(3,8,15),(4,8,16),
(5,9,17),(6,9,18),(7,10,19),(8,10,20),(9,11,21),(10,11,1),(11,12,2),(12,12,3),(1,13,4),(3,13,5),(5,14,6),(7,14,7),(9,15,8),(11,15,9),
(2,16,10),(4,16,11),(6,17,12),(8,17,13),(10,18,14),(12,18,15),(1,19,16),(5,19,17),(9,20,18),(2,20,19),(6,21,20),(10,21,21),
(3,22,1),(7,22,2),(11,23,3),(4,23,4),(8,24,5),(12,24,6),(1,25,7),(9,25,8),(2,26,9),(10,26,10),(3,27,11),(11,27,12),(4,28,13),(12,28,14),
(5,29,15),(1,29,16),(6,30,17),(2,30,18),(7,31,19),(3,31,20),(8,32,21),(4,32,1),(9,33,2),(5,33,3),(10,34,4),(6,34,5),
(11,35,6),(7,35,7),(12,36,8),(8,36,9),(1,37,10),(9,37,11),(2,38,12),(10,38,13),(3,39,14),(11,39,15),(4,40,16),(12,40,17),
(5,41,18),(1,41,19),(6,42,20),(2,42,21),(7,43,1),(3,43,2),(8,45,3),(4,45,4),(9,46,5),(5,46,6),(10,46,7),(6,46,8),(11,46,9),(7,46,10),
(12,46,11),(8,46,12);
------------------------------------------------------------

------------------------------------------------------------
-- 7) Role
------------------------------------------------------------
INSERT INTO [Role] (RoleID, RoleName)
VALUES
 (1,'Student'),
 (2,'Instructor'),
 (3,'Admin'),
 (4,'Training Manager');
------------------------------------------------------------

------------------------------------------------------------
-- 8) One manager user + assign as Branch manager
------------------------------------------------------------
INSERT INTO [User]
(UserID, Role_ID, [Name], [Address], Email, [Password], Phone, DOB, Branch_ID, Dept_ID, Track_ID, IsActive)
VALUES
(1,4,'Abbas','Cairo','ITI_Manager@Outlook.com','Ana-Elmodeeer1','+201012345678','1920-01-01',NULL,NULL,NULL,1);

UPDATE Branch
SET Manager_UID = (SELECT UserID FROM [User] WHERE Role_ID = 4);
------------------------------------------------------------

------------------------------------------------------------
-- 9) Bulk Users (Admins, Instructors, Students)  -- last column is IsActive
------------------------------------------------------------

INSERT INTO [User] 
(UserID, Role_ID, [Name], [Address], Email, [Password], Phone, DOB, Branch_ID, Dept_ID, Track_ID, IsActive)
VALUES
(76,3,'Heba Mahmoud','Cairo','hebamahmoud76@outlook.com','Pass7676','+201000000076','1986-02-12',1,NULL,NULL,0),
(77,3,'Adel Mostafa','Alexandria','adelmostafa77@outlook.com','Pass7777','+201000000077','1984-07-23',2,NULL,NULL,1),
(78,3,'Nadia Gamal','Mansoura','nadiagamal78@outlook.com','Pass7878','+201000000078','1991-11-17',3,NULL,NULL,1),
(79,3,'Sherif Ali','Assiut','sherifali79@outlook.com','Pass7979','+201000000079','1988-09-30',4,NULL,NULL,0),

(80,1,'Mona Mostafa','Cairo','monamostafa80@outlook.com','Pass8080','+201000000080','1976-06-14',1,3,NULL,1),
(81,1,'Hossam Yasser','Alexandria','hossamyasser81@outlook.com','Pass8181','+201000000081','1974-03-09',2,1,NULL,1),
(82,1,'Rania Lotfy','Mansoura','ranialotfy82@outlook.com','Pass8282','+201000000082','1982-10-27',3,2,NULL,1),
(83,1,'Amr Samir','Assiut','amrsamir83@outlook.com','Pass8383','+201000000083','1979-01-20',4,4,NULL,1),
(84,1,'Huda Adel','Cairo','hudaadel84@outlook.com','Pass8484','+201000000084','1981-05-15',1,2,NULL,1),
(85,1,'Mahmoud Salem','Alexandria','mahmoudsalem85@outlook.com','Pass8585','+201000000085','1978-09-03',2,3,NULL,1),
(86,1,'Aya Mohamed','Mansoura','ayamohamed86@outlook.com','Pass8686','+201000000086','1985-04-25',3,1,NULL,0),
(87,1,'Ibrahim Farid','Assiut','ibrahimfarid87@outlook.com','Pass8787','+201000000087','1977-08-11',4,2,NULL,1),
(88,1,'Nourhan Tamer','Cairo','nourhantamer88@outlook.com','Pass8888','+201000000088','1983-12-30',1,4,NULL,1),
(89,1,'Salwa Ezzat','Alexandria','salwaezzat89@outlook.com','Pass8989','+201000000089','1976-11-19',2,2,NULL,1),
(90,1,'Khaled Ashraf','Mansoura','khaledashraf90@outlook.com','Pass9090','+201000000090','1980-07-22',3,3,NULL,1),
(91,1,'Lamiaa Fathy','Assiut','lamiaafathy91@outlook.com','Pass9191','+201000000091','1979-02-05',4,1,NULL,1),

(92,2,'Omar Wael','Cairo','omarwael92@outlook.com','Pass9292','+201000000092','2000-08-10',1,NULL,2,1),
(93,2,'Aya Khaled','Alexandria','ayakhaled93@outlook.com','Pass9393','+201000000093','2002-05-14',2,NULL,3,1),
(94,2,'Youssef Gamal','Mansoura','youssefgamal94@outlook.com','Pass9494',NULL,'1999-10-29',3,NULL,1,1),
(95,2,'Mariam Samy','Assiut','mariamsamy95@outlook.com','Pass9595',NULL,'2001-06-02',4,NULL,4,1),
(96,2,'Hassan Ahmed','Cairo','hassanahmed96@outlook.com','Pass9696',NULL,'2000-12-19',1,NULL,3,1),
(97,2,'Nourhan Khalil','Alexandria','nourhankhalil97@outlook.com','Pass9797',NULL,'1998-11-08',2,NULL,1,1),
(98,2,'Mostafa Saber','Mansoura','mostafasaber98@outlook.com','Pass9898',NULL,'2002-01-23',3,NULL,2,1),
(99,2,'Sara Hassan','Assiut','sarahassan99@outlook.com','Pass9999',NULL,'1999-09-09',4,NULL,3,1),
(100,2,'Mohamed Nabil','Cairo','mohamednabil100@outlook.com','Pass1000',NULL,'2000-03-11',1,NULL,4,1),
(101,2,'Nada Tarek','Alexandria','nadatarek101@outlook.com','Pass1010',NULL,'2001-07-25',2,NULL,2,1),
(102,2,'Karim Ali','Mansoura','karimali102@outlook.com','Pass1020',NULL,'1998-04-18',3,NULL,3,0),
(103,2,'Dalia Hassan','Assiut','daliahassan103@outlook.com','Pass1030',NULL,'2002-10-12',4,NULL,1,1),
(104,2,'Sherif Younes','Cairo','sherifyounes104@outlook.com','Pass1040',NULL,'2000-02-28',1,NULL,2,1),
(105,2,'Mona Hisham','Alexandria','monahisham105@outlook.com','Pass1050',NULL,'2001-09-17',2,NULL,4,1),
(106,2,'Ola Saad','Mansoura','olasaad106@outlook.com','Pass1060',NULL,'2000-06-08',3,NULL,2,1),
(107,2,'Yasmin Mostafa','Assiut','yasminmostafa107@outlook.com','Pass1070',NULL,'1999-12-01',4,NULL,3,1),
(108,2,'Hatem Ibrahim','Cairo','hatemibrahim108@outlook.com','Pass1080',NULL,'2002-05-21',1,NULL,1,1),
(109,2,'Laila Ayman','Alexandria','lailaayman109@outlook.com','Pass1090',NULL,'2000-07-15',2,NULL,2,1),
(110,2,'Ibrahim Salah','Mansoura','ibrahimsalah110@outlook.com','Pass1100',NULL,'2001-03-09',3,NULL,4,1),
(111,2,'Farida Zaki','Assiut','faridazaki111@outlook.com','Pass1110',NULL,'1998-08-28',4,NULL,1,1),
(112,2,'Ahmed Fathy','Cairo','ahmedfathy112@outlook.com','Pass1120',NULL,'2000-01-16',1,NULL,3,1),
(113,2,'Nadia Saber','Alexandria','nadiasaber113@outlook.com','Pass1130',NULL,'2002-04-05',2,NULL,1,0),
(114,2,'Hussein Lotfy','Mansoura','husseinlotfy114@outlook.com','Pass1140',NULL,'1999-06-29',3,NULL,2,1),
(115,2,'Salma Ragab','Assiut','salmaragab115@outlook.com','Pass1150',NULL,'2001-11-14',4,NULL,4,1),
(116,2,'Omar Ezzat','Cairo','omarezzat116@outlook.com','Pass1160',NULL,'2000-09-03',1,NULL,2,1),
(117,2,'Reem Adel','Alexandria','reemadel117@outlook.com','Pass1170',NULL,'1998-12-24',2,NULL,3,1),
(118,2,'Tamer Hany','Mansoura','tamerhany118@outlook.com','Pass1180',NULL,'2002-08-07',3,NULL,4,1),
(119,2,'Aya Wael','Assiut','ayawael119@outlook.com','Pass1190',NULL,'1999-05-13',4,NULL,1,1),
(120,2,'Mohamed Tamer','Cairo','mohamedtamer120@outlook.com','Pass1200',NULL,'2001-07-01',1,NULL,2,0),
(121,2,'Lobna Hassan','Alexandria','lobnahassan121@outlook.com','Pass1210',NULL,'2000-02-22',2,NULL,4,1),
(122,2,'Yara Ibrahim','Mansoura','yaraibrahim122@outlook.com','Pass1220',NULL,'2002-10-19',3,NULL,3,1),
(123,2,'Walid Samir','Assiut','walidsamir123@outlook.com','Pass1230',NULL,'1999-01-30',4,NULL,2,1),
(124,2,'Dina Khaled','Cairo','dinakhaled124@outlook.com','Pass1240',NULL,'2001-06-25',1,NULL,1,1),
(125,2,'Mustafa Ashraf','Alexandria','mustafaashraf125@outlook.com','Pass1250',NULL,'1998-09-05',2,NULL,2,1),
(126,2,'Mariam Ali','Alexandria','mariamali126@outlook.com','Pass126126',NULL,'2000-06-21',1,NULL,4,0),
(127,2,'Hassan Reda','Cairo','hassanreda127@outlook.com','Pass127127',NULL,'1999-08-18',2,NULL,3,1),
(128,1,'Noha Fawzy','Assiut','nohafawzy128@outlook.com','Pass128128',NULL,'1982-04-11',3,2,NULL,1),
(129,1,'Mahmoud Khaled','Mansoura','mahmoudkhaled129@outlook.com','Pass129129',NULL,'1979-10-15',4,1,NULL,1),
(130,2,'Aya Nabil','Alexandria','ayanabil130@outlook.com','Pass130130',NULL,'2001-12-25',1,NULL,2,1),
(131,2,'Karim Youssef','Cairo','karimyoussef131@outlook.com','Pass131131',NULL,'2000-07-30',2,NULL,1,1),
(132,1,'Laila Mohamed','Assiut','lailamohamed132@outlook.com','Pass132132',NULL,'1986-05-22',3,4,NULL,0),
(133,2,'Nour Tamer','Mansoura','nourtamer133@outlook.com','Pass133133',NULL,'1999-11-14',4,NULL,3,1);
------------------------------------------------------------

------------------------------------------------------------
-- 10) Course  (column names: MaxDegree, MinDegree)
------------------------------------------------------------
INSERT INTO Course (CourseID, CourseName, [Description], MaxDegree, MinDegree)
VALUES
(1,'Introduction to Programming','Basics of programming using Python.',100,50),
(2,'Database Fundamentals','Introduction to relational databases and SQL.',100,50),
(3,'Web Development Basics','HTML, CSS, and JavaScript essentials.',100,50),
(4,'Data Structures & Algorithms','Core algorithms and data handling techniques.',100,50),
(5,'Operating Systems Concepts','Processes, threads, and memory management.',100,50),
(6,'Computer Networks','Networking models, TCP/IP, and routing basics.',100,50),
(7,'Software Engineering','Principles of software design and SDLC.',100,50),
(8,'Object-Oriented Programming','OOP concepts using Java.',100,50),
(9,'Advanced SQL','Stored procedures, triggers, indexing, and optimization.',100,50),
(10,'Cloud Computing','Cloud models and AWS fundamentals.',100,50),
(11,'Cyber Security Basics','Fundamentals of security threats and defenses.',100,50),
(12,'Mobile App Development','Developing Android and iOS applications.',100,50),
(13,'Artificial Intelligence','AI concepts, search, and problem solving.',100,50),
(14,'Machine Learning','Supervised and unsupervised ML algorithms.',100,50),
(15,'Deep Learning','Neural networks and TensorFlow basics.',100,50),
(16,'Business Intelligence','Data visualization and reporting with Power BI.',100,50),
(17,'Big Data Analytics','Hadoop, Spark, and large-scale data processing.',100,50),
(18,'Cloud Databases','Managing databases in cloud environments.',100,50),
(19,'Web Security','Defending against XSS, CSRF, and SQL injection.',100,50),
(20,'API Development','Building and consuming RESTful APIs.',100,50),
(21,'Agile Project Management','Scrum, Kanban, and agile practices.',100,50),
(22,'DevOps Fundamentals','CI/CD pipelines and automation tools.',100,50),
(23,'Linux Administration','Linux shell scripting and server setup.',100,50),
(24,'Ethical Hacking','Penetration testing and ethical hacking techniques.',100,50),
(25,'Data Mining','Extracting useful insights from datasets.',100,50),
(26,'Natural Language Processing','Text mining and language models.',100,50),
(27,'Robotics Programming','Programming robots using Python and C++.',100,50),
(28,'Computer Graphics','Rendering, transformations, and 3D basics.',100,50),
(29,'Embedded Systems','Microcontrollers and IoT devices programming.',100,50),
(30,'Software Testing','Manual and automated testing principles.',100,50),
(31,'UI/UX Design','Designing user-friendly interfaces and experiences.',100,50),
(32,'Blockchain Basics','Understanding blockchain and smart contracts.',100,50),
(33,'Virtualization & Containers','Docker and Kubernetes fundamentals.',100,50),
(34,'Cloud Security','Securing applications and infrastructure in the cloud.',100,50),
(35,'Parallel Computing','Multithreading and parallel programming concepts.',100,50),
(36,'Data Warehousing','ETL processes and data warehouse design.',100,50),
(37,'Information Retrieval','Search engines and indexing techniques.',100,50),
(38,'Computer Vision','Image recognition and processing with OpenCV.',100,50),
(39,'Game Development','Building games with Unity and Unreal Engine.',100,50),
(40,'IoT Fundamentals','Connecting smart devices with IoT protocols.',100,50),
(41,'Data Visualization','Using Tableau and matplotlib for insights.',100,50),
(42,'Mobile Security','Protecting mobile applications and data.',100,50),
(43,'Software Architecture','Designing scalable system architectures.',100,50),
(44,'Compiler Design','Lexical analysis, parsing, and code generation.',100,50),
(45,'Distributed Systems','Consistency, replication, and fault tolerance.',100,50),
(46,'Quantum Computing','Principles of quantum algorithms.',100,50),
(47,'Cloud Storage Solutions','Scalable and secure storage in the cloud.',100,50),
(48,'API Security','Securing APIs with OAuth and JWT.',100,50),
(49,'Digital Forensics','Investigating and analyzing cyber incidents.',100,50),
(50,'Enterprise Systems','ERP and enterprise application integration.',100,50);
------------------------------------------------------------

------------------------------------------------------------
-- 11) Track_Course
------------------------------------------------------------
INSERT INTO Track_Course (Track_ID, Course_ID) VALUES
-- Digital IC Design
(1,4),(1,5),(1,8),(1,23),(1,29),(1,33),(1,35),(1,44),
-- Industrial Automation
(2,5),(2,6),(2,27),(2,29),(2,40),(2,22),(2,33),
-- Game Programming
(3,3),(3,4),(3,8),(3,13),(3,14),(3,15),(3,28),(3,38),(3,39),
-- 3D Animation
(4,3),(4,28),(4,31),(4,39),
-- System Administration
(5,5),(5,6),(5,10),(5,22),(5,23),(5,33),(5,34),(5,47),
-- Cyber Security
(6,6),(6,11),(6,19),(6,24),(6,34),(6,42),(6,48),(6,49),
-- Data Management
(7,2),(7,9),(7,16),(7,18),(7,25),(7,36),(7,37),
-- Data Science
(8,1),(8,2),(8,13),(8,14),(8,15),(8,16),(8,25),(8,26),(8,38),(8,41),
-- Open Source Applications Dev
(9,7),(9,10),(9,20),(9,21),(9,22),(9,32),(9,43),
-- Web & UI Development
(10,3),(10,7),(10,20),(10,31),(10,19),(10,42),(10,48),
-- AI & Machine Learning
(11,13),(11,14),(11,15),(11,26),(11,35),(11,38),(11,46),
-- Software Testing & QA
(12,7),(12,21),(12,22),(12,30),(12,43), (8, 12), (8, 17)
------------------------------------------------------------

------------------------------------------------------------
-- 12) Randomly assign students to courses in their own track
------------------------------------------------------------
INSERT INTO UserTakes (User_ID, Course_ID)
SELECT U.UserID, C.Course_ID
FROM [User] U
JOIN Track_Course C ON U.Track_ID = C.Track_ID
WHERE U.Role_ID = 2
  AND (ABS(CHECKSUM(NEWID())) % 2 = 0);
------------------------------------------------------------

------------------------------------------------------------
-- 13) Randomly assign INSTRUCTORS to courses in their department across all branches
-- Teach requires 4 cols: (User_ID, Course_ID, Branch_ID, Track_ID)
------------------------------------------------------------
INSERT INTO Teach (User_ID, Course_ID, Branch_ID, Track_ID)
SELECT DISTINCT U.UserID, TC.Course_ID, B.BranchID, TC.Track_ID
FROM [User] U
JOIN Track        T  ON T.Dept_ID = U.Dept_ID
JOIN Track_Course TC ON TC.Track_ID = T.TrackID
CROSS JOIN Branch B
WHERE U.Role_ID = 1 AND U.IsActive = 1
  AND (ABS(CHECKSUM(NEWID())) % 2 = 0)
  AND NOT EXISTS (
      SELECT 1
      FROM Teach te
      WHERE te.User_ID  = U.UserID
        AND te.Course_ID= TC.Course_ID
        AND te.Branch_ID= B.BranchID
        AND te.Track_ID = TC.Track_ID
  );
------------------------------------------------------------

------------------------------------------------------------
-- 14) QuestionPool (use NEWID() per row for random Course_ID)
------------------------------------------------------------
INSERT INTO QuestionPool (QPID, Course_ID, [Type], [Description])
VALUES
(1, (ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'What is the main concept of topic 1?'),
(2, (ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain the key points of topic 2.'),
(3, (ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 3 is essential. True or False?'),
(4, (ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which statement is correct about topic 4?'),
(5, (ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Describe the main features of topic 5.'),
(6, (ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 6 has no impact. True or False?'),
(7, (ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Identify the correct statement for topic 7.'),
(8, (ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Summarize topic 8 briefly.'),
(9, (ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 9 is only theoretical. True or False?'),
(10,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which example best represents topic 10?'),
(11,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain the importance of topic 11.'),
(12,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 12 cannot be applied. True or False?'),
(13,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Choose the correct option for topic 13.'),
(14,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Describe the main idea of topic 14.'),
(15,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 15 is outdated. True or False?'),
(16,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which is correct about topic 16?'),
(17,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Summarize topic 17 in your own words.'),
(18,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 18 is fundamental. True or False?'),
(19,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Select the right answer for topic 19.'),
(20,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain the process described in topic 20.'),
(21,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 21 is irrelevant. True or False?'),
(22,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which statement about topic 22 is correct?'),
(23,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Provide a summary of topic 23.'),
(24,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 24 is crucial. True or False?'),
(25,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Identify the key point of topic 25.'),
(26,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Describe topic 26 in detail.'),
(27,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 27 has no effect. True or False?'),
(28,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Choose the best option for topic 28.'),
(29,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain topic 29 thoroughly.'),
(30,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 30 is optional. True or False?'),
(31,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which choice is correct for topic 31?'),
(32,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Summarize the main idea of topic 32.'),
(33,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 33 cannot be ignored. True or False?'),
(34,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Identify the correct fact about topic 34.'),
(35,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain topic 35 briefly.'),
(36,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 36 is always relevant. True or False?'),
(37,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Select the right answer for topic 37.'),
(38,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Describe topic 38 comprehensively.'),
(39,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 39 is insignificant. True or False?'),
(40,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which statement is accurate about topic 40?'),
(41,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Summarize the key points of topic 41.'),
(42,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 42 has major importance. True or False?'),
(43,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Choose the correct statement for topic 43.'),
(44,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain the significance of topic 44.'),
(45,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 45 is optional. True or False?'),
(46,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Identify the key aspect of topic 46.'),
(47,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Provide a summary of topic 47.'),
(48,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 48 is fundamental. True or False?'),
(49,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which choice is correct for topic 49?'),
(50,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain topic 50 in detail.'),
(51,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 1 has no impact. True or False?'),
(52,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Select the correct statement for topic 2.'),
(53,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Summarize topic 3 briefly.'),
(54,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 4 is crucial. True or False?'),
(55,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Which fact about topic 5 is correct?'),
(56,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Explain topic 6 thoroughly.'),
(57,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 7 can be ignored. True or False?'),
(58,(ABS(CHECKSUM(NEWID())) % 50)+1, 'MCQ',       'Identify the correct choice for topic 8.'),
(59,(ABS(CHECKSUM(NEWID())) % 50)+1, 'Text',      'Describe topic 9 in your own words.'),
(60,(ABS(CHECKSUM(NEWID())) % 50)+1, 'TrueFalse', 'Topic 10 is outdated. True or False?');
------------------------------------------------------------

------------------------------------------------------------
-- 15) Answer_MCQ
------------------------------------------------------------
INSERT INTO Answer_MCQ (QP_ID, OptionID, [Option], IS_Correct)
VALUES
-- MCQ questions
(1,1,'Option A for Q1',1),(1,2,'Option B for Q1',0),(1,3,'Option C for Q1',0),(1,4,'Option D for Q1',0),
(4,1,'Option A for Q4',0),(4,2,'Option B for Q4',1),(4,3,'Option C for Q4',0),(4,4,'Option D for Q4',0),
(7,1,'Option A for Q7',0),(7,2,'Option B for Q7',0),(7,3,'Option C for Q7',1),(7,4,'Option D for Q7',0),
(10,1,'Option A for Q10',0),(10,2,'Option B for Q10',0),(10,3,'Option C for Q10',0),(10,4,'Option D for Q10',1),
(13,1,'Option A for Q13',0),(13,2,'Option B for Q13',1),(13,3,'Option C for Q13',0),(13,4,'Option D for Q13',0),
(16,1,'Option A for Q16',1),(16,2,'Option B for Q16',0),(16,3,'Option C for Q16',0),(16,4,'Option D for Q16',0),
(19,1,'Option A for Q19',0),(19,2,'Option B for Q19',1),(19,3,'Option C for Q19',0),(19,4,'Option D for Q19',0),
(22,1,'Option A for Q22',0),(22,2,'Option B for Q22',0),(22,3,'Option C for Q22',1),(22,4,'Option D for Q22',0),
(25,1,'Option A for Q25',0),(25,2,'Option B for Q25',1),(25,3,'Option C for Q25',0),(25,4,'Option D for Q25',0),
(28,1,'Option A for Q28',1),(28,2,'Option B for Q28',0),(28,3,'Option C for Q28',0),(28,4,'Option D for Q28',0),
(31,1,'Option A for Q31',0),(31,2,'Option B for Q31',0),(31,3,'Option C for Q31',1),(31,4,'Option D for Q31',0),
(34,1,'Option A for Q34',0),(34,2,'Option B for Q34',1),(34,3,'Option C for Q34',0),(34,4,'Option D for Q34',0),
(37,1,'Option A for Q37',1),(37,2,'Option B for Q37',0),(37,3,'Option C for Q37',0),(37,4,'Option D for Q37',0),
(40,1,'Option A for Q40',0),(40,2,'Option B for Q40',0),(40,3,'Option C for Q40',1),(40,4,'Option D for Q40',0),
(43,1,'Option A for Q43',0),(43,2,'Option B for Q43',1),(43,3,'Option C for Q43',0),(43,4,'Option D for Q43',0),
(46,1,'Option A for Q46',1),(46,2,'Option B for Q46',0),(46,3,'Option C for Q46',0),(46,4,'Option D for Q46',0),
(49,1,'Option A for Q49',0),(49,2,'Option B for Q49',0),(49,3,'Option C for Q49',1),(49,4,'Option D for Q49',0),
(52,1,'Option A for Q52',1),(52,2,'Option B for Q52',0),(52,3,'Option C for Q52',0),(52,4,'Option D for Q52',0),
(55,1,'Option A for Q55',0),(55,2,'Option B for Q55',1),(55,3,'Option C for Q55',0),(55,4,'Option D for Q55',0),
(58,1,'Option A for Q58',0),(58,2,'Option B for Q58',0),(58,3,'Option C for Q58',1),(58,4,'Option D for Q58',0),

-- True/False questions
(3,1,'True',1),(3,2,'False',0),
(6,1,'True',0),(6,2,'False',1),
(9,1,'True',0),(9,2,'False',1),
(12,1,'True',1),(12,2,'False',0),
(15,1,'True',0),(15,2,'False',1),
(18,1,'True',1),(18,2,'False',0),
(21,1,'True',0),(21,2,'False',1),
(24,1,'True',1),(24,2,'False',0),
(27,1,'True',0),(27,2,'False',1),
(30,1,'True',1),(30,2,'False',0),
(33,1,'True',0),(33,2,'False',1),
(36,1,'True',1),(36,2,'False',0),
(39,1,'True',0),(39,2,'False',1),
(42,1,'True',1),(42,2,'False',0),
(45,1,'True',0),(45,2,'False',1),
(48,1,'True',1),(48,2,'False',0),
(51,1,'True',0),(51,2,'False',1),
(54,1,'True',1),(54,2,'False',0),
(57,1,'True',0),(57,2,'False',1),
(60,1,'True',1),(60,2,'False',0);
------------------------------------------------------------

INSERT INTO Answer_Text (QP_ID, Answer)
VALUES
(2 , N'Topic 2 focuses on scalability, modular design, and ease of maintenance.'),
(5 , N'Main features include user-friendly interfaces, strong security, and reliability.'),
(8 , N'Topic 8 can be summarized as applying algorithms efficiently to solve real problems.'),
(11, N'Topic 11 is important because it provides foundational knowledge for advanced study.'),
(14, N'The main idea of topic 14 is collaboration and integration between systems.'),
(17, N'Topic 17 highlights efficiency, accuracy, and usability in real-world applications.'),
(20, N'The process in topic 20 involves planning, execution, and validation.'),
(23, N'Topic 23 emphasizes problem solving through structured analysis and reasoning.'),
(26, N'Topic 26 is described in detail as steps for implementing secure systems.'),
(29, N'Topic 29 deals with advanced modeling and predictive techniques.'),
(32, N'The main idea of topic 32 is improving performance and optimization.'),
(35, N'Topic 35 explains the importance of continuous improvement in processes.'),
(38, N'Topic 38 covers comprehensive methods for handling large-scale datasets.'),
(41, N'Topic 41 key points are clarity, structure, and practical application.'),
(44, N'Topic 44 significance lies in its role in connecting theory to practice.'),
(47, N'Topic 47 summary: innovation, adaptability, and sustainability.'),
(50, N'Topic 50 in detail includes architecture, design, and testing phases.'),
(53, N'Topic 3 summary: balancing complexity and usability for end-users.'),
(56, N'Topic 6 thorough explanation: applying layered security and monitoring.'),
(59, N'Topic 9 described as practical frameworks for improving efficiency.');

------------------------------------------------------------
-- 16) Exam  (must include Branch_ID and [User_ID])
-- pick a valid active instructor + a branch
------------------------------------------------------------
------------------------------------------------------------
-- 16) Exam  (must include Branch_ID, Track_ID, [User_ID])
-- pick a valid active instructor + a branch
------------------------------------------------------------
DECLARE @ExamCreator INT =
 (SELECT TOP 1 UserID FROM dbo.[User] WHERE Role_ID = 1 AND IsActive = 1 ORDER BY UserID);
DECLARE @ExamBranch INT = 1;

INSERT INTO Exam (
    ExamID, Course_ID, Start_Time, End_Time, [Date], Score, ExamType,
    Branch_ID, Track_ID, [User_ID]
)
SELECT
    v.ExamID,
    v.Course_ID,
    v.Start_Time,
    v.End_Time,
    v.[Date],
    v.Score,
    v.ExamType,
    @ExamBranch                                   AS Branch_ID,
    tc.Track_ID                                   AS Track_ID,
    @ExamCreator                                  AS [User_ID]
FROM (VALUES
 (5,  3,'09:00','11:00','2025-02-22',100,'normal'),
 (6,  3,'13:00','15:00','2025-08-18',100,'corrective'),
 (7,  4,'10:00','12:00','2025-03-11', 90,'normal'),
 (8,  4,'14:00','16:00','2025-06-25', 90,'normal'),
 (9,  5,'09:00','11:00','2025-04-02', 80,'normal'),
 (10, 5,'13:00','15:00','2025-07-10', 80,'corrective'),
 (11, 6,'08:30','10:30','2025-05-05',100,'normal'),
 (12, 6,'12:30','14:30','2025-11-12',100,'normal'),
 (13, 7,'09:00','11:00','2025-02-14', 70,'normal'),
 (14, 7,'13:00','15:00','2025-08-03', 70,'corrective'),
 (15, 8,'10:00','12:00','2025-04-18',100,'normal'),
 (16, 8,'14:00','16:00','2025-10-22',100,'normal'),
 (17, 9,'09:00','11:00','2025-03-01', 85,'normal'),
 (18, 9,'13:00','15:00','2025-07-15', 85,'corrective'),
 (19,10,'09:00','11:00','2025-05-20',100,'normal'),
 (20,10,'13:00','15:00','2025-09-29',100,'normal'),
 (21,11,'10:00','12:00','2025-04-08', 95,'normal'),
 (22,11,'14:00','16:00','2025-10-30', 95,'corrective'),
 (23,12,'09:00','11:00','2025-02-25', 75,'normal'),
 (24,12,'13:00','15:00','2025-06-12', 75,'normal'),
 (25,13,'08:30','10:30','2025-03-20',100,'normal'),
 (26,13,'12:30','14:30','2025-08-27',100,'normal'),
 (27,14,'09:00','11:00','2025-05-14', 90,'normal'),
 (28,14,'13:00','15:00','2025-11-05', 90,'corrective'),
 (29,15,'10:00','12:00','2025-04-01',100,'normal'),
 (30,15,'14:00','16:00','2025-09-21',100,'normal'),
 (31,16,'09:00','11:00','2025-06-18', 80,'normal'),
 (32,16,'13:00','15:00','2025-10-02', 80,'corrective'),
 (33,17,'08:30','10:30','2025-02-07',100,'normal'),
 (34,17,'12:30','14:30','2025-07-07',100,'normal'),
 (35,18,'09:00','11:00','2025-03-15', 85,'normal'),
 (36,18,'13:00','15:00','2025-09-14', 85,'normal'),
 (37,19,'10:00','12:00','2025-04-10', 90,'normal'),
 (38,19,'14:00','16:00','2025-11-19', 90,'corrective'),
 (39,20,'09:00','11:00','2025-05-02',100,'normal'),
 (40,20,'13:00','15:00','2025-08-12',100,'normal'),
 (41,21,'08:30','10:30','2025-02-19', 80,'normal'),
 (42,21,'12:30','14:30','2025-07-22', 80,'corrective'),
 (43,22,'09:00','11:00','2025-03-27', 95,'normal'),
 (44,22,'13:00','15:00','2025-09-09', 95,'normal'),
 (45,23,'10:00','12:00','2025-04-16',100,'normal'),
 (46,23,'14:00','16:00','2025-10-11',100,'corrective'),
 (47,24,'09:00','11:00','2025-06-01', 70,'normal'),
 (48,24,'13:00','15:00','2025-11-08', 70,'normal'),
 (49,25,'08:30','10:30','2025-02-28',100,'normal'),
 (50,25,'12:30','14:30','2025-08-05',100,'normal'),
 (51,26,'09:00','11:00','2025-03-12', 90,'normal'),
 (52,26,'13:00','15:00','2025-07-30', 90,'corrective'),
 (53,27,'10:00','12:00','2025-05-09', 85,'normal'),
 (54,27,'14:00','16:00','2025-09-26', 85,'normal')
) AS v(ExamID, Course_ID, Start_Time, End_Time, [Date], Score, ExamType)
OUTER APPLY (
    SELECT TOP 1 Track_ID
    FROM dbo.Track_Course tc
    WHERE tc.Course_ID = v.Course_ID
    ORDER BY tc.Track_ID
) tc;
------------------------------------------------------------

------------------------------------------------------------
-- 17) Choose  (table is (Exam_ID, QP_ID, Degree) — no User_ID column)
------------------------------------------------------------
INSERT INTO Choose (Exam_ID, QP_ID, Degree)
VALUES
-- Exam 5 (10 questions)
(5,1,1),(5,3,2),(5,4,5),(5,6,4),(5,7,10),(5,10,2),(5,12,3),(5,13,6),(5,16,8),(5,19,7),

-- Exam 6 (10 questions)
(6,2,2),(6,5,1),(6,8,6),(6,9,2),(6,11,3),(6,14,4),(6,15,5),(6,18,9),(6,20,6),(6,21,2),

-- Exam 7 (10 questions)
(7,22,1),(7,24,2),(7,25,3),(7,27,6),(7,28,5),(7,30,9),(7,31,9),(7,33,4),(7,34,5),(7,36,6);
------------------------------------------------------------
INSERT INTO dbo.StudentAnswer (User_ID, Exam_ID, QP_ID, Student_Answer, QScore) VALUES
(92, 5, 1,  N'Option A for Q1', NULL),
(92, 5, 3,  N'True', NULL),
(92, 5, 4,  N'Option B for Q4', NULL),
(92, 5, 6,  N'False', NULL),
(92, 5, 7,  N'Option C for Q7', NULL);


