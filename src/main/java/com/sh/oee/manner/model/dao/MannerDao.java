package com.sh.oee.manner.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.manner.model.dto.Manner;

@Mapper
public interface MannerDao {

	@Select("select * from manner_review where recipient = #{memberId}")
	List<Manner> selectMannerList(String memberId);

	
	//혜진추가-0403
	List<Manner> craigCronSchedule();

	// 혜진 - 매너온도 업뎃 - 0403 
	int updateMannerDegree( Map<String, Object> param );

	//혜진
	int updateComplimentDegree(Map<String, Object> param);

}
