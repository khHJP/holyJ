package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.local.model.dto.Local;
import com.sh.oee.local.model.dto.LocalAttachment;

public interface LocalService {

	//동네생활 전체목록
	List<Local> localList();

	//카테고리
	List<Map<String, String>> localCategoryList();
	
	//게시글 등록
	int insertLocalBoard(Local local);
	
	//첨부파일 등록
	int insertLocalAttachment(LocalAttachment attach);

}
