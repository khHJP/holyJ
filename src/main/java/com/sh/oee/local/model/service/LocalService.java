package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.local.model.dto.Local;

public interface LocalService {

	//동네생활 전체목록
	List<Local> localList();

	//카테고리
	List<Map<String, String>> localCategoryList();

}
