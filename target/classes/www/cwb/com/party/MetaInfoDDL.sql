/*
 * 각종 테이블 생성 시 칼럼의 정보를 관리하는 MetaInfo Table DDL 모음집
 * Edit by songam(K.T.LIM)
 * 2019.11.24.
 */

drop table tbl_metainfo;
drop sequence seq4MetaInfo;

create sequence seq4MetaInfo;
create index idx_metainfo on tbl_metainfo(id);

-- id, password, height, grade, address, nickname, position, gender, regdate, updatedate
create table tbl_metainfo(
	id					int default seq4MetaInfo.nextval primary key,  -- 중복을 피하기 위한 자동부여
	tbl_id			varchar2(20) not null,				-- table id, 20자리
	tbl_column	varchar2(20) not null,				-- table column, 20자리
	code				varchar2(20) not null,				-- column에서 사용하는 code 구분
	code_desc		varchar2(50),							-- 각 code 구분에 해당하는 실제 data
);

insert all 
	into tbl_metainfo values(1, 'tbl_member', 'position', '1', 'Point Guard')
	into tbl_metainfo values(2, 'tbl_member', 'position', '2', 'Shooting Guard')
	into tbl_metainfo values(3, 'tbl_member', 'position', '3', 'Small Forward')
	into tbl_metainfo values(4, 'tbl_member', 'position', '4', 'Power Forward')
	into tbl_metainfo values(5, 'tbl_member', 'position', '5', 'Center')
select * 
  from dual;

 insert all 
	into tbl_metainfo values(1, 'tbl_member', 'gender', '1', '남자')
	into tbl_metainfo values(2, 'tbl_member', 'gender', '2', '여자')
select * 
  from dual;
  
select * from tbl_metainfo;    

select code, code_desc 
  from tbl_metainfo 
where tbl_id = 'tbl_member'
    and tbl_column = 'position';

