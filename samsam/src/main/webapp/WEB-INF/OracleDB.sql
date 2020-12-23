CREATE TABLE member_list (
	email	varchar2(50)		NOT NULL primary key,
	pw	varchar2(20)		NULL,
	name	varchar2(20)		NULL,
	nick	varchar2(50)		NULL,
	phone	number		NULL,
	local	varchar2(20)		NULL,
	img	varchar2(2000)		NULL,
	grade	varchar2(10)		NULL
);
drop table member_list;

CREATE TABLE biz_member (
  	biz_email	varchar2(50)		NOT NULL,
	biz_no	varchar2(30)		not null primary key,
	biz_com	varchar2(30)		NULL,
	biz_name varchar2(9)		NULL,
	biz_add	varchar2(50)		NULL,
	biz_img	varchar2(2000)		NULL,
	free_coupon	number		NULL,
	pay_coupon	number		NULL
   );
   
ALTER TABLE biz_member
ADD CONSTRAINT biz_email FOREIGN KEY (biz_email)
REFERENCES MEMBER_list(email)ON DELETE CASCADE;

alter table biz_member drop constraint biz_email;

/* insert 예제 insert into countries values ('KR', 'Korea', 3); */
insert into member_list(email,pw,name,nick,phone,local) 
values('ivedot@naver.com', 'han1004', '한스', 'ManD', 01043140000, '서울');

insert into member_list(email,pw,name,nick,phone,local) 
values('081749@naver.com', 'han1004', '장스', 'Jang', 01076420000, '서울');

insert into member_list(email,pw,name,nick,phone,local) 
values('hongmandang@naver.com', 'han1004', '홍스', 'Hongmd', 01000000000, '서울');

select * from member_list;

/* LOCAL DATA 기존데이터 테이블 */
CREATE TABLE FULLDATA_ANIMAL
(
NO VARCHAR2(30),
OPEN_SV VARCHAR2(20),
OSV_ID VARCHAR2(30),
PUBLIC_CODE VARCHAR2(20),
AUTH_NO VARCHAR2(50),
AUTH_DATE VARCHAR2(50),
AUTH_CANCLE VARCHAR2(20),
STATUS_NO VARCHAR2(20),
STATUS_NAME VARCHAR2(50),
DETAIL_SNO VARCHAR2(30),
DETAIL_SNAME VARCHAR2(20),
CLOSE_DATE VARCHAR2(50),
STOP_START VARCHAR2(50),
STOP_END VARCHAR2(50),
RESTART_DATE VARCHAR2(50),
TEL VARCHAR2(30),
SPACE VARCHAR2(30),
POST_LEGACY VARCHAR2(20),
ADD_LEGACY VARCHAR2(200),
ADD_NEW VARCHAR2(200),
POST_NEW VARCHAR2(100),
BIZ_NAME VARCHAR2(100),
LAST_UPDATE VARCHAR2(50),
DATA_UPDATE VARCHAR2(50),
UPDATE_TIME VARCHAR2(100),
KINDOFBIZ VARCHAR2(30),
COORDI_X VARCHAR2(50),
COORDI_Y VARCHAR2(50),
ANIMAL_WORK VARCHAR2(50),
ANIMAL_PROCESS VARCHAR2(50),
ANIMAL_NO VARCHAR2(50),
MAINAGENT_NO VARCHAR2(50),
STAFF VARCHAR2(30)
);
DROP TABLE FULLDATA_ANIMAL;

select count(*) from fulldata_animal;
select * from fulldata_animal;
select * from fulldata_animal where no=26;
delete from fulldata_animal where no='번호';
