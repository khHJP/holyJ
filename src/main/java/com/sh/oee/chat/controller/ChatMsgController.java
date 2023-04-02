package com.sh.oee.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatMsgController {

	@Autowired
	private ChatService chatService;
	
	/**
	 * 중고거래 채팅방에서 메시지 보낼때 CRAIG_MSG insert 처리
	 */
	@MessageMapping("/craigChat/{chatroomId}")
	@SendTo("/app/craigChat/{chatroomId")
	public CraigMsg craigMsg(CraigMsg craigMsg, @DestinationVariable String chatroomId, MultipartFile upFile) { // @DestinationVariable : Stomp가 사용하는 pathVariable
		log.debug("craigMsg = {}", craigMsg);
		
		// 1. 첨부파일일때
		if(craigMsg.getType().toString() == "FILE") {
			log.debug("나오니? ={}", craigMsg.getContent());
			log.debug("파일은 = {}", upFile);
			// 1. CRAIG_CHAT에 한 행 추가
		
			// 2. CRAIG_CHAT에 추가한 msg_no 가지고 CRAIG_MSG_ATTACH에 한 행 추가
//			MsgAttach attach = new MsgAttach();
//			attach.setMsgNo(msgNo);
//			attach.setOriginalFilename(originalFilename);
//			attach.setReFilename(reFilename);
//			attach.setRegDate(regDate);

		}
		
		// 2. 메시지일때 
		else if(craigMsg.getType().toString() == "CHAT") {
		int result = chatService.insertCraigMsg(craigMsg);
		
		}
		return craigMsg;
	}
	

}
