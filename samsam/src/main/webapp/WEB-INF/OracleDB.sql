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
	status		number  		not null
   );
   
alter table biz_member modify free_coupon number default 5;
alter table biz_member add status number default 1 not null;
alter table member_list add signdate date;
alter table member_list add wcount number;
alter table member_list modify grade varchar2(20) default '일반' not null;

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

insert into member_list(email,pw,name,nick,phone,local) 
values('admin', '1234', '삼삼', 'SamSam', 01043140000, '대구');

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

CREATE TABLE adopt_list (
	adopt_no		number		NOT NULL primary key,
	adopt_nick	varchar2(50)	NULL,
	 ADOPT_EMAIL VARCHAR2(50)    NOT NULL,
	adopt_date	date		NULL,
	adopt_readcount	number		NULL,
	adopt_phone	varchar2(20)	NULL,
	adopt_price	varchar2(20)	NULL,
	adopt_title	varchar2(200)	NULL,
	adopt_content	varchar2(2000)	NULL,
	big_name		varchar2(10)	NULL,
	kindof		varchar2(20)	NULL
);

CREATE TABLE adopt_reply (
	adopt_cno	number		NOT NULL PRIMARY KEY,
	adopt_no		number		NOT NULL,
	ADOPT_CEMAIL VARCHAR2(50)    NOT NULL,
	adopt_cnick	varchar2(50)	NULL,
	adopt_cdate	date		NULL,
	adopt_ccontent	varchar2(400)	NULL,
	adopt_csecret	number		NULL,
	adopt_ref		number		null,
	adopt_lev	number		null
);

CREATE TABLE free_doc (
	fdoc_no		number		NOT NULL primary key,
	fdoc_nick		varchar2(20)	NULL,
	fdoc_email	VARCHAR2(50)    NOT NULL,
	fdoc_date	date		NULL,
	fdoc_readcount	number		NULL,
	fdoc_expiry	number		NULL,
	fdoc_code	varchar2(20)	NULL,
	fdoc_price	varchar2(20)	NULL,
	fdoc_subject	varchar2(150)	NULL,
	fdoc_content	varchar2(2000)	NULL,
	fdoc_big		varchar2(20)	NULL,
	fdoc_kindof	varchar2(20)	NULL,
	fdoc_thumbnail 	varchar2(200)	null,
	fdoc_loc		varchar2(50)	null
);

CREATE TABLE fdoc_reply (
	fdoc_cno		number		NOT NULL PRIMARY KEY,
	fdoc_no		number		NOT NULL,
	fdoc_cemail	VARCHAR2(50)     NOT NULL,
	fdoc_cnick	varchar2(50)	NULL,
	fdoc_cdate	date		NULL,
	fdoc_ccontent	varchar2(2000)	NULL,
	fdoc_csecret	number		NULL,
	fdoc_ref		number		null,
	fdoc_lev		number		null
);
CREATE SEQUENCE ADOPT_NO_SEQ
INCREMENT BY 1 
START WITH 1 ;

CREATE SEQUENCE ADOPT_CNO_SEQ
INCREMENT BY 1 
START WITH 1 ;

분양글 작업 

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201229', 300000, '01000000000', '귀여운 말티즈 분양해욤뇸뇸', '차므로 귀욥쥬?? 연락주세요~~');

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201230', 300000, '01000000000', '끌올))) 귀여운 말티즈 분양해욤뇸뇸', '아이가 크고있어요 ㅜㅜ 연락주세요~~');

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201230', 600000, '01000000000', '푸들 여아 분양해욤뇸뇸', '아이가 크고있어요 ㅜㅜ 연락주세요~~');

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201230', 600000, '01000000000', '끌올))) 귀여운 푸들 분양해욤뇸뇸', '아이가 크고있어요 ㅜㅜ 연락주세요~~');

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201230', 300000, '01000000000', '두번째 끌올))) 귀여운 말티즈 분양해욤뇸뇸', '아이가 크고있어요 ㅜㅜ 연락주세요~~');

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201230', 450000, '01000000000', '흰눈처럼 하얀 포메 분양해욤뇸뇸', '아이가 크고있어요 ㅜㅜ 연락주세요~~');

insert into adopt_list(adopt_no,ADOPT_EMAIL,adopt_nick,adopt_date,adopt_price,adopt_phone,adopt_title,adopt_content) 
values(ADOPT_NO_SEQ.nextval,'ivedot@naver.com','ManD' , '20201230', 100000, '01000000000', '사랑스러운 믹스견 분양해욤뇸뇸', '아이가 크고있어요 ㅜㅜ 연락주세요~~');

insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,1,'ivedot@naver.com','ManD' , '20201229','헉 너무 사랑스러운거 아닌가요??!!');

select * from adopt_list;
select * from adopt_reply;

댓글작업

insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,8,'081749@naver.com','JangD' , '20201229','8-1우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,8,'081749@naver.com','JangD' , '20201229','8-2 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,6,'081749@naver.com','JangD' , '20201229','6-1 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,6,'081749@naver.com','JangD' , '20201229','6-2 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,6,'081749@naver.com','JangD' , '20201229','6-3 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,7,'081749@naver.com','JangD' , '20201229','7-1 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,11,'081749@naver.com','JangD' , '20201229','11-1 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,5,'081749@naver.com','JangD' , '20201229','5-1 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,5,'081749@naver.com','JangD' , '20201229','5-2 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,5,'081749@naver.com','JangD' , '20201229','5-3 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,5,'081749@naver.com','JangD' , '20201229','5-4 우와아ㅏㅏㅏ');
insert into adopt_reply(adopt_cno,adopt_no,ADOPT_CEMAIL,adopt_cnick,adopt_cdate,adopt_ccontent) 
values(ADOPT_cNO_SEQ.nextval,1,'ivedot@naver.com','ManD' , '20201229','헉 너무 사랑스러운거 아닌가요??!!');

이용권 결제내역

CREATE TABLE payed_list (
	imp_uid	varchar2(50)		NOT NULL PRIMARY KEY,
	merchant_uid	varchar2(50)	NULL,
	biz_email	 	varchar2(50)	NULL,
	pay_date 	date		NULL,
	amount		varchar2(20)	NULL,
	card_no		varchar2(50)	NULL,
	refund		varchar2(5)	NULL
);

alter table payed_list modify refund varchar2(10) default 'payed';

alter table member_list add signdate date;
alter table member_list add wcount number;
commit;

update member_list set wcount = 3 where email = 'hongmandang@naver.com';
update member_list set wcount = 1 where email = 'ivedot@naver.com';
update member_list set signdate = '20201201' where email = 'ivedot@naver.com';
update member_list set signdate = '20210101' where email = '081749@naver.com';
update member_list set grade = '사업자' where email = 'ivedot@naver.com';
update member_list set grade = '일반' where email = 'ivedot@nate.com';
update member_list set grade = '대기' where email = 'hongmandang@naver.com';

commit;

CREATE TABLE todo_list (
	to_do_no varchar2(50)		NOT NULL primary key,
	to_do 	varchar2(200)		not null,
	status 	varchar2(15)		DEFAULT 'MustDo'
);

CREATE SEQUENCE todo_SEQ
INCREMENT BY 1 
START WITH 1 ;


create table threeboard(
	write_date	varchar2(50) 	not null,
	write_count	number,
	board 		varchar2(30)
);
