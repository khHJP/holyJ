package com.sh.oee.together.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.together.model.dto.Together;

@Mapper
public interface TogetherDao {

	List<Together> selectTogetherList(String memberId);

}
