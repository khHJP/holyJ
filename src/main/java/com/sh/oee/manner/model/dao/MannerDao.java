package com.sh.oee.manner.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.manner.model.dto.Manner;

@Mapper
public interface MannerDao {

	@Select("select * from manner_review where recipient = #{memberId}")
	List<Manner> selectMannerList(String memberId);

}
