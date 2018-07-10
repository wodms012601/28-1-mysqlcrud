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

-- 테이블 dev28db의 구조를 덤프합니다. teacher_addr
CREATE TABLE IF NOT EXISTS `teacher_addr` (
  `teacher_addr_no` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_no` int(10) DEFAULT NULL,
  `teacher_addr_content` varchar(50) CHARACTER SET euckr DEFAULT NULL,
  PRIMARY KEY (`teacher_addr_no`),
  KEY `FK_teacher_addr_teacher` (`teacher_no`),
  CONSTRAINT `FK_teacher_addr_teacher` FOREIGN KEY (`teacher_no`) REFERENCES `teacher` (`teacher_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table dev28db.teacher_addr: ~3 rows (대략적)
/*!40000 ALTER TABLE `teacher_addr` DISABLE KEYS */;
INSERT INTO `teacher_addr` (`teacher_addr_no`, `teacher_no`, `teacher_addr_content`) VALUES
	(5, 35, '서울'),
	(6, 36, '전주'),
	(7, 37, '서울'),
	(8, 38, '전주'),
	(9, 39, '부산');
/*!40000 ALTER TABLE `teacher_addr` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
