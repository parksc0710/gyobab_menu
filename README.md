# 오늘의 교밥
<br>
https://www.gyobab.shop
<br><br>

# 사이트
- 소셜로그인 가능
- 유저 이미지 업로드 및 출력 가능
- 게시판

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

- 게시판 테이블<br>
CREATE TABLE `board` (
  `board_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_type` varchar(45) DEFAULT NULL,
  `board_tit` varchar(100) NOT NULL,
  `board_txt` varchar(2000) DEFAULT NULL,
  `board_thumb` varchar(200) NULL,
  `board_member` int(11) NOT NULL,
  `board_view` int(11) DEFAULT 0,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  `act_flg` bit(1) DEFAULT b'1',
  `del_flg` bit(1) DEFAULT b'0',
  PRIMARY KEY (`board_id`),
  KEY `board_member` (`board_member`),
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`board_member`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='게시판 테이블';

- 게시판 좋아요 테이블<br>
CREATE TABLE `board_like` (
  `board_like_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`board_like_id`),
  KEY `board_id` (`board_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `board_like_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`) ON DELETE CASCADE,
  CONSTRAINT `board_like_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8 COMMENT='게시판 좋아요 테이블';

- 게시판 댓글 테이블<br>
CREATE TABLE `board_comment` (
  `board_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_comment_parent` int(11) NULL,
  `board_comment_board` int(11) NOT NULL,
  `board_comment_txt` varchar(500) DEFAULT NULL,
  `board_comment_member` int(11) NOT NULL,
  `board_comment_parent_member` int(11) NULL,
  `board_comment_depth` int(11) NOT NULL,
  `board_comment_order` int(11) NOT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  `act_flg` bit(1) DEFAULT b'1',
  `del_flg` bit(1) DEFAULT b'0',
  PRIMARY KEY (`board_comment_id`),
  CONSTRAINT FOREIGN KEY (`board_comment_parent`) REFERENCES `board_comment` (`board_comment_id`),
  CONSTRAINT FOREIGN KEY (`board_comment_board`) REFERENCES `board` (`board_id`),
  CONSTRAINT FOREIGN KEY (`board_comment_member`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='게시판 댓글 테이블';


<br><br>

# To Do List <br>
- 게시판 검색 기능 추가
- 댓글 알림 기능 추가
- ~~게시판 세부 카테고리 기능 추가~~ -> 2021. 05. 26 
- ~~공지사항 최신 글 메인 노출 연동하기~~ -> 2021. 05. 25 완료
- ~~이미지 업로드시 리사이즈 기능 추가~~ -> 2021. 05. 24 완료
- ~~공지사항 게시판 추가하기~~ -> 2021. 05. 24 완료
- ~~게시판 대댓글 기능 추가하기~~ -> 2021. 05. 22 완료
- ~~게시판 댓글 기능 추가하기~~ -> 2021. 05. 22 완료
- ~~게시판 좋아요 기능 추가하기~~ -> 2021. 05. 19 완료
- ~~게시판 페이징 기능 추가하기~~ -> 2021. 05. 18 완료
- ~~메뉴 등록 게시판 기능 추가하기~~ -> 2021. 05. 12 완료
- ~~회원 탈퇴 기능 및 권한 수정 기능 추가하기~~ -> 2021. 05. 10 완료
- ~~일반 USER 출입 바코드 이미지 업로드 및 출력 기능 개발하기~~ -> 2021. 05. 09 완료
- ~~일반 USER 개인 정보 조회 및 수정 기능 개발~~ -> 2021. 05. 09 완료

