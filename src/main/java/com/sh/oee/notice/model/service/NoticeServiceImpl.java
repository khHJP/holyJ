package com.sh.oee.notice.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.notice.model.dao.NoticeDao;
import com.sh.oee.notice.model.dto.NoticeKeyword;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public int keywordInsert(NoticeKeyword keyword) {
		// TODO Auto-generated method stub
		return noticeDao.keywordInsert(keyword);
	}

}
