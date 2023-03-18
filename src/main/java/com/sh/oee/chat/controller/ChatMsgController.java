package com.sh.oee.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.sh.oee.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatMsgController {

	@Autowired
	private ChatService chatService;
}
