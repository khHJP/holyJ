package com.sh.oee.together.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.together.model.dto.Together;

@Mapper
public interface TogetherDao {

	List<Together> selectTogetherList(String memberId);
	
	@Select("select * from together_category")
	List<Map<String,String>> selectTogetherCategory();

	List<Together> selectTogetherListByDongName(List<String> myDongList);

}
