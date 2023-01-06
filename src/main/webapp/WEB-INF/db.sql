-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.18-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- shop 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `shop`;

-- 테이블 shop.auth_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth_info` (
  `auth_code` int(11) NOT NULL,
  `auth_memo` text NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`auth_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.auth_info:~3 rows (대략적) 내보내기
INSERT INTO `auth_info` (`auth_code`, `auth_memo`, `createdate`) VALUES
	(1, '상품관리', '2023-01-05 14:22:11'),
	(2, '상품관리,주문관리,공지관리', '2023-01-05 14:22:30'),
	(3, '상품관리,주문관리,공지관리,사원관리', '2023-01-05 14:22:46');

-- 테이블 shop.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `goods_code` int(11) NOT NULL,
  `customer_id` varchar(100) NOT NULL,
  `cart_quantity` int(11) NOT NULL COMMENT '카트 물건 수량',
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`goods_code`,`customer_id`),
  KEY `FK_cart_customer` (`customer_id`),
  CONSTRAINT `FK_cart_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_cart_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.cart:~0 rows (대략적) 내보내기

-- 테이블 shop.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_code` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(100) NOT NULL,
  `customer_pw` varchar(100) NOT NULL COMMENT '반정규화',
  `customer_name` varchar(100) NOT NULL,
  `customer_phone` varchar(100) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `point` int(11) NOT NULL COMMENT '반정규화',
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customer_code`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.customer:~1 rows (대략적) 내보내기
INSERT INTO `customer` (`customer_code`, `customer_id`, `customer_pw`, `customer_name`, `customer_phone`, `level`, `point`, `createdate`) VALUES
	(1, 'goodee', '1234', '구원이', '1234-1234-1234', 0, 0, '2023-01-05 11:54:46'),
	(2, '1234', '1234', '1234', '1234', 0, 0, '2023-01-06 00:00:00');

-- 테이블 shop.customer_address 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer_address` (
  `address_code` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`address_code`),
  KEY `FK__customer` (`customer_id`),
  CONSTRAINT `FK__customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.customer_address:~0 rows (대략적) 내보내기
INSERT INTO `customer_address` (`address_code`, `customer_id`, `address`, `createdate`) VALUES
	(3, 'goodee', '가산', '2023-01-06 01:34:11');

-- 테이블 shop.emp 구조 내보내기
CREATE TABLE IF NOT EXISTS `emp` (
  `emp_code` int(11) NOT NULL AUTO_INCREMENT,
  `emp_id` varchar(100) NOT NULL,
  `emp_pw` varchar(100) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `active` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT 'Y 계정사용가능, N 계정사용불가',
  `auth_code` int(11) DEFAULT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  `level` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`emp_code`),
  UNIQUE KEY `emp_id` (`emp_id`),
  KEY `FK_emp_auth_info` (`auth_code`),
  CONSTRAINT `FK_emp_auth_info` FOREIGN KEY (`auth_code`) REFERENCES `auth_info` (`auth_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.emp:~0 rows (대략적) 내보내기
INSERT INTO `emp` (`emp_code`, `emp_id`, `emp_pw`, `emp_name`, `active`, `auth_code`, `createdate`, `level`) VALUES
	(1, 'admin', '1234', '관리자', 'N', 1, '2023-01-05 11:53:53', 1);

-- 테이블 shop.goods 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods` (
  `goods_code` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(100) NOT NULL,
  `goods_price` int(11) NOT NULL,
  `goods_category` enum('건강식품','육류','육가공류','과일','기름') NOT NULL,
  `soldout` enum('Y','N') NOT NULL COMMENT 'Y 품절',
  `emp_id` varchar(100) NOT NULL COMMENT '상품등록한 스텝ID',
  `hit` int(11) NOT NULL DEFAULT 0,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`goods_code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.goods:~25 rows (대략적) 내보내기
INSERT INTO `goods` (`goods_code`, `goods_name`, `goods_price`, `goods_category`, `soldout`, `emp_id`, `hit`, `createdate`) VALUES
	(1, '테스트상품', 5000, '건강식품', 'N', 'testEmpId', 0, '2023-01-04 16:11:34'),
	(2, '테스트상품2', 50000, '육류', 'N', 'testEmpId', 0, '2023-01-04 16:11:44'),
	(3, '테스트상품3', 4000, '육가공류', 'N', 'testEmpId', 0, '2023-01-04 16:11:45'),
	(4, '테스트상품4', 10000, '과일', 'N', 'testEmpId', 0, '2023-01-04 16:12:26'),
	(5, '테스트상품5', 6000, '기름', 'N', 'testEmpId', 0, '2023-01-04 16:12:27'),
	(6, '테스트상품6', 100000, '건강식품', 'Y', 'testEmpId', 0, '2023-01-04 16:15:43'),
	(7, '테스트상품7', 55000, '육가공류', 'N', 'testEmpId', 0, '2023-01-04 18:25:20'),
	(8, '테스트상품8', 7800, '과일', 'N', 'testEmpId', 0, '2023-01-04 18:25:32'),
	(9, '테스트상품9', 10000, '건강식품', 'N', 'testEmpId', 0, '2023-01-04 18:25:35'),
	(10, '소고기', 210000, '육류', 'N', 'testEmpId', 1, '2023-01-04 18:25:37'),
	(11, '돼지고기', 80000, '육류', 'Y', 'testEmpId', 0, '2023-01-04 18:25:39'),
	(12, '포도씨유', 45000, '기름', 'N', 'testEmpId', 0, '2023-01-04 18:25:41'),
	(13, '닭고기', 30000, '육류', 'N', 'testEmpId', 0, '2023-01-04 18:25:44'),
	(14, '해바라기유', 51000, '기름', 'N', 'testEmpId', 0, '2023-01-04 18:25:48'),
	(15, '카놀라유', 42000, '기름', 'N', 'testEmpId', 0, '2023-01-04 18:25:50'),
	(16, '올리브오일', 60000, '기름', 'Y', 'testEmpId', 0, '2023-01-04 18:25:52'),
	(17, '트러플오일', 62000, '기름', 'N', 'testEmpId', 1, '2023-01-04 18:26:09'),
	(18, '스팸', 33000, '육가공류', 'N', 'testEmpId', 1, '2023-01-04 18:26:21'),
	(19, '비타민', 43000, '건강식품', 'N', 'testEmpId', 0, '2023-01-04 18:26:32'),
	(20, '참치', 36000, '육가공류', 'N', 'testEmpId', 0, '2023-01-04 18:27:07'),
	(21, '소세지', 20000, '육가공류', 'N', 'testEmpId', 0, '2023-01-04 18:27:21'),
	(22, '영양보조제', 79000, '건강식품', 'N', 'testEmpId', 1, '2023-01-04 18:27:21'),
	(23, '귤', 49000, '과일', 'N', 'testEmpId', 0, '2023-01-04 18:27:23'),
	(24, '샤인머스켓', 49000, '과일', 'N', 'testEmpId', 0, '2023-01-04 18:27:24'),
	(25, '사과', 39500, '과일', 'N', 'testEmpId', 0, '2023-01-04 18:27:26');

-- 테이블 shop.goods_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods_img` (
  `goods_code` int(11) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `origin_name` varchar(100) NOT NULL,
  `content_type` varchar(100) NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`goods_code`),
  CONSTRAINT `FK_goods_img_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.goods_img:~25 rows (대략적) 내보내기
INSERT INTO `goods_img` (`goods_code`, `filename`, `origin_name`, `content_type`, `createdate`) VALUES
	(1, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 16:15:18'),
	(2, '파일명2.jpg', '원본파일명2', '파일유형', '2023-01-04 16:15:43'),
	(3, '파일명3.jpg', '원본파일명3', '파일유형', '2023-01-04 16:15:58'),
	(4, '파일명4.jpg', '원본파일명4', '파일유형', '2023-01-04 16:16:09'),
	(5, '파일명5.jpg', '원본파일명5', '파일유형', '2023-01-04 16:16:23'),
	(6, '파일명6.jpg', '원본파일명6', '파일유형', '2023-01-04 16:17:25'),
	(7, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:01'),
	(8, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:04'),
	(9, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:05'),
	(10, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:08'),
	(11, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:09'),
	(12, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:11'),
	(13, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:12'),
	(14, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:14'),
	(15, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:16'),
	(16, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:18'),
	(17, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:19'),
	(18, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:30'),
	(19, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:32'),
	(20, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:34'),
	(21, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:35'),
	(22, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:37'),
	(23, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:38'),
	(24, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:40'),
	(25, '파일명.jpg', '원본파일명', '파일유형', '2023-01-04 18:34:42');

-- 테이블 shop.notice 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice` (
  `notice_code` int(11) NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(200) NOT NULL,
  `notice_content` text NOT NULL,
  `emp_id` varchar(100) NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`notice_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.notice:~2 rows (대략적) 내보내기
INSERT INTO `notice` (`notice_code`, `notice_title`, `notice_content`, `emp_id`, `createdate`) VALUES
	(1, '테스트 공지 제목 수정', '테스트 공지 내용 수정', '테스트', '2023-01-05 11:02:14'),
	(2, '테스트 공지 추가(수정)', '테스트 공지 추가입니다.(수정)', 'admin', '2023-01-06 09:21:01');

-- 테이블 shop.orders 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders` (
  `order_code` int(11) NOT NULL AUTO_INCREMENT,
  `goods_code` int(11) NOT NULL,
  `customer_id` varchar(100) NOT NULL,
  `address_code` int(11) NOT NULL,
  `order_quantity` int(11) NOT NULL,
  `order_price` int(11) NOT NULL,
  `order_state` enum('결제','취소','배송중','배송완료','구매확정') NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_code`),
  KEY `FK_orders_goods` (`goods_code`),
  KEY `FK_orders_customer` (`customer_id`),
  KEY `FK_orders_customer_address` (`address_code`),
  CONSTRAINT `FK_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orders_customer_address` FOREIGN KEY (`address_code`) REFERENCES `customer_address` (`address_code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_orders_goods` FOREIGN KEY (`goods_code`) REFERENCES `goods` (`goods_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.orders:~0 rows (대략적) 내보내기
INSERT INTO `orders` (`order_code`, `goods_code`, `customer_id`, `address_code`, `order_quantity`, `order_price`, `order_state`, `createdate`) VALUES
	(2, 25, 'goodee', 3, 2, 5000, '구매확정', '0000-00-00 00:00:00');

-- 테이블 shop.outid 구조 내보내기
CREATE TABLE IF NOT EXISTS `outid` (
  `id` varchar(100) NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp() COMMENT '탈퇴일'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='새로운 아이디 생성시 outid + emp + customer 존재하지 않는 아이디 생성가능';

-- 테이블 데이터 shop.outid:~0 rows (대략적) 내보내기

-- 테이블 shop.point_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `point_history` (
  `order_code` int(11) NOT NULL,
  `point_kind` enum('적립','사용') NOT NULL,
  `point` int(11) NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_code`,`point_kind`),
  CONSTRAINT `FK__orders` FOREIGN KEY (`order_code`) REFERENCES `orders` (`order_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='포인트 이력테이블';

-- 테이블 데이터 shop.point_history:~0 rows (대략적) 내보내기

-- 테이블 shop.pw_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `pw_history` (
  `customer_id` varchar(100) NOT NULL,
  `pw` varchar(100) NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customer_id`,`pw`),
  CONSTRAINT `FK__pw_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='pw변경이력이 고객댕 최근 3개까지만';

-- 테이블 데이터 shop.pw_history:~0 rows (대략적) 내보내기

-- 테이블 shop.question 구조 내보내기
CREATE TABLE IF NOT EXISTS `question` (
  `question_code` int(11) NOT NULL AUTO_INCREMENT,
  `order_code` int(11) NOT NULL,
  `category` enum('배송','반품','교환','기타') NOT NULL,
  `question_title` text NOT NULL,
  `question_memo` text NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`question_code`),
  KEY `FK_question_orders` (`order_code`) USING BTREE,
  CONSTRAINT `FK_question_orders` FOREIGN KEY (`order_code`) REFERENCES `orders` (`order_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.question:~0 rows (대략적) 내보내기
INSERT INTO `question` (`question_code`, `order_code`, `category`, `question_title`, `question_memo`, `createdate`) VALUES
	(1, 2, '배송', '문의합니다', '수정수정수정', '2023-01-06 01:35:25');

-- 테이블 shop.question_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `question_comment` (
  `comment_code` int(11) NOT NULL AUTO_INCREMENT,
  `question_code` int(11) NOT NULL,
  `comment_memo` text NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`comment_code`),
  KEY `FK__question` (`question_code`),
  CONSTRAINT `FK__question` FOREIGN KEY (`question_code`) REFERENCES `question` (`question_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.question_comment:~0 rows (대략적) 내보내기
INSERT INTO `question_comment` (`comment_code`, `question_code`, `comment_memo`, `createdate`) VALUES
	(1, 1, '답변입니다', '2023-01-06 01:36:21');

-- 테이블 shop.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `order_code` int(11) NOT NULL,
  `review_memo` text NOT NULL,
  `createdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_code`) USING BTREE,
  CONSTRAINT `FK_review_orders` FOREIGN KEY (`order_code`) REFERENCES `orders` (`order_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='orders테이블에서 order_state값이 구매확정이 되면 고객이 review 등록 가능';

-- 테이블 데이터 shop.review:~0 rows (대략적) 내보내기
INSERT INTO `review` (`order_code`, `review_memo`, `createdate`) VALUES
	(2, '리뷰입니다', '2023-01-06 01:37:24');

-- 테이블 shop.site_counter 구조 내보내기
CREATE TABLE IF NOT EXISTS `site_counter` (
  `counter_date` date NOT NULL DEFAULT curdate(),
  `couter_num` int(11) NOT NULL,
  PRIMARY KEY (`counter_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 shop.site_counter:~0 rows (대략적) 내보내기

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
