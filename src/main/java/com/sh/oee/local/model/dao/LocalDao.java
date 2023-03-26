package com.sh.oee.local.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;

import com.sh.oee.member.model.dto.Member;


@Mapper
public interface LocalDao {

	//동네생활 전체목록
	List<Local> selectLocalListByDongName(List<String> myDongList);
	
	//카테고리
	@Select("select * from local_category")
	List<Map<String, String>> localCategoryList();

	//게시판 글등록
	int insertLocalBoard(Local local);
	
	int insertLocalAttachment(LocalAttachment attach);

	// ----------------------------- 하나 시작 -----------------------------------------------
	@Select("select * from local where writer = #{memberId}")
	List<Local> selectLocalList(Member member);
	// ----------------------------- 하나 끝 -----------------------------------------------

	//게시글 한건 조회
	Local selectLocalOne(int no);


}
