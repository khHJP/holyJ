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
	@SendTo("/app/craigChat/{chatroomId}")
	public CraigMsg craigMsg(CraigMsg craigMsg, @DestinationVariable String chatroomId) { // @DestinationVariable : Stomp가 사용하는 pathVariable
		int result = chatService.insertCraigMsg(craigMsg);		
		
		log.debug("craigMsg메시지 = {}", craigMsg);

		return craigMsg;
	}

}
