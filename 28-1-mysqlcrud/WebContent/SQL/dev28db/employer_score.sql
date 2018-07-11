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

-- 테이블 dev28db의 구조를 덤프합니다. employer_score
CREATE TABLE IF NOT EXISTS `employer_score` (
  `employer_score_no` int(10) NOT NULL AUTO_INCREMENT,
  `employer_no` int(10) DEFAULT NULL,
  `score` int(10) DEFAULT NULL,
  PRIMARY KEY (`employer_score_no`),
  KEY `FK_employer_score_employer` (`employer_no`),
  CONSTRAINT `FK_employer_score_employer` FOREIGN KEY (`employer_no`) REFERENCES `employer` (`employer_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.employer_score: ~2 rows (대략적)
/*!40000 ALTER TABLE `employer_score` DISABLE KEYS */;
INSERT INTO `employer_score` (`employer_score_no`, `employer_no`, `score`) VALUES
	(1, 1, 90),
	(2, 2, 80),
	(3, 3, 70),
	(4, 4, 60),
	(5, 5, 76),
	(6, 6, 91);
/*!40000 ALTER TABLE `employer_score` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
