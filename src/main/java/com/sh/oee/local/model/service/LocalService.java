package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;

import com.sh.oee.member.model.dto.Member;


public interface LocalService {

	//동네생활 전체목록
	List<Local> selectLocalListByDongName(List<String> myDongList);

	//카테고리
	List<Map<String, String>> localCategoryList();
	
	//게시글 등록
	int insertLocalBoard(Local local);
	
	//첨부파일 등록
	int insertLocalAttachment(LocalAttachment attach);
	
	//게시글 한건 조히
	Local selectLocalOne(int no);
	
	
	// ----------------------------- 하나 시작 -----------------------------------------------
	List<Local> selectLocalList(Member member);
	// ----------------------------- 하나 끝 -----------------------------------------------


}
