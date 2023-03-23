package com.sh.oee.member.model.service;

import java.util.List;

import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Gu;
import java.util.Map;

import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

public interface MemberService {

	/** 정은 시작 */
	Member selectOneMember(String memberId);

	List<Gu> selectGuList();
	
	List<Dong> selectDongList();
	
	int insertMember(Member member);

	/** 정은 끝 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	// 혜진 코드 //


//	//혜진 도전,,
//	List<DongRange> selectDongNearNames(int dongNo);
	
	//다시 


	// 혜진 코드 //




	String selectDongNearOnly(int dongNo);

	String selectDongNearFar(int dongNo);

	//내동네
	String selectMydongName(int dongNo);


	


	

}
