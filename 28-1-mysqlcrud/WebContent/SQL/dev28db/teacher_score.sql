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

-- 테이블 dev28db의 구조를 덤프합니다. teacher_score
CREATE TABLE IF NOT EXISTS `teacher_score` (
  `teacher_score_no` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_no` int(10) DEFAULT NULL,
  `score` int(100) DEFAULT NULL,
  PRIMARY KEY (`teacher_score_no`),
  KEY `FK_teacher_report_teacher` (`teacher_no`),
  CONSTRAINT `FK_teacher_report_teacher` FOREIGN KEY (`teacher_no`) REFERENCES `teacher` (`teacher_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table dev28db.teacher_score: ~3 rows (대략적)
/*!40000 ALTER TABLE `teacher_score` DISABLE KEYS */;
INSERT INTO `teacher_score` (`teacher_score_no`, `teacher_no`, `score`) VALUES
	(2, 35, 100),
	(3, 36, 90),
	(4, 37, 95),
	(5, 38, 80),
	(6, 39, 70);
/*!40000 ALTER TABLE `teacher_score` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
