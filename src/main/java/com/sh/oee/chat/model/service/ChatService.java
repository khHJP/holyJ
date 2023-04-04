package com.sh.oee.chat.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;

public interface ChatService {

	String findCraigChatroomId(Map<String, Object> craigChatMap);

	int createCraigChatroom(List<CraigChat> chatMembers);

	List<CraigMsg> findCraigMsgBychatroomId(String chatroomId);

	String findOtherFromCraigChat(Map<String, Object> startUser);

	List<String> findCraigChatList(Map<String, Object> craigChatMap);

	CraigMsg findLastCraigMsgByChatroomId(String chatroomId);

	int insertCraigMsg(CraigMsg craigMsg);

	CraigChat findCraigChat(Map<String, Object> craigChatMap);

	List<CraigMsg> findCraigMsgAfterReg(Map<String, Object> delMap);

	int updateDel(Map<String, Object> delMap);

	int updateRegDel(Map<String, Object> regDelMap);

	int insertCraigMsgAttach(MsgAttach attach);

	int updateCraigAttachMsgNo(Map<String, Object> map);

}
