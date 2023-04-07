package com.sh.oee.manner.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sh.oee.manner.model.dto.Manner;

@Mapper
public interface MannerDao {

	@Select("select * from manner_review where recipient = #{memberId}")
	List<Manner> selectMannerList(String memberId);
	List<Manner> selectMannerList1(String memberId);

	
	//혜진추가-0403
	List<Manner> craigCronSchedule();

	// 혜진 - 매너온도 업뎃 - 0403 
	int updateMannerDegree( Map<String, Object> param );

	//혜진
	int updateComplimentDegree(Map<String, Object> param);


	@Update("update manner_review set done = 'Y' where TO_CHAR(reg_date, 'YY/MM/DD')  =  TO_CHAR(sysdate-1, 'YY/MM/DD')")
	int updateMannerDone();

	//혜진 추가 
	int craigMannerEnroll(Manner manner);

	//혜진추가 
	Manner selectMannerOne(Map<String, Object> mannerMap);



}
