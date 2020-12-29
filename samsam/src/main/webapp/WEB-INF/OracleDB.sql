CREATE TABLE member_list (
	email	varchar2(50)		NOT NULL primary key,
	pw	varchar2(20)		NULL,
	name	varchar2(20)		NULL,
	nick	varchar2(50)		NULL,
	phone	varchar2(20)		NULL,
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
   
alter table biz_member modify free_coupon number default 5;
alter table biz_member add status number default 1 not null;

ALTER TABLE biz_member
ADD CONSTRAINT biz_email FOREIGN KEY (biz_email)
REFERENCES MEMBER_list(email)ON DELETE CASCADE;

alter table biz_member drop constraint biz_email;

/* insert ���� insert into countries values ('KR', 'Korea', 3); */
insert into member_list(email,pw,name,nick,phone,local) 
values('ivedot@naver.com', 'han1004', '�ѽ�', 'ManD', 01043140000, '����');

insert into member_list(email,pw,name,nick,phone,local) 
values('081749@naver.com', 'han1004', '�彺', 'Jang', 01076420000, '����');

insert into member_list(email,pw,name,nick,phone,local) 
values('hongmandang@naver.com', 'han1004', 'ȫ��', 'Hongmd', 01000000000, '����');

select * from member_list;

/* LOCAL DATA ���������� ���̺� */
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
delete from fulldata_animal where no='��ȣ';

CREATE TABLE adopt_list (
	adopt_no		number		NOT NULL primary key,
	adopt_nick	varchar2(50)	NULL,
	adopt_date	date		NULL,
	adopt_readcount	number		NULL,
	adopt_img	varchar2(2000)	NULL,
	adopt_phone	varchar2(20)	NULL,
	adopt_price	varchar2(20)	NULL,
	adopt_title	varchar2(200)	NULL,
	adopt_content	varchar2(10000)	NULL,
	big_name		varchar2(10)	NULL,
	kindof		varchar2(20)	NULL
);

CREATE TABLE adopt_reply (
	adopt_cno	number		NOT NULL PRIMARY KEY,
	adopt_no		number		NOT NULL,
	adopt_cnick	varchar2(50)	NULL,
	adopt_cdate	date		NULL,
	adopt_ccontent	varchar2(400)	NULL,
	adopt_csecret	number		NULL
);

CREATE SEQUENCE ADOPT_NO_SEQ
INCREMENT BY 1 
START WITH 1 ;

CREATE SEQUENCE ADOPT_CNO_SEQ
INCREMENT BY 1 
START WITH 1 ;

insert into adopt_list(adopt_no,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'�ѽ�' , '20201229', 300000, '01000000000', '�Ϳ��� ��Ƽ�� �о��ؿ臜��', '���Ƿ� �Ϳ���?? �����ּ���~~');

insert into adopt_list(adopt_no,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'�ѽ�' , '20201230', 300000, '01000000000', '����))) �Ϳ��� ��Ƽ�� �о��ؿ臜��', '���̰� ũ���־�� �̤� �����ּ���~~');

insert into adopt_reply(adopt_cno,adopt_no,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,1,'�ѽ�' , '20201229','�� �ʹ� ���������� �ƴѰ���??!!');

select * from adopt_list;
select * from adopt_reply;
