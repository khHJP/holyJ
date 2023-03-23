package com.sh.oee.notice.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dao.NoticeDao;
import com.sh.oee.notice.model.dto.NoticeKeyword;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int insertKeyword(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return noticeDao.insertKeyword(param);
	}

	@Override
	public List<NoticeKeyword> selectKeywordList(Member member) {
		// TODO Auto-generated method stub
		return noticeDao.selectKeywordList(member);
	}


}
