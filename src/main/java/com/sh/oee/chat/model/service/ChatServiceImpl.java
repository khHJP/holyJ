package com.sh.oee.chat.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.chat.model.dao.ChatDao;

@Service
@Transactional(rollbackFor = Exception.class)
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDao chatDao;
	
}
