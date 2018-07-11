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

-- 테이블 dev28db의 구조를 덤프합니다. employer_addr
CREATE TABLE IF NOT EXISTS `employer_addr` (
  `employer_addr_no` int(10) NOT NULL AUTO_INCREMENT,
  `employer_no` int(10) DEFAULT NULL,
  `employer_addr_content` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employer_addr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- Dumping data for table dev28db.employer_addr: ~2 rows (대략적)
/*!40000 ALTER TABLE `employer_addr` DISABLE KEYS */;
INSERT INTO `employer_addr` (`employer_addr_no`, `employer_no`, `employer_addr_content`) VALUES
	(1, 1, '전주시'),
	(2, 2, '서울'),
	(3, 3, '부산'),
	(4, 4, '대구'),
	(5, 5, '천안'),
	(6, 6, '구미');
/*!40000 ALTER TABLE `employer_addr` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
