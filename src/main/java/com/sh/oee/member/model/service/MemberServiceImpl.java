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
	
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	
	/** 정은 끝 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	//혜진도전,,0320
//	@Override
//	public List<DongRange> selectDongNearNames(int dongNo) {
//		return memberDao.selectDongNearNames(dongNo);
//	}







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
