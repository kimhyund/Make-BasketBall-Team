/*
 * 회원 및 팀 테이블 통합 관리
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */
 
drop table tbl_party;

-- id, discriminator, password, name, phone, email, height, grade, address, nickname, position, gender, 
-- join_team1, join_team2, join_team3, join_team4, join_team5, win, lose, draw, member_num, 
-- description, enabled, reason, reg_date, update_date
	
create table tbl_party (
	id								varchar2(100) primary key,						-- 중복체크, team/member ID, 회원의 경우 12자리 영숫자
	discriminator				char(1),				 									-- T : team, M : member
	-- 회원가입
	password					varchar2(256) not null,								-- pwd, 정규식 8~12자리 영숫자(반드시 입력), 팀일 경우 임의의 패스워드 부여..
	name							varchar2(100),											-- 이름
	phone						varchar2(100),											-- 정규식(11자리) 숫자
	email							varchar2(100),											-- 정규식(id/pwd 찾기 시 활용)
	-- profile
	height						number(3,0),											-- 신장(cm)
	grade							number(2,1),											-- 평판점수(5점 만점 기준)로 가입초기는 '0'
	address						varchar2(100), 										-- 시/군(구)/동 주소, 팀 활동지역
	nickName					varchar2(100),											-- 별명
	position    					varchar2(1),											-- 포지션, 1:Point Guard, 2:Shooting Guard, 3:Small Forward, 4:Power Forward, 5:Center 
	gender						varchar2(1),											-- 성별, 1:남자, 2:여자
	join_team1					varchar2(100),											-- 팀원이 가입한 팀 ID, max 5
	join_team2					varchar2(100),											-- 팀원이 가입한 팀 ID, max 5
	join_team3					varchar2(100),											-- 팀원이 가입한 팀 ID, max 5
	join_team4					varchar2(100),											-- 팀원이 가입한 팀 ID, max 5
	join_team5					varchar2(100),											-- 팀원이 가입한 팀 ID, max 5
	-- 팀 정보
	win							number(4),												-- 승
	lose							number(4),												-- 패
	draw							number(4),												-- 무
	num_member				number(4),												-- 팀 가입 제한 회원 수
	description					varchar2(500),											-- 팀 소개 글
	-- 회원탈퇴
	enabled						char(1) default '1',									-- 회원탈퇴 시 '0'(탈퇴정보 관리)
	reason						varchar2(500),											-- 회원탈퇴 사유;
	regdate					date default sysdate,								-- 등록일자
	updatedate				date default sysdate								-- 변경일자
);
ALTER TABLE tbl_party RENAME COLUMN discription TO description;
ALTER TABLE tbl_party ADD (leader varchar2(100));


/*
 * 채팅방 대화내용 관리
 * 일정기간 경과 후 삭제 처리하는 Logic 구현 필요.
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */

drop table tbl_chat;
drop sequence seq_chat;

--오타 수정 by 찬
create sequence seq_chat;

-- id, team_id, user_id, content, reg_date
--user_id reference parameter edited by 찬
create table tbl_chat (
	id							integer primary key,								-- 채팅방 ID, 생성 시 마다 nextval로 자동채번
	team_id						varchar2(100),		-- 회원이 가입한 team id, 채팅방은 팀 단위로만 가능
	user_id						varchar2(100),		-- team에 가입되어 있는 회원 id
	content						varchar2(500),											-- 대화내용
	reg_date					date default sysdate								-- 등록일자 
);


/*
 * 농구 court 정보 관리
 * 회원이 입력 가능한 court 정보
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */

drop table tbl_court;
drop sequence seq_court;

create sequence seq_court;

-- id, name, half_court_num, full_court_num, address, user_id, 
-- content, latitude, longitude, reg_date, update_date
create table tbl_court (
	id								interger primary key,								-- id, nextval로 자동채번
	name							varchar2(100),											-- 농구장 name(한글, 영문 혼용)
	half_court_num			number(3),												-- 농구장 내 half court 수
	full_court_num			number(3),												-- 농구장 내 full court 수
	address						varchar2(100),											-- 위치 주소
	user_id						varchar2(100) references tbl_party(id),		-- 농구장 정보 입력한 회원 id, 추후 제공 정보의 허위여부에 따라 grade 등급 조정
	content						varchar2(500),											-- 상세 정보
	latitude						number(6,3),											-- 농구장 위치 - 위도(소숫점 3자리)
	longitude					number(6,3),											-- 농구장 위치 - 경도(소숫점 3자리)
	regdate					date default sysdate,								-- 등록일자
	updatedate				date default sysdate								-- 변경일자
);

ALTER TABLE tbl_court ADD (scale NUMBER(3));

/*
 * 팀 매칭 정보 관리
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */

drop table tbl_match;
drop sequence seq_match;

create sequence seq_match;

-- id, team_id, match_team, match_status, court_name, game_date
create table tbl_match (
	id								integer primary key,									-- id, nextval로 자동채번
	team_id						varchar2(100),												-- 매칭 요청을 받은 팀 id
	match_team				varchar2(100),												-- 매칭 요청 한 팀 id
	match_status				char(1), 													-- 'M' : 요청(Matching), 'C' : 수락(Confirm), 'R' : 거부(Refuse)
	court_name				varchar2(100) references tbl_court(name),		-- 농구장 이름
	game_date					date default sysdate									-- 게임 일자/시간(yyyy-mm-dd-24h-mm)
);


/*
 * 농구장 사용일정 정보 관리
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */

drop table tbl_court_plan;

-- team_id, court_id, status, start_time, end_time
create table tbl_court_plan (
	team_id						varchar2(100) references tbl_party(id),			-- 팀 id
	court_name				varchar2(100) references tbl_court(name),		-- 농구장 이름
	status						char(1), 													-- 'P' : Propose, 'I' : Implement, 'C' : Cancel
	start_time					date,															-- 시작시간, yyyy-mm-dd-24H:MM
	end_time					date															-- 종료시간, yyyy-mm-dd-24H:MM
);


/*
 * 게시판 Type (enum table)
 * 이 부분은 좀 더 논의가 필요함...
 * 과연 이게 필요할까?? 한편으로 겁나 의문이 듬...
 * 게시글과 댓글 분리??
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */

drop table tbl_board_type;

-- type, name, intro
create table tbl_board_type (
    type        					char(1),													-- 1:자유게시판, 2:매칭게시판, 3:팀원찾아요
    name							varchar2(50),											-- 제목?? 뭐지??
    intro							varchar2(1000)										-- 소개글?? 이건 또 뭐지??
);


/*
 * 게시글/댓글 관리
 * Edit by songam(K.T.LIM)
 * 2019.12.18.
 */

drop table tbl_posting;
drop sequence seq_posting;

create sequence seq_posting;

-- id, discriminator, board_type, user_id, parent_id, title, content
create table tbl_posting (
     id          					integer 	primary key,									-- 자동채번, 게시글 전체를 대상으로 채번한 번호
     discriminator   			char(1), 		  											-- 1:게시글, 2:댓글
     board_type 				char(1) REFERENCES tbl_board_type(type), 	-- 1:자유게시판, 2:매칭게시판, 3:팀원찾아요												-- 
     user_id   					integer REFERENCES tbl_party(id),				-- 작성자, 회원
     parent_id  				integer REFERENCES tbl_posting(id),			-- 게시글, 댓글 부모 id
     title      					varchar2(100),												-- 제목(게시글), 댓글은 제목 없음.
     content    					varchar2(1000)											-- 내용
);
/**
 * 권한 테이블 added by 찬
 */

select * from tbl_auth;
drop table tbl_auth;
create table tbl_auth(
	u_id			VARCHAR2(50) not null references tbl_party(id),
	u_authority	varchar2(200) not null
);
create table tbl_team(
	t_id			VARCHAR2(50) not null references tbl_party(id),
	u_authority	varchar2(200) not null
);

ALTER TABLE tbl_party RENAME COLUMN discription TO description;
/*
 * 팀 조인 관련 db변경 by 찬
 */
ALTER TABLE tbl_chat ADD(isRequest VARCHAR2(5)); 
ALTER TABLE tbl_chat ADD(teamLeaderId varchar2(100)); 

insert INTO tbl_chat(id, team_id,user_id,isRequest, teamLeaderId) VALUES ('2','바압','abc3','Y','abc1');
ALTER TABLE tbl_party RENAME COLUMN id TO pid;
/*
 * 팀만들기
 * Edit by songam(찬)
 * 2020.03.12.
 */
ALTER TABLE tbl_party ADD(Leader varchar2(100)); 
ALTER TABLE tbl_party RENAME COLUMN MEMBER_NUM TO num_member;

ALTER TABLE tbl_board ADD(type varchar2(10)); 
ALTER TABLE tbl_board ADD(address varchar2(100)); 

alter table tbl_board add address VARCHAR2(100); 
alter table tbl_board add type VARCHAR2(100); 
