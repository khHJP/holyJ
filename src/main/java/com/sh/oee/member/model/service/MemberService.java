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

	
	/** 정은 끝 */
	
	/** 하나 시작 **/
	int updateMember(Member member);
	int memberDelete(Member member);
	
	/** 하나 끝 **/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	// 혜진 코드 //
	String selectDongNearOnly(int dongNo);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



	


	

}
