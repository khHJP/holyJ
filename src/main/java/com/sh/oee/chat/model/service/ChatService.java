package com.sh.oee.chat.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.chat.model.dto.TogetherMsg;

import lombok.NonNull;

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.dto.TogetherChat;

public interface ChatService {

	String findCraigChatroomId(Map<String, Object> craigChatMap);

	int createCraigChatroom(List<CraigChat> chatMembers);

	List<CraigMsg> findCraigMsgBychatroomId(String chatroomId);

	String findOtherFromCraigChat(Map<String, Object> startUser);

	List<String> findAllCraigChatroomIds(Map<String, Object> craigChatMap);

	CraigMsg findLastCraigMsgByChatroomId(String chatroomId);

	int insertCraigMsg(CraigMsg craigMsg);

	CraigChat findCraigChat(Map<String, Object> craigChatMap);

	List<CraigMsg> findCraigMsgAfterReg(Map<String, Object> delMap);

	int updateDel(Map<String, Object> delMap);

	int reJoinCraigChat(Map<String, Object> reJoinMap);

	int insertCraigMsgAttach(MsgAttach attach);

	int updateCraigAttachMsgNo(Map<String, Object> map);

	/* 같이해요 시작 */
	TogetherChat findTogetherMember(Map<String, Object> map);

	List<TogetherChat> findAllTogetherMembers(Map<String, Object> map);

	int insertTogetherMember(Map<String, Object> map);

	int insertTogetherMsg(TogetherMsg togetherMsg);
	
	int insertTogetherMsgAttach(MsgAttach attach);
	
	int updateTogetherAttachMsgNo(Map<String, Object> map);

	List<TogetherMsg> findTogetherMsgAfterReg(Map<String, Object> regMap);

	/* 나의오이 시작 */
	List<CraigChat> findAllCraigChatroom(String memberId);

	List<TogetherChat> findAllTogetherChatroom(String memberId);

	TogetherMsg findLastTogetherMsgByTogetherNo(@NonNull int togetherNo);

	TogetherChat findTogetherChat(Map<String, Object> findChat);

	int exitTogether(Map<String, Object> delMap);




}
