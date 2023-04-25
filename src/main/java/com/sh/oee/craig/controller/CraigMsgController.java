package com.sh.oee.craig.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.sh.oee.chat.model.service.ChatService;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.service.CraigService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class CraigMsgController {
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private CraigService craigService;
	

}
