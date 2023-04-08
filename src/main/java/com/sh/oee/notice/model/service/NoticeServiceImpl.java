package com.sh.oee.notice.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dao.NoticeDao;
import com.sh.oee.notice.model.dto.NoticeUser;
import com.sh.oee.notice.model.dto.NoticeAdmin;
import com.sh.oee.notice.model.dto.NoticeKeyword;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;


	@Override
	public List<NoticeKeyword> selectKeywordList(Member member) {
		// TODO Auto-generated method stub
		return noticeDao.selectKeywordList(member);
	}

	@Override
	public int insertKeyword(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return noticeDao.insertKeyword(param);
	}

	@Override
	public int deleteKeyword(int keywordNo) {
		// TODO Auto-generated method stub
		return noticeDao.deleteKeyword(keywordNo);
	}

	@Override
	public List<NoticeAdmin> selectAdminNoticeList() {
		return noticeDao.selectAdminNoticeList();
	}

	@Override
	public int insertAdminNotice(NoticeAdmin notice) {
		return noticeDao.insertAdminNotice(notice);
	}

	@Override
	public int deleteAdminNotice(int no) {
		return noticeDao.deleteAdminNotice(no);
	}

	@Override
	public int selectAdminNoticeTotalCount() {
		return noticeDao.selectAdminNoticeTotalCount();
	}


}
