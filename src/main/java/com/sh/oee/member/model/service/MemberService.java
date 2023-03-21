package com.sh.oee.member.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

public interface MemberService {

	Member selectOneMember(String memberId);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//혜진 도전,,
	List<DongRange> selectDongNearNames(int dongNo);
	
	//다시 
	String selectDongNearOnly(int dongNo);

	String selectDongNearFar(int dongNo);

	//내동네
	String selectMydongName(int dongNo);

}
