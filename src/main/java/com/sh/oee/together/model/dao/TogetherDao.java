package com.sh.oee.together.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;

@Mapper
public interface TogetherDao {

	List<TogetherEntity> selectTogetherList(String memberId);
	
	@Select("select * from together_category")
	List<Map<String,String>> selectTogetherCategory();

	List<Together> selectTogetherListByDongName(List<String> myDongList);

}
