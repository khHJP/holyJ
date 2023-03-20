package com.sh.oee.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.member.model.dto.Member;

@Mapper
public interface MemberDao {

	Member selectOneMember(String memberId);



	
	
	
	
	
	
	
	
	
	
	//혜진도전 0320
	String[] selectDongNearNames(int dongNo);	
}
