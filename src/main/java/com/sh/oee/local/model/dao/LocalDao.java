package com.sh.oee.local.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.local.model.dto.Local;
import com.sh.oee.local.model.dto.LocalAttachment;

@Mapper
public interface LocalDao {

	//동네생활 전체목록
	List<Local> localList();
	
	//카테고리
	@Select("select * from local_category")
	List<Map<String, String>> localCategoryList();

	int insertLocalBoard(Local local);
	
	int insertLocalAttachment(LocalAttachment attach);
}
