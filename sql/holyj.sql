--=============================================
-- 구 GU
--=============================================
create table GU (
	GU_NO number,
	GU_NAME	varchar2(30) not null,
    constraint pk_gu_no primary key(gu_no)
);

create sequence seq_gu_no;

--=============================================
-- 동 DONG
--=============================================
create table DONG (
	DONG_NO	number,
	GU_NO number not null,
	DONG_NAME varchar2(30) not null,
	LATITUDE number	not null,
	LONGITUDE number not null,
    constraint pk_dong_no primary key(dong_no),
    constraint fk_gu_no foreign key(gu_no) references GU(gu_no)
);

-- DONG_NO 하드코딩

--=============================================
-- 동별 범위 DONG_RANGE
--=============================================
create table DONG_RANGE (
    DONG_NO number,
    DONG_NEAR varchar2(200) not null, 
    DONG_FAR varchar2(200) not null,
    constraint pk_range_dong_no primary key(dong_no),
    constraint fk_dong_no foreign key(dong_no) references DONG(dong_no)
);


--=============================================
-- 회원 MEMBER
--=============================================

create table MEMBER (
	MEMBER_ID varchar2(30),
	PASSWORD varchar2(300) not null,
	NICKNAME varchar2(20) not null,
	PHONE varchar2(11) not null,
	MANNER number default 36.5, -- 36.5도 
	PROFILE_IMG	varchar2(200) default 'oee.jpg', --파일명정하기
	DONG_NO	number not null,
	DONG_RANGE char(1) not null,
	REPORT_CNT	number default 0, -- 신고 기본 0
    ENROLL_DATE date default sysdate,

    constraint pk_member_id primary key(member_id),
    constraint fk_member_dong_no foreign key(dong_no) references DONG(dong_no),
    constraint ck_dong_range check(dong_range in ('N', 'F'))
);

alter table MEMBER add DELETE_DATE date default null; -- 탈퇴일 추가
alter table member modify profile_img default 'oee.png'; -- 확장자 수정

select * from member;

--=============================================
-- 사용자 알림 NOTICE_USER
--=============================================
create table NOTICE_USER (
    NO number,
	MEMBER_ID varchar2(30) not null,
	MSG	varchar2(3000) not null,
	TYPE varchar2(30) not null,
	REG_DATE date default sysdate,
	READ_YN	char(1)	default 'N',
    constraint pk_notice_user_no primary key(no),
    constraint fk_notice_member_id foreign key(member_id) references member(member_id), -- fk명 겹치는거 주의
    constraint ck_notice_type check(type in ('KEYWORD', 'REPLY')),
    constraint ck_read_yn check(read_yn in ('Y', 'N'))
);

create sequence seq_notice_user_no;

--=============================================
-- 관리자 알림 NOTICE_ADMIN
--=============================================
create table NOTICE_ADMIN (
    NO number,
	MSG	varchar2(3000) not null,
	REG_DATE date default sysdate,
    constraint pk_notice_admin_no primary key(no)
);

create sequence seq_notice_admin_no;
select * from notice_admin;

select seq_notice_admin_no.nextval
from dual;

--=============================================
-- 알림 키워드 NOTICE_KEYWORD
--=============================================
create table NOTICE_KEYWORD (
	NO number,
	MEMBER_ID	varchar2(30) not null,
	KEYWORD	VARCHAR2(50) not null,
	REG_DATE date default sysdate,
    constraint pk_keyword_no primary key(no),
    constraint fk_keyword_member_id foreign key(member_id) references member(member_id)
);

create sequence seq_keyword_no;

--=============================================
-- 신고유형 REPORT_TYPE
--=============================================
CREATE TABLE REPORT_TYPE (
	REPORT_TYPE	CHAR(2),
	REPORT_TYPE_NAME VARCHAR2(50) NOT NULL,
	CONSTRAINT PK_REPORT_TYPE PRIMARY KEY(REPORT_TYPE)	
);

insert into REPORT_TYPE values('CR', '중고거래');
insert into REPORT_TYPE values('LO', '동네생활');
insert into REPORT_TYPE values('TO', '같이해요');
insert into REPORT_TYPE values('US', '사용자');

--=============================================
-- 신고사유 REPORT_REASON
--=============================================
CREATE TABLE REPORT_REASON (
	REASON_NO	NUMBER,
    REPORT_TYPE CHAR(2) not null,
	REASON_NAME	VARCHAR2(200) NOT NULL,
  CONSTRAINT PK_REASON_NO PRIMARY KEY(REASON_NO),
  constraint fk_report_reason_type foreign key (report_type) references REPORT_TYPE(REPORT_TYPE) 
);
-- modify로 크기변경
alter table REPORT_REASON modify REASON_NAME varchar2(200);

create sequence seq_report_reason_no;

--=============================================
-- 게시글신고 BOARD_REPORT
--=============================================
CREATE TABLE BOARD_REPORT (
    REPORT_NO	NUMBER,
    WRITER	VARCHAR2(30)	NOT NULL,
    REPORT_TYPE	CHAR(2)	NOT NULL,
    REPORT_POST_NO	NUMBER	NOT NULL,
    REASON_NO	NUMBER	NOT NULL,
    REG_DATE	DATE DEFAULT SYSDATE,
    STATUS	CHAR(1)	DEFAULT 'N',
    CONSTRAINT PK_BOARD_REPORT_NO PRIMARY KEY(REPORT_NO),
    CONSTRAINT FK_BOARD_REPORT_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT FK_BOARD_REPORT_TYPE FOREIGN KEY(REPORT_TYPE) REFERENCES REPORT_TYPE(REPORT_TYPE),
    CONSTRAINT FK_BOARD_REPORT_REASON_NO FOREIGN KEY(REASON_NO) REFERENCES REPORT_REASON(REASON_NO),
    constraint CK_BOARD_REPORT_STATUS check(STATUS in ('Y', 'N'))   
);

CREATE SEQUENCE SEQ_BOARD_REPORT_NO;

select * from board_report order by report_no desc;

--=============================================
-- 사용자신고 USER_REPORT
--=============================================
CREATE TABLE USER_REPORT (
	REPORT_NO	NUMBER,
	WRITER	VARCHAR2(30)	NOT NULL,
	REASON_NO	NUMBER	NOT NULL,
	REPORTED_MEMBER	VARCHAR2(30)	NOT NULL,
	REG_DATE DATE DEFAULT SYSDATE,
	STATUS	CHAR(1)	DEFAULT 'N',
    CONSTRAINT PK_USER_REPORT_NO PRIMARY KEY(REPORT_NO),
    CONSTRAINT FK_USER_REPORT_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT FK_USER_REPORT_REASON_NO FOREIGN KEY(REASON_NO) REFERENCES REPORT_REASON(REASON_NO),
    constraint CK_USER_REPORT_STATUS check(STATUS in ('Y', 'N'))
);
CREATE SEQUENCE SEQ_USER_REPORT_NO;

-- COMMENT
COMMENT ON COLUMN TOGETHER_CATEGORY.CATEGORY_NO IS '카테고리 NO';
COMMENT ON COLUMN TOGETHER_CATEGORY.CATEGORY_NAME IS '카테고리명';


--=============================================
-- 같이해요 카테고리 TOGETHER_CATEGORY
--=============================================
CREATE TABLE TOGETHER_CATEGORY (
    CATEGORY_NO NUMBER,
    CATEGORY_NAME VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_TOGETHER_CATEGORY_NO PRIMARY KEY(CATEGORY_NO)
);

--=============================================
-- 같이해요 TOGETHER
--=============================================
CREATE TABLE TOGETHER (
    NO NUMBER,
    WRITER VARCHAR2(30) NOT NULL,
    CATEGORY_NO NUMBER NOT NULL,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(3000) NOT NULL,
    JOIN_CNT NUMBER NOT NULL,
    DATE_TIME DATE NOT NULL,
    PLACE VARCHAR2(100) NOT NULL,
    GENDER CHAR(1) NOT NULL,
    AGE VARCHAR2(10) NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE,
    status CHAR(1) DEFAULT 'Y',
    
    CONSTRAINT PK_TOGETHER_NO PRIMARY KEY(NO),
    CONSTRAINT FK_TOGETHER_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT FK_TOGETHER_CATEGORY_NO FOREIGN KEY(CATEGORY_NO) REFERENCES TOGETHER_CATEGORY(CATEGORY_NO),
    CONSTRAINT CK_TOGETHER_JOIN_CNT CHECK(JOIN_CNT >= 3 AND JOIN_CNT <= 10),
    CONSTRAINT CK_TOGETHER_GENDER CHECK(GENDER IN ('M', 'F','A')),
    CONSTRAINT CK_TOGETHER_AGE CHECK(AGE IN ('20', '30', '40', '50', '60', '100')),
    CONSTRAINT CK_TOGETHER_STATUS CHECK(STATUS IN ('Y', 'N'))
    
);

-- COMMENT
COMMENT ON COLUMN TOGETHER.NO IS '같이해요 NO';
COMMENT ON COLUMN TOGETHER.WRITER IS '작성자 ID';
COMMENT ON COLUMN TOGETHER.CATEGORY_NO IS '카테고리 ID';
COMMENT ON COLUMN TOGETHER.TITLE IS '제목';
COMMENT ON COLUMN TOGETHER.CONTENT IS '활동내용';
COMMENT ON COLUMN TOGETHER.JOIN_CNT IS '인원';
COMMENT ON COLUMN TOGETHER.DATE_TIME IS '일시';
COMMENT ON COLUMN TOGETHER.PLACE IS '장소';
COMMENT ON COLUMN TOGETHER.GENDER IS '성별';
COMMENT ON COLUMN TOGETHER.AGE IS '나이';
COMMENT ON COLUMN TOGETHER.REG_DATE IS '등록일';
COMMENT ON COLUMN TOGETHER.STATUS IS '모집상태';


CREATE SEQUENCE SEQ_TOGETHER_NO;

-- 신고 여부 컬럼 및 CK 제약조건 추가
alter table TOGETHER ADD REPORT_YN char(1) default 'N';
alter table TOGETHER add constraint ck_together_report_yn check(REPORT_YN in ('Y', 'N'));

--=============================================
-- 같이해요 대화방 TOGETHER_CHAT
--=============================================
CREATE TABLE TOGETHER_CHAT (
    CHATROOM_NO NUMBER,
    TOGETHER_NO NUMBER,
    MEMBER_ID VARCHAR2(30) NOT NULL,
    ROLE CHAR(1) NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE,
    LAST_CHECK NUMBER default 0,
    
    CONSTRAINT PK_TOGETHER_CHATROOM_NO PRIMARY KEY(CHATROOM_NO),
    CONSTRAINT FK_TOGETHER_CNO FOREIGN KEY(TOGETHER_NO) REFERENCES TOGETHER(NO) on delete cascade, -- 같이해요 게시물 삭제시 대화방 삭제
    CONSTRAINT FK_TOGETHER_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT CK_TOGETHER_ROLE CHECK(ROLE IN ('A','M')) -- Admin , Member
);


-- COMMENT
COMMENT ON COLUMN TOGETHER_CHAT.CHATROOM_NO IS '같이해요 대화방 NO';
COMMENT ON COLUMN TOGETHER_CHAT.TOGETHER_NO IS '같이해요 NO';
COMMENT ON COLUMN TOGETHER_CHAT.MEMBER_ID IS '참여자 ID';
COMMENT ON COLUMN TOGETHER_CHAT.ROLE IS '역할';
COMMENT ON COLUMN TOGETHER_CHAT.REG_DATE IS '등록일';

CREATE SEQUENCE SEQ_TOGETHER_CHATROOM_NO;

--=============================================
-- 같이해요 메시지 TOGETHER_MSG
--=============================================
CREATE TABLE TOGETHER_MSG (
    MSG_NO NUMBER,
    TOGETHER_NO NUMBER,
    WRITER VARCHAR2(30) NOT NULL,
    CONTENT VARCHAR2(3000) NOT NULL, -- file타입의 경우 파일이름
    SENT_TIME NUMBER NOT NULL,
    TYPE varchar2(50) not null,
    
    CONSTRAINT PK_TOGETHER_MSG_NO PRIMARY KEY(MSG_NO),
    CONSTRAINT FK_TOGETHER_MNO FOREIGN KEY(TOGETHER_NO) REFERENCES TOGETHER(NO) on delete set null, -- 같이해요 게시물 삭제시 null로
    CONSTRAINT FK_TOGETHER_MSG_WRITER FOREIGN KEY(WRITER) REFERENCES MEMBER(MEMBER_ID),
    constraint CK_TOGETHER_MSG_TYPE CHECK(TYPE in ('CHAT', 'FILE'))
);

-- COMMENT
COMMENT ON COLUMN TOGETHER_MSG.MSG_NO IS '메시지 NO';
COMMENT ON COLUMN TOGETHER_MSG.TOGETHER_NO IS '같이해요 NO';
COMMENT ON COLUMN TOGETHER_MSG.WRITER IS '작성자 ID';
COMMENT ON COLUMN TOGETHER_MSG.CONTENT IS '메시지 내용';
COMMENT ON COLUMN TOGETHER_MSG.SENT_TIME IS '보낸시간';
COMMENT ON COLUMN TOGETHER_MSG.TYPE IS '타입';

CREATE SEQUENCE SEQ_TOGETHER_MSG_NO;

--=============================================
-- 같이해요 메시지 첨부파일 TOGETHER_MSG_ATTACH
--=============================================
CREATE TABLE TOGETHER_MSG_ATTACH (
    ATTACH_NO NUMBER,
    MSG_NO NUMBER NOT NULL,
    ORIGINAL_FILENAME VARCHAR2(500),
    RE_FILENAME VARCHAR2(500),
    REG_DATE DATE DEFAULT SYSDATE,
    
    CONSTRAINT PK_TOGETHER_MSG_ATTACH_NO PRIMARY KEY(ATTACH_NO),
    CONSTRAINT FK_TOGETHER_MSG_NO FOREIGN KEY(MSG_NO) REFERENCES TOGETHER_MSG(MSG_NO) on delete cascade -- 메시지 삭제시 첨부파일 삭제
);

-- COMMENT
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.ATTACH_NO IS '첨부파일 NO';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.MSG_NO IS '메시지 NO';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.ORIGINAL_FILENAME IS '원본파일명';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.RE_FILENAME IS '서버파일명';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.REG_DATE IS '등록일';

CREATE SEQUENCE SEQ_TOGETHER_MSG_ATTACH_NO;

--=============================================
-- 중고거래 카테고리 CRAIG_CATEGORY
--=============================================
create table CRAIG_CATEGORY (
	category_no number,
	category_name varchar2(50) not null,
  constraint pk_craig_category_no primary key(category_no)
);

--=============================================
-- 중고거래 CRAIG
--=============================================
create table CRAIG (
	no number,
	category_no number not null,
	writer varchar2(30) not null,
	title varchar2(200) not null,
	content varchar2(3000) not null,
	reg_date date default sysdate,
	latitude number not null,
	longitude number not null,
	place_detail varchar2(50) not null,
	price number not null,
	hits number default 0,
	state char(10) default 'CR2', -- 예약중/판매중/판매완료
	buyer varchar2(30),
	complete_date date,
  constraint pk_craig_no primary key(no),
	constraint fk_craig_category_no foreign key (category_no) references craig_category(category_no) on delete set null,
	constraint fk_craig_writer foreign key (writer) references member(member_id),
	constraint ck_craig_state check (state in ('CR1', 'CR2', 'CR3'))
);

create sequence seq_craig_no;

-- 신고 여부 컬럼 및 CK 제약조건 추가
alter table CRAIG ADD REPORT_YN char(1) default 'N';
alter table CRAIG add constraint ck_craig_report_yn check(REPORT_YN in ('Y', 'N'));

--=============================================
-- 중고거래 첨부파일 CRAIG_ATTACHMENT
--=============================================
create table CRAIG_ATTACHMENT (
	attach_no number,
	craig_no number not null,
	original_filename varchar2(500),
	re_filename varchar2(500),
	reg_date date default sysdate,
  constraint pk_craig_attach_no primary key (attach_no),
  constraint fk_craig_attach_craig_no foreign key (craig_no) references craig(no) on delete cascade -- 중고거래 게시글 삭제시 첨부파일 삭제
);

create sequence seq_craig_attach_no;

--=============================================
-- 중고거래 관심 CRAIG_WISH
--=============================================
CREATE TABLE CRAIG_WISH (
	WISH_NO 	NUMBER,
	CRAIG_NO	NUMBER	NOT NULL,
	MEMBER_ID 	VARCHAR2(30)	NOT NULL,
	REG_DATE	DATE	DEFAULT SYSDATE,
    
    constraint pk_CRAIG_WISH_WISH_NO primary key (WISH_NO),
    constraint fk_CRAIG_WISH_CRAIG_NO foreign key(CRAIG_NO) references CRAIG(NO) on delete cascade,
    constraint fk_CRAIG_WISH_MEMBER_ID foreign key(MEMBER_ID) references MEMBER( MEMBER_ID) 
);

CREATE SEQUENCE seq_CRAIG_WISH_no;

-----------------------------------------------------------------------------------------------------------------------------------


--=============================================
-- 중고거래 대화방 CRAIG_CHAT
--=============================================
-- 채팅방 나갈때 DEL_DATE 추가 
-- 다시 소환당하면 REG_DATE 업데이트, DEL_DATE null
-- 나간다고 행을 날리면 다시 불러올 수단이없음. 채팅방 아이디로 찾아야함. (신사는 홍길동, 박효정, 김혜진, 이하나와 대화 다할수있다)
CREATE TABLE CRAIG_CHAT (
	CHATROOM_ID	VARCHAR2(50), -- java단에서 문자열토큰생성
	MEMBER_ID 	VARCHAR2(30)	NOT NULL,
	CRAIG_NO	NUMBER,
    LAST_CHECK  number default 0,  
	REG_DATE	DATE DEFAULT SYSDATE, -- 채팅방 참여시기
    DEL_DATE    DATE, -- 채팅방 퇴장시기
    
    constraint PK_CRAIG_CHAT_CHATROOM_MEMBER_ID PRIMARY KEY (CHATROOM_ID, MEMBER_ID),
    constraint fk_CRAIG_CHAT_MEMBER_ID foreign key(MEMBER_ID) references MEMBER( MEMBER_ID),
    constraint fk_CRAIG_CHAT_CRAIG_NO foreign key(CRAIG_NO) references CRAIG(NO) on delete set null -- 게시글 삭제시 null (채팅방에 "삭제됨"으로 표시)
);


--=============================================
-- 중고거래 메시지 CRAIG_MSG
--=============================================
CREATE TABLE CRAIG_MSG (
	MSG_NO	NUMBER,
	CHATROOM_ID	VARCHAR2(50)	NOT NULL,
	WRITER	VARCHAR2(30)	NOT NULL,
	CONTENT 	VARCHAR2(3000)	NOT NULL,
	SENT_TIME	NUMBER	NOT NULL,
	TYPE	VARCHAR2(50),
    
    constraint PK_CRAIG_MSG_NO PRIMARY KEY (MSG_NO),
    constraint fk_CRAIG_MSG_CHATROOM_ID_WRITER foreign key(CHATROOM_ID, WRITER) references CRAIG_CHAT(CHATROOM_ID, MEMBER_ID), -- 복합PK를 FK로
    CONSTRAINT ck_CRAIG_MSG_TYPE check(type in ('CHAT', 'FILE'))
);

-- 제약조건 삭제후 추가함 (chat, file, book, place)
alter table 
    craig_msg
add constraint ck_CRAIG_MSG_TYPE check(type in('CHAT', 'FILE', 'BOOK', 'PLACE'));



CREATE SEQUENCE seq_CRAIG_MSG_NO;
--=============================================
-- 중고거래 메시지 첨부파일 CRAIG_MSG_ATTACH
--=============================================
create table CRAIG_MSG_ATTACH (
	attach_no number,
	msg_no number not null,
	original_filename varchar2(500),
	re_filename varchar2(500),
	reg_date date default sysdate,
  constraint pk_craig_msg_attach_no primary key (attach_no),
  constraint fk_craig_msg_attach_msg_no foreign key (msg_no) references craig_msg (msg_no) on delete cascade
);

create sequence seq_craig_msg_attach_no;

--=============================================
-- 중고거래 예약 CRAIG_MEETING
--=============================================
CREATE TABLE CRAIG_MEETING (
	NO	NUMBER,
	CHATROOM_ID	VARCHAR2(30)	NOT NULL,
	MEMBER_ID	 VARCHAR2(30)	NOT NULL,
	MEETING_DATE 	DATE,   -- date 이름 바꿔야될듯 
	REG_DATE	DATE	DEFAULT SYSDATE,
	LONGITUDE 	NUMBER,
	LATITUDE  	NUMBER,
    constraint PK_CRAIG_MEETING_NO PRIMARY KEY (NO),
    constraint FK_CRAIG_MEETING_NO foreign key (NO) references CRAIG(NO) on delete cascade, 
    constraint fk_CRAIG_MEETING_CHATROOM_ID_MEMBER_ID foreign key(CHATROOM_ID, MEMBER_ID) references CRAIG_CHAT(CHATROOM_ID, MEMBER_ID) 
);

--=============================================
-- 매너평가 후기 MANNER_REVIEW
--=============================================
create table MANNER_REVIEW (
    manner_no number,
    craig_no number,
    prefer char(10) not null, -- 별로예요/좋아요/최고예요
    compliment char(10),
    writer varchar2(30), -- 후기작성자
    recipient varchar2(30), -- 후기대상자?
    reg_date date default sysdate,
    constraint pk_manner_no primary key(manner_no),
    constraint fk_manner_craig_no foreign key (craig_no) references craig (no) on delete set null,
    constraint ck_manner_prefer check (prefer in ('MA1', 'MA2', 'MA3')), -- 매너온도 / -0.5 / +0.2 / +0.5 (** 선택안했을시 못넘어감)
    constraint ck_manner_compliment check (compliment in ('COM1', 'COM2', 'COM3', 'COM4')) -- +0.1 (넷중하나 / null가능 (CK))
);
-- modify로 크기변경
alter table MANNER_REVIEW modify prefer char(3);
alter table MANNER_REVIEW modify compliment char(4);

create sequence seq_manner_no;


--=============================================
-- 동네생활 카테고리 LOCAL_CATEGORY
--=============================================
create table LOCAL_CATEGORY(
CATEGORY_NO number not null,
CATEGORY_NAME varchar2(50) not null,

constraint PK_CATEGORY_NO primary key(category_no)
);

comment on column LOCAL_CATEGORY.CATEGORY_NO is '카테고리 NO';
comment on column LOCAL_CATEGORY.CATEGORY_NAME is '카테고리 명';

--=============================================
-- 동네생활 LOCAL
--=============================================
create table LOCAL(
    NO number not null,
    CATEGORY_NO number not null,
    WRITER varchar2(30) not null,
    TITLE varchar2(200) not null,
    CONTENT varchar2(3000) not null,
    REG_DATE date default SYSDATE  not null,
    HITS number default 0 not null,
    
    constraint PK_NO primary key(no),
    constraint FK_CATEGORY_NO foreign key(category_no) REFERENCES local_category(category_no) on delete set null,
    constraint FK_WRITER foreign key(writer) REFERENCES member(member_id)
    
);

comment on column LOCAL.NO is '게시글번호';
comment on column LOCAL.CATEGORY_NO is '카테고리 NO';
comment on column LOCAL.WRITER is '작성자 아이디';
comment on column LOCAL.TITLE is '제목';
comment on column LOCAL.CONTENT is '내용';
comment on column LOCAL.REG_DATE is '등록일';
comment on column LOCAL.HITS is '조회수';

create sequence seq_local_no;

-- 신고 여부 컬럼 및 CK 제약조건 추가
alter table LOCAL ADD REPORT_YN char(1) default 'N';
alter table LOCAL add constraint ck_local_report_yn check(REPORT_YN in ('Y', 'N'));

--=============================================
-- 동네생활 공감 LOCAL_LIKE
--=============================================
create table LOCAL_LIKE(
LIKE_NO number not null,
MEMBER_ID varchar2(30) not null,
LOCAL_NO number not null,

constraint PK_LIKE_NO primary key(like_no),
constraint FK_MEMBER_ID FOREIGN key (member_id) REFERENCES member(member_id),
constraint FK_LOCAL_NO foreign key (local_no) references local(no) on delete cascade
);

comment on column LOCAL_LIKE.LIKE_NO is '공감 번호';
comment on column LOCAL_LIKE.MEMBER_ID is '아이디';
comment on column LOCAL_LIKE.LOCAL_NO is '게시글번호';

create sequence seq_like_no;

--=============================================
-- 동네생활 첨부파일 LOCAL_ATTACHMENT
--=============================================
create table LOCAL_ATTACHMENT(
ATTACH_NO number not null,
LOCAL_NO number not null,
ORIGINAL_FILENAME varchar2(500) not null,
RE_FILENAME varchar2(500) not null,
REG_DATE date default SYSDATE not null,

constraint PK_ATTACH_NO primary key(attach_no),
constraint FK_ATTACH_LOCAL_NO foreign key (local_no) references local(no) on delete cascade
);

comment on column LOCAL_ATTACHMENT.ATTACH_NO is '첨부파일 NO';
comment on column LOCAL_ATTACHMENT.LOCAL_NO is '게시글번호';
comment on column LOCAL_ATTACHMENT.ORIGINAL_FILENAME is '원본파일명';
comment on column LOCAL_ATTACHMENT.RE_FILENAME is '서버파일명';
comment on column LOCAL_ATTACHMENT.REG_DATE is '등록일';

create sequence seq_local_attach_no;

--=============================================
-- 동네생활 댓글 LOCAL_COMMENT
--=============================================
create table LOCAL_COMMENT(
COMMENT_NO number not null,
LOCAL_NO number not null,
WRITER varchar2(30) not null,
REF_NO number,
COMMENT_LEVEL number default 1,
CONTENT varchar2(3000) not null,
REG_DATE date default SYSDATE,

constraint PK_COMMENT_NO primary key(comment_no),
constraint FK_COMMENT_LOCAL_NO foreign key(local_no) references local(no) on delete cascade,
constraint FK_LOCAL_COMMENT_WRITER foreign key(writer) references member(member_id),
constraint SELF_FK_REF_NO foreign key(ref_no) references local_comment(comment_no) on delete cascade
);

create sequence seq_local_comment_no;

comment on column LOCAL_COMMENT.COMMENT_NO is '댓글번호';
comment on column LOCAL_COMMENT.LOCAL_NO is '게시글번호';
comment on column LOCAL_COMMENT.WRITER is '작성자 아이디';
comment on column LOCAL_COMMENT.REF_NO is '참조댓글번호';
comment on column LOCAL_COMMENT.COMMENT_LEVEL is '댓글레벨';
comment on column LOCAL_COMMENT.CONTENT is '내용';
comment on column LOCAL_COMMENT.REG_DATE is '등록일';

--=================================
-- 권한테이블 생성
--=================================
create table authority(
    member_id varchar2(30),
    auth varchar2(50),
    constraint pk_authority primary key(member_id, auth), -- 두개 묶어서 pk
    constraint fk_authority_member_id foreign key(member_id) 
                                references member(member_id)
                                on delete cascade        
);
insert into authority values ('admin', 'ROLE_USER'); -- 한명씩 권한 추가 (admin은 기본유저권한도 갖고있음)
insert into authority values ('admin', 'ROLE_ADMIN'); -- 한명씩 권한 추가
insert into authority values ('ROLE_WARN');

--==========================================
-- remember-me 관련테이블 persistent_logins
--==========================================
create table persistent_logins (
    username varchar2(64) not null,
    series varchar2(64) primary key,
    token varchar2(64) not null, -- username, password, expiry time 등을 hashing한 값
    last_used timestamp not null
);

select * from persistent_logins;


---  수정한 테이블 정보 0405 
 
 --  같이해요 대화방 / 메세지 / 첨부파일 관련 테이블 수정   230405 
--=============================================
-- 같이해요 대화방 TOGETHER_CHAT   -- 새로만들었어요 0405 
--=============================================
CREATE TABLE TOGETHER_CHAT (
    TOGETHER_NO NUMBER,
    MEMBER_ID VARCHAR2(30) NOT NULL,
    ROLE CHAR(1) NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE,
    LAST_CHECK NUMBER default 0,
    
    CONSTRAINT PK_TOGETHER_TOGETHER_NO_MEMBER_ID PRIMARY KEY(TOGETHER_NO, MEMBER_ID), --복합pk
    CONSTRAINT FK_TOGETHER_TOGETHER_TOGETHER_NO FOREIGN KEY(TOGETHER_NO) REFERENCES TOGETHER(NO) on delete cascade, -- 같이해요 게시물 삭제시 대화방 삭제
    CONSTRAINT FK_TOGETHER_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT CK_TOGETHER_ROLE CHECK(ROLE IN ('A','M')) -- Admin , Member
);



--=============================================
-- 같이해요 메시지 TOGETHER_MSG  -- 새로만들었어요 0405 
--=============================================
CREATE TABLE TOGETHER_MSG (
    MSG_NO NUMBER,
    TOGETHER_NO NUMBER,  --복합fk
    MEMBER_ID VARCHAR2(30) NOT NULL,--복합fk
    CONTENT VARCHAR2(3000) NOT NULL, -- file타입의 경우 파일이름
    SENT_TIME NUMBER NOT NULL,
    TYPE varchar2(50) not null,
    
    CONSTRAINT PK_TOGETHER_MSG_NO PRIMARY KEY(MSG_NO),
    CONSTRAINT FK_TOGETHER_MNO_MEMBER_ID FOREIGN KEY(TOGETHER_NO, MEMBER_ID) REFERENCES TOGETHER_CHAT(TOGETHER_NO, MEMBER_ID) on delete set null, -- 같이해요 게시물 삭제시 null로
    constraint CK_TOGETHER_MSG_TYPE CHECK(TYPE in ('CHAT', 'FILE'))
);

CREATE SEQUENCE SEQ_TOGETHER_MSG_NO;


--=============================================
-- 같이해요 메시지 첨부파일 TOGETHER_MSG_ATTACH -- 수정 0405 (변경된거없음)
--=============================================
CREATE TABLE TOGETHER_MSG_ATTACH (
    ATTACH_NO NUMBER,
    MSG_NO NUMBER NOT NULL,
    ORIGINAL_FILENAME VARCHAR2(500),
    RE_FILENAME VARCHAR2(500),
    REG_DATE DATE DEFAULT SYSDATE,
    
    CONSTRAINT PK_TOGETHER_MSG_ATTACH_NO PRIMARY KEY(ATTACH_NO),
    CONSTRAINT FK_TOGETHER_MSG_NO FOREIGN KEY(MSG_NO) REFERENCES TOGETHER_MSG(MSG_NO) on delete cascade -- 메시지 삭제시 첨부파일 삭제
);

-- COMMENT
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.ATTACH_NO IS '첨부파일 NO';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.MSG_NO IS '메시지 NO';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.ORIGINAL_FILENAME IS '원본파일명';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.RE_FILENAME IS '서버파일명';
COMMENT ON COLUMN TOGETHER_MSG_ATTACH.REG_DATE IS '등록일';

CREATE SEQUENCE SEQ_TOGETHER_MSG_ATTACH_NO;

---
select * from TOGETHER
select * from TOGETHER_MSG
select * from TOGETHER_MSG_ATTACH
select * from together_chat
