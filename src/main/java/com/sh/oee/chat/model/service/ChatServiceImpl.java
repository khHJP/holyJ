package com.sh.oee.chat.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.chat.model.dao.ChatDao;
import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(rollbackFor = Exception.class)
@Slf4j
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;

	/**
	 * SELECT
	 * - 로그인한 사용자 id, 중고거래 게시글no 
	 * - CRAIG_CHAT에서 chatroomId 조회
	 */
	@Override 
	public String findCraigChatroomId(Map<String, Object> craigChatMap) {
		return chatDao.findCraigChatroomId(craigChatMap);
	}

	/**
	 * INSERT
	 * - chatMembers에 담아온 chatroomId, 사용자id, 게시글no 
	 * - CRAIG_CHAT컬럼추가
	 */
	@Override 
	public int createCraigChatroom(List<CraigChat> chatMembers) {
		int result = 0;
		
		for(CraigChat chatMember :chatMembers) {
			result = chatDao.insertCraigChatroom(chatMember);
		}
		return result;
	}

	/**
	 * SELECT
	 * - CRAIG_MSG에서 chatroomId로 채팅내역 조회
	 */
	@Override // 채팅방id로 채팅내역 select 
	public List<CraigMsg> findCraigMsgBychatroomId(String chatroomId) {
		return chatDao.findCraigMsgBychatroomId(chatroomId);
	}
	
	/**
	 * SELECT
	 * - CRAIG_CHAT에서 starUser에 담아온 memberId, chatroomId로 대화 상대 조회
	 */
	@Override
	public String findOtherFromCraigChat(Map<String, Object> startUser) {
		return chatDao.findOtherFromCraigChat(startUser);
	}

	/**
	 * SELECT
	 * - CRAIG_CHAT에서 craigChatMap에 담아온 memberId, 게시글id로 판매자 채팅목록 조회
	 */
	@Override
	public List<String> findCraigChatList(Map<String, Object> craigChatMap) {
		return chatDao.findCraigChatList(craigChatMap);
	}

	/**
	 * SELECT
	 * - CRAIG_MSG에서 chatroomId에 해당하는 마지막 채팅 가져오기
	 */
	@Override
	public CraigMsg findLastCraigMsgByChatroomId(String chatroomId) {
		return chatDao.findLastCraigMsgByChatroomId(chatroomId);
	}

	/**
	 * INSERT
	 * - 받아온 중고거래 채팅방의 메시지를 CRAIG_MSG에 삽입
	 */
	@Override
	public int insertCraigMsg(CraigMsg craigMsg) {
		return chatDao.insertCraigMsg(craigMsg);
	}

	@Override
	public CraigChat findCraigChat(Map<String, Object> craigChatMap) {
		return chatDao.findCraigChat(craigChatMap);
	}

	/**
	 * SELECT
	 * - chatroomId, delDate 받아와 delDate 이후의 메시지만 가져옴
	 */
	@Override
	public List<CraigMsg> findCraigMsgAfterReg(Map<String, Object> delMap) {
		return chatDao.findCraigMsgAfterReg(delMap);
	}

	/**
	 * UPDATE
	 * - del_date를 현재 날짜로 변경
	 */
	@Override
	public int updateDel(Map<String, Object> delMap) {
		return chatDao.updateDel(delMap);
	}

	@Override
	public int updateRegDel(Map<String, Object> regDelMap) {
		return chatDao.updateRegDel(regDelMap);
	}
	
}
