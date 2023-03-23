package com.sh.oee.member.model.service;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.member.model.dao.MemberDao;
import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Gu;
import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

import lombok.NonNull;

@Transactional(rollbackFor = Exception.class)
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
	
	@Override
	public int insertMember(Member member) {
		// 회원정보등록
		int result = memberDao.insertMember(member);
		// 회원권한등록
		insertauthority(member.getMemberId());
		
		return result;
	}
	
	@Override
	public int insertauthority(String memberId) {
		return memberDao.insertauthority(memberId);
	}

	/** 정은 끝 */
	
	

	// 혜진꺼 다시
	@Override
	public String selectDongNearOnly(int dongNo) {
		return memberDao.selectDongNearOnly(dongNo);
	}

	@Override
	public String selectDongNearFar(int dongNo) {
		return memberDao.selectDongNearFar(dongNo);
	}

	//내동네
	@Override
	public String selectMydongName(int dongNo) {
		// TODO Auto-generated method stub
		return memberDao.selectMydongName(dongNo);
	}

	
}
