package com.sh.oee.chat.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.chat.model.dao.ChatDao;

@Service
@Transactional(rollbackFor = Exception.class)
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;

	@Override // 로그인한 사용자 id, 중고거래 게시글no로 chatroomId 찾기
	public String findCraigChatroomId(String memberId, int craigNo) {
		return chatDao.findCraigChatroomId(memberId, craigNo);
	}
	
}
