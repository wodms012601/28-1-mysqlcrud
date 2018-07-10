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

-- 테이블 dev28db의 구조를 덤프합니다. teacher
CREATE TABLE IF NOT EXISTS `teacher` (
  `teacher_no` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_name` varchar(100) CHARACTER SET euckr DEFAULT NULL,
  `teacher_age` int(10) DEFAULT NULL,
  PRIMARY KEY (`teacher_no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

-- Dumping data for table dev28db.teacher: ~3 rows (대략적)
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` (`teacher_no`, `teacher_name`, `teacher_age`) VALUES
	(35, '최윤석', 25),
	(36, '김철수', 23),
	(37, '박수현', 26),
	(38, '탁재은', 23),
	(39, '서상원', 32);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
