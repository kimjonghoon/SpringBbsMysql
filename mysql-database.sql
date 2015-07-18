-- 회원테이블 
create table member (
    email varchar(60) PRIMARY KEY,
    passwd varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    mobile varchar(20)
);
 
--권한 테이블
CREATE TABLE authorities (
  email VARCHAR(60) NOT NULL,
  authority VARCHAR(20) NOT NULL,
  CONSTRAINT fk_authorities FOREIGN KEY(email) REFERENCES member(email)
);
 
CREATE UNIQUE INDEX ix_authorities ON authorities(email,authority); 
 
INSERT INTO member VALUES ('hong@gmail.org','1111','홍길동','010-1111-1111');
INSERT INTO member VALUES ('im@gmail.org','1111','임꺽정','010-1111-2222');
 
INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_USER');
INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_ADMIN');
INSERT INTO authorities VALUES ('im@gmail.org','ROLE_USER');
 
-- 게시판 종류
create table board (
    boardcd varchar(20),
    boardnm varchar(40) NOT NULL,
    constraint PK_BOARD PRIMARY KEY(boardcd)
);
 
-- 게시글
create table article (
    articleno int NOT NULL AUTO_INCREMENT,
    boardcd varchar(20),
    title varchar(200) NOT NULL,
    content text NOT NULL,
    email varchar(60),
    hit bigint,    
    regdate datetime,
    constraint PK_ARTICLE PRIMARY KEY(articleno),
    constraint FK_ARTICLE FOREIGN KEY(boardcd) REFERENCES board(boardcd)
);
 
-- 댓글
create table comments (
    commentno int not null auto_increment,
    articleno int,    
    email varchar(60),    
    memo varchar(4000) NOT NULL,
    regdate datetime, 
    constraint PK_COMMENTS PRIMARY KEY(commentno)
);
 
-- 첨부파일 
create table attachfile (
    attachfileno int not null auto_increment,
    filename varchar(50) NOT NULL,
    filetype varchar(30),
    filesize bigint,
    articleno int,
    email varchar(60),
    constraint PK_ATTACHFILE PRIMARY KEY(attachfileno)
);
 
insert into board values ('free','자유게시판');
insert into board values ('qna','QnA게시판');
insert into board values ('data','자료실');
 
commit;