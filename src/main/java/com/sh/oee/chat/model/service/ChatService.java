package com.sh.oee.chat.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.chat.model.dto.TogetherMsg;
import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.dto.TogetherChat;

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

	/* 같이해요 시작 */
	TogetherChat findTogetherMember(Map<String, Object> map);

	List<TogetherChat> findAllTogetherMembers(Map<String, Object> map);

	int insertTogetherMember(Map<String, Object> map);

	int insertTogetherMsg(TogetherMsg togetherMsg);
	
	int insertTogetherMsgAttach(MsgAttach attach);
	
	int updateTogetherAttachMsgNo(Map<String, Object> map);

	List<TogetherMsg> findTogetherMsgAfterReg(Map<String, Object> regMap);

	List<CraigChat> findAllCraigChatroom(String memberId);


}
