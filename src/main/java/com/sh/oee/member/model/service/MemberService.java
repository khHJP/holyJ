package com.sh.oee.member.model.service;

import java.util.List;

import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Gu;
import com.sh.oee.member.model.dto.Member;

public interface MemberService {

	/** 정은 시작 */
	Member selectOneMember(String memberId);

	List<Gu> selectGuList();
	
	List<Dong> selectDongList();
	
	/** 정은 끝 */
	
	
	
	
	
	
	
	
	
	
	//혜진 도전,,
	String[] selectDongNearNames(int dongNo);

	


	

}
