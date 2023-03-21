package com.sh.oee.craig.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;

@Mapper
public interface CraigDao {

	//전체목록조회
	List<Craig> craigList(RowBounds rowBounds,  List<String> dongList );

	@Select("select * from craig_category")
	List<Map<String, String>> craigCategoryList();

	//craig 게시판에 등록
	int insertCraigBoard(Craig craig);

	//craig attachment등록
	int insertCraigAttachment(CraigAttachment attach);

}
