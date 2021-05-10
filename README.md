# 오늘의 교밥

<br><br>
# 개발 환경

- Java 1.8
- Spring 3.1.1
- MyBatis
- JSP
- MariaDB 10.2.32
- Tomcat 8.0.9


<br><br>

# DB 세팅

## Database 생성
- create database gyobab;
<br>

## 관리자 USER 생성 및 권한 부여
- create user 'gyobab_admin'@'%' identified by '####';
- grant all privileges on gyobab.* to 'gyobab_admin'@'%';
- flush privileges;
<br>

## 테이블 생성 
- 유저 테이블<br>
CREATE TABLE `member` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_email` varchar(100) NOT NULL,
  `member_name` varchar(45) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  `act_flg` bit(1) DEFAULT b'1',
  `del_flg` bit(1) DEFAULT b'0',
  `member_grant` int(11) DEFAULT NULL,
  `member_pass` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  KEY `member_grant` (`member_grant`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`member_grant`) REFERENCES `grant` (`grant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='회원 테이블';


- 권한 테이블<br>
CREATE TABLE `grant` (
  `grant_id` int(11) NOT NULL AUTO_INCREMENT,
  `grant_name` varchar(45) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  `update_member` int(11) DEFAULT NULL,
  `act_flg` bit(1) DEFAULT b'1',
  `del_flg` bit(1) DEFAULT b'0',
  PRIMARY KEY (`grant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='권한 테이블';

<br><br>

# To Do List <br>
- 메뉴 등록 게시판 기능 추가하기
- 회원 탈퇴 기능 추가하기
- ~~일반 USER 출입 바코드 이미지 업로드 및 출력 기능 개발하기~~ -> 2021. 05. 09 완료
- ~~일반 USER 개인 정보 조회 및 수정 기능 개발~~ -> 2021. 05. 09 완료

