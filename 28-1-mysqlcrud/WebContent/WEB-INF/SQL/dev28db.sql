-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        5.5.32 - MySQL Community Server (GPL)
-- 서버 OS:                        Win32
-- HeidiSQL 버전:                  8.0.0.4396
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 테이블 dev28db의 구조를 덤프합니다. employer
CREATE TABLE IF NOT EXISTS `employer` (
  `employer_no` int(10) NOT NULL AUTO_INCREMENT,
  `employer_name` varchar(50) DEFAULT NULL,
  `employer_age` int(10) DEFAULT NULL,
  PRIMARY KEY (`employer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.employer: ~6 rows (대략적)
/*!40000 ALTER TABLE `employer` DISABLE KEYS */;
INSERT INTO `employer` (`employer_no`, `employer_name`, `employer_age`) VALUES
	(1, '최윤석', 24),
	(2, '탁재은', 23),
	(3, '김준영', 25),
	(4, '김정연', 25),
	(5, '김문수', 26),
	(6, '이광재', 27);
/*!40000 ALTER TABLE `employer` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. employer_addr
CREATE TABLE IF NOT EXISTS `employer_addr` (
  `employer_addr_no` int(10) NOT NULL AUTO_INCREMENT,
  `employer_no` int(10) DEFAULT NULL,
  `employer_addr_content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employer_addr_no`),
  KEY `FK_employer_addr_employer` (`employer_no`),
  CONSTRAINT `FK_employer_addr_employer` FOREIGN KEY (`employer_no`) REFERENCES `employer` (`employer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.employer_addr: ~6 rows (대략적)
/*!40000 ALTER TABLE `employer_addr` DISABLE KEYS */;
INSERT INTO `employer_addr` (`employer_addr_no`, `employer_no`, `employer_addr_content`) VALUES
	(1, 1, '전주시'),
	(2, 2, '서울'),
	(3, 3, '부산'),
	(4, 4, '대구'),
	(5, 5, '천안'),
	(6, 6, '구미');
/*!40000 ALTER TABLE `employer_addr` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. employer_score
CREATE TABLE IF NOT EXISTS `employer_score` (
  `employer_score_no` int(10) NOT NULL AUTO_INCREMENT,
  `employer_no` int(10) DEFAULT NULL,
  `score` int(10) DEFAULT NULL,
  PRIMARY KEY (`employer_score_no`),
  KEY `FK_employer_score_employer` (`employer_no`),
  CONSTRAINT `FK_employer_score_employer` FOREIGN KEY (`employer_no`) REFERENCES `employer` (`employer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.employer_score: ~6 rows (대략적)
/*!40000 ALTER TABLE `employer_score` DISABLE KEYS */;
INSERT INTO `employer_score` (`employer_score_no`, `employer_no`, `score`) VALUES
	(1, 1, 90),
	(2, 2, 80),
	(3, 3, 70),
	(4, 4, 60),
	(5, 5, 76),
	(6, 6, 91);
/*!40000 ALTER TABLE `employer_score` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. member
CREATE TABLE IF NOT EXISTS `member` (
  `member_no` int(10) NOT NULL AUTO_INCREMENT,
  `member_name` varchar(50) DEFAULT NULL,
  `member_age` int(10) DEFAULT NULL,
  PRIMARY KEY (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.member: ~6 rows (대략적)
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`member_no`, `member_name`, `member_age`) VALUES
	(1, '송유빈', 24),
	(2, '전재현', 25),
	(3, '서연문', 26),
	(4, '이원상', 27),
	(5, '공세준', 28),
	(6, '정규룡', 29);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. member_addr
CREATE TABLE IF NOT EXISTS `member_addr` (
  `member_addr_no` int(10) NOT NULL AUTO_INCREMENT,
  `member_no` int(10) DEFAULT NULL,
  `member_addr_content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`member_addr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.member_addr: ~4 rows (대략적)
/*!40000 ALTER TABLE `member_addr` DISABLE KEYS */;
INSERT INTO `member_addr` (`member_addr_no`, `member_no`, `member_addr_content`) VALUES
	(1, 1, '서울'),
	(2, 2, '대구'),
	(3, 3, '부산'),
	(4, 4, '구미'),
	(5, 5, '마포'),
	(6, 6, '천안');
/*!40000 ALTER TABLE `member_addr` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. member_score
CREATE TABLE IF NOT EXISTS `member_score` (
  `member_score_no` int(10) NOT NULL AUTO_INCREMENT,
  `member_no` int(10) DEFAULT NULL,
  `score` int(10) DEFAULT NULL,
  PRIMARY KEY (`member_score_no`),
  KEY `FK__member` (`member_no`),
  CONSTRAINT `FK__member` FOREIGN KEY (`member_no`) REFERENCES `member` (`member_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.member_score: ~4 rows (대략적)
/*!40000 ALTER TABLE `member_score` DISABLE KEYS */;
INSERT INTO `member_score` (`member_score_no`, `member_no`, `score`) VALUES
	(1, 1, 85),
	(2, 2, 75),
	(3, 3, 65),
	(4, 4, 76),
	(5, 5, 86),
	(6, 6, 96);
/*!40000 ALTER TABLE `member_score` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. student
CREATE TABLE IF NOT EXISTS `student` (
  `student_no` int(10) NOT NULL AUTO_INCREMENT,
  `student_name` varchar(50) DEFAULT NULL,
  `student_age` int(10) DEFAULT NULL,
  PRIMARY KEY (`student_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.student: ~6 rows (대략적)
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` (`student_no`, `student_name`, `student_age`) VALUES
	(1, '송원민', 25),
	(2, '탁재은', 23),
	(3, '최윤석', 24),
	(4, '홍길동', 26),
	(5, '김길동', 28),
	(6, '이길이', 20);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. student_addr
CREATE TABLE IF NOT EXISTS `student_addr` (
  `student_addr_no` int(10) NOT NULL AUTO_INCREMENT,
  `student_no` int(10) DEFAULT NULL,
  `student_addr_content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`student_addr_no`),
  KEY `FK_student_addr_student` (`student_no`),
  CONSTRAINT `FK_student_addr_student` FOREIGN KEY (`student_no`) REFERENCES `student` (`student_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.student_addr: ~6 rows (대략적)
/*!40000 ALTER TABLE `student_addr` DISABLE KEYS */;
INSERT INTO `student_addr` (`student_addr_no`, `student_no`, `student_addr_content`) VALUES
	(1, 1, '전주시 덕진구'),
	(2, 2, '전주시'),
	(3, 3, '전주시'),
	(4, 4, '서울시'),
	(5, 5, '대전시'),
	(6, 6, '부산');
/*!40000 ALTER TABLE `student_addr` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. student_score
CREATE TABLE IF NOT EXISTS `student_score` (
  `student_score_no` int(10) NOT NULL AUTO_INCREMENT,
  `student_no` int(10) DEFAULT NULL,
  `score` int(10) DEFAULT NULL,
  PRIMARY KEY (`student_score_no`),
  KEY `FK_student_score_student` (`student_no`),
  CONSTRAINT `FK_student_score_student` FOREIGN KEY (`student_no`) REFERENCES `student` (`student_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.student_score: ~6 rows (대략적)
/*!40000 ALTER TABLE `student_score` DISABLE KEYS */;
INSERT INTO `student_score` (`student_score_no`, `student_no`, `score`) VALUES
	(1, 1, 95),
	(2, 2, 94),
	(3, 3, 90),
	(4, 4, 85),
	(5, 5, 80),
	(6, 6, 97);
/*!40000 ALTER TABLE `student_score` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. teacher
CREATE TABLE IF NOT EXISTS `teacher` (
  `teacher_no` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_name` varchar(50) DEFAULT NULL,
  `teacher_age` int(10) DEFAULT NULL,
  PRIMARY KEY (`teacher_no`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.teacher: ~7 rows (대략적)
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` (`teacher_no`, `teacher_name`, `teacher_age`) VALUES
	(35, '최윤석', 25),
	(36, '김철수', 23),
	(37, '박수현', 26),
	(38, '탁재은', 23),
	(39, '서상원', 35),
	(41, '현희문', 27),
	(42, '최지수', 24);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. teacher_addr
CREATE TABLE IF NOT EXISTS `teacher_addr` (
  `teacher_addr_no` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_no` int(10) DEFAULT NULL,
  `teacher_addr_content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`teacher_addr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.teacher_addr: ~7 rows (대략적)
/*!40000 ALTER TABLE `teacher_addr` DISABLE KEYS */;
INSERT INTO `teacher_addr` (`teacher_addr_no`, `teacher_no`, `teacher_addr_content`) VALUES
	(5, 35, '서울'),
	(6, 36, '전주'),
	(7, 37, '서울'),
	(8, 38, '전주'),
	(9, 39, '부산'),
	(10, 41, '전주시 완산구'),
	(11, 42, '전주시 덕진구');
/*!40000 ALTER TABLE `teacher_addr` ENABLE KEYS */;


-- 테이블 dev28db의 구조를 덤프합니다. teacher_score
CREATE TABLE IF NOT EXISTS `teacher_score` (
  `teacher_score_no` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_no` int(10) DEFAULT NULL,
  `score` int(10) DEFAULT NULL,
  PRIMARY KEY (`teacher_score_no`),
  KEY `FK_teacher_score_teacher` (`teacher_no`),
  CONSTRAINT `FK_teacher_score_teacher` FOREIGN KEY (`teacher_no`) REFERENCES `teacher` (`teacher_no`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.teacher_score: ~7 rows (대략적)
/*!40000 ALTER TABLE `teacher_score` DISABLE KEYS */;
INSERT INTO `teacher_score` (`teacher_score_no`, `teacher_no`, `score`) VALUES
	(2, 35, 100),
	(3, 36, 90),
	(4, 37, 95),
	(5, 38, 80),
	(6, 39, 70),
	(7, 41, 85),
	(8, 42, 94);
/*!40000 ALTER TABLE `teacher_score` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
