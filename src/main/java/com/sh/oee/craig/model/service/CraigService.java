package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.http.ResponseEntity;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigEntity;

public interface CraigService {

	// 전체목록조회 
	List<Craig> craigList(RowBounds rowBounds,  List<String> dongList );

	// 카테고리 목록 조회 
	List<Map<String, String>> craigCategoryList();

	// 게시글등록
	int insertCraigBoard(Craig craig);
	
	//첨부파일등록
	int insertCraigAttachment(CraigAttachment attach);


}
