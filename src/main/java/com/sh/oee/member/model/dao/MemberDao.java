package com.sh.oee.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

@Mapper
public interface MemberDao {

	Member selectOneMember(String memberId);



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//혜진도전 0320
	List<DongRange>  selectDongNearNames(int dongNo);

	String selectDongNearOnly(int dongNo);

	String selectDongNearFar(int dongNo);

	String selectMydongName(int dongNo);

	
}
