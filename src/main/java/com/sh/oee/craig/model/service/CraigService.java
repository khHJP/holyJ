package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.craig.model.dto.Craig;

public interface CraigService {

	// 전체목록조회 
	List<Craig> craigList();

	// 카테고리 목록 조회 
	List<Map<String, String>> craigCategoryList();


}
