package com.sh.oee.member.model.service;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.member.model.dao.MemberDao;
import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Gu;
import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	/** 정은 시작 */
	@Override
	public Member selectOneMember(String memberId) {
		return memberDao.selectOneMember(memberId);
	}

	@Override
	public List<Gu> selectGuList() {
		return memberDao.selectGuList();
	}
	
	@Override
	public List<Dong> selectDongList() {
		return memberDao.selectDongList();
	}

	
	/** 정은 끝 */
	
	/**
	 * 하나 시작
	 */
	@Override
	public int updateMember(Member member) {
		// TODO Auto-generated method stub
		return memberDao.updateMember(member);
	}
	@Override
	public int memberDelete(Member member) {
		// TODO Auto-generated method stub
		return memberDao.memberDelete(member);
	}
	/**
	 * 하나 끝
	 */

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
