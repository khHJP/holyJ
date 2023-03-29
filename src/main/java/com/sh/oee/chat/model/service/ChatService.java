package com.sh.oee.chat.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;

public interface ChatService {

	String findCraigChatroomId(Map<String, Object> craigChatMap);

	int createCraigChatroom(List<CraigChat> chatMembers);

	List<CraigMsg> findCraigMsgBychatroomId(String chatroomId);

	String findOtherFromCraigChat(Map<String, Object> startUser);

	List<String> findCraigChatList(Map<String, Object> craigChatMap);

	CraigMsg findLastCraigMsgByChatroomId(String chatroomId);

	int insertCraigMsg(CraigMsg craigMsg);

}
