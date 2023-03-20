package com.sh.oee.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.member.model.dao.MemberDao;
import com.sh.oee.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member selectOneMember(String memberId) {
		return memberDao.selectOneMember(memberId);
	}

	
	
	
	
	
	
	
	
	
	
	//혜진도전,,0320
	@Override
	public String[] selectDongNearNames(int dongNo) {
		return memberDao.selectDongNearNames(dongNo);
	}
	
}
