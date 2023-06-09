package com.sh.oee.chat.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.chat.model.dao.ChatDao;
import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.dto.TogetherChat;
import com.sh.oee.chat.model.dto.TogetherMsg;

import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(rollbackFor = Exception.class)
@Slf4j
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;

	/* -------------------- 중고거래 채팅방 ----------------------- */
	/**
	 * SELECT
	 * - CRAIG_CHAT : chatroomId 조회
	 * - memberId + craigNo 
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
	public List<String> findAllCraigChatroomIds(Map<String, Object> craigChatMap) {
		return chatDao.findAllCraigChatroomIds(craigChatMap);
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
	 * - CRAIG_MSG 한 행 추가
	 * - 해당하는 첨부파일이 있다면, 첨부파일 컬럼의 msg_no를 변경
	 */
	@Override
	public int insertCraigMsg(CraigMsg craigMsg) {
		int result = chatDao.insertCraigMsg(craigMsg);
		MsgAttach attach = chatDao.findCraigMsgAttach(craigMsg.getContent());
		Map<String, Object> map = new HashMap<>();
		
		if(attach != null) {
			map.put("msgNo", craigMsg.getMsgNo()); // msg_no 가져오기
			map.put("reFilename", craigMsg.getContent());
			result = updateCraigAttachMsgNo(map);
		}
		
		return result;
	}

	@Override
	public int updateCraigAttachMsgNo(Map<String, Object> map) {
		return chatDao.updateCraigAttachMsgNo(map);
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
	public int exitCraigChat(Map<String, Object> delMap) {
		return chatDao.exitCraigChat(delMap);
	}

	/**
	 * UPDATE
	 * - reg_date를 현재 날짜로, del_date을 null로 변경
	 */
	@Override
	public int reJoinCraigChat(Map<String, Object> reJoinMap) {
		return chatDao.reJoinCraigChat(reJoinMap);
	}
	
	@Override
	public int insertCraigMsgAttach(MsgAttach attach) {
		return chatDao.insertCraigMsgAttach(attach);
	}

	/* -------------------- 같이해요 채팅방 시작 ----------------------- */
	@Override
	public TogetherChat findTogetherMember(Map<String, Object> map) {
		return chatDao.findTogetherMember(map);
	}
	@Override
	public List<TogetherChat> findAllTogetherMembers(Map<String, Object> map) {
		return chatDao.findAllTogetherMembers(map);
	}
	@Override
	public int insertTogetherMember(Map<String, Object> map) {
		return chatDao.insertTogetherMember(map);
	}
	@Override
	public int insertTogetherMsg(TogetherMsg togetherMsg) {
		int result = chatDao.insertTogetherMsg(togetherMsg);
		MsgAttach attach = chatDao.findTogetherMsgAttach(togetherMsg.getContent());
		
		log.debug("첨부파일 = {}", attach);
		Map<String, Object> map = new HashMap<>();
		
		if(attach != null) {
			map.put("msgNo", togetherMsg.getMsgNo());
			map.put("reFilename", togetherMsg.getContent());
			result = updateTogetherAttachMsgNo(map);
			
			log.debug("msgNo = {}", togetherMsg.getMsgNo());
		}
		
		return result;
	}
	
	@Override
	public int insertTogetherMsgAttach(MsgAttach attach) {
		return chatDao.insertTogetherMsgAttach(attach);
	}

	@Override
	public int updateTogetherAttachMsgNo(Map<String, Object> map) {
		return chatDao.updateTogetherAttachMsgNo(map);
	}
	@Override
	public List<TogetherMsg> findTogetherMsgAfterReg(Map<String, Object> regMap) {
		return chatDao.findTogetherMsgAfterReg(regMap);
	}
	@Override
	public int exitTogether(Map<String, Object> delMap) {
		return chatDao.exitTogether(delMap);
	}
	
	
	/**   나의 오이    **/
	@Override
	public List<CraigChat> findAllCraigChatroom(String memberId) {
		return chatDao.findAllCraigChatroom(memberId);
	}
	@Override
	public List<TogetherChat> findAllTogetherChatroom(String memberId) {
		return chatDao.findAllTogetherChatroom(memberId);
	}
	@Override
	public TogetherMsg findLastTogetherMsgByTogetherNo(int togetherNo) {
		return chatDao.findLastTogetherMsgByTogetherNo(togetherNo);
	}
	@Override
	public TogetherChat findTogetherChat(Map<String, Object> findChat) {
		return chatDao.findTogetherChat(findChat);
	}
}
