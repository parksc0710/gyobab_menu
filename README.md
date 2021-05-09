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
CREATE TABLE `member` 
( `member_id` int(11) NOT NULL AUTO_INCREMENT, 
`member_email` varchar(100) NOT NULL, 
`member_name` varchar(45) DEFAULT NULL,
`create_date` datetime DEFAULT CURRENT_TIMESTAMP, 
`update_date` datetime DEFAULT CURRENT_TIMESTAMP, 
`act_flg` bit(1) DEFAULT 1, 
`del_flg` bit(1) DEFAULT 0, 
PRIMARY KEY (`member_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT="회원 테이블";

- 권한 테이블<br>
CREATE TABLE `grant` 
( `grant_id` int(11) NOT NULL AUTO_INCREMENT, 
`grant_name` varchar(45) DEFAULT NULL,
`create_date` datetime DEFAULT CURRENT_TIMESTAMP, 
`update_date` datetime DEFAULT CURRENT_TIMESTAMP, 
`update_member` int(11) null,
`act_flg` bit(1) DEFAULT 1, 
`del_flg` bit(1) DEFAULT 0, 
PRIMARY KEY (`grant_id`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT="권한 테이블";

- 맴버-권한 연결 테이블<br>
CREATE TABLE `member_grant` 
( `member_grant_id` int(11) NOT NULL AUTO_INCREMENT, 
`member_id` int(11) ,
`grant_id` int(11),
PRIMARY KEY (`member_grant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT="맴버-권한 테이블";
ALTER TABLE `member_grant` add constraint FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`);
ALTER TABLE `member_grant` add constraint FOREIGN KEY (`grant_id`) REFERENCES `grant`(`grant_id`);



<br><br>

# To Do List <br>
- 일반 USER 개인 정보 조회 및 수정(출입 바코드 업로드 및 출력 기능 포함) 
