package com.sh.oee.chat.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.service.ChatService;
import com.sh.oee.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private ChatService chatService;
	
	@GetMapping("/chatList.do")
	public void chatList(Model model) {
		// 중고거래 채팅목록 조회

	}
	
	/**
	 * 중고거래 게시글에서 채팅하기 선택시
	 */
	@GetMapping("/craigChat/{craigNo}/{sellerId}")
	public void craigChat(@PathVariable int craigNo, @PathVariable String sellerId, Authentication authentication, Model model, HttpSession session){
		
		// 로그인한 사용자 id
		String memberId = ((Member) authentication.getPrincipal()).getMemberId();
		log.debug("memberId = {}", memberId);
		
		log.debug("닉네임 = {}", sellerId);
		
		// chatroom_id 조회
		String chatroomId = chatService.findCraigChatroomId(memberId, craigNo);
		log.debug("craigNo = {}", craigNo);

		// 채팅방 첫 입장
		if(chatroomId == null) {
			// 1. chatroomId 생성
			chatroomId = generateCraigChatroomId();
			
			// 2. craig_chat 테이블에 2행 insert (로그인한 사용자memberId, 게시글 작성자 sellerId)
			List<CraigChat> craigChat = Arrays.asList(
					new CraigChat(chatroomId, memberId),
					new CraigChat(chatroomId, sellerId));
//			int result = chatService.createCraigChatroom(craigChat);
		}
		
		
		// 기존에 존재하던 채팅방
		else {
			
		}
	}
	
	/**
	 * 중고거래 채팅방 chatroomId 생성
	 */
	private String generateCraigChatroomId() {
		StringBuilder chatroomId = new StringBuilder();
		Random random = new Random();
		final int LEN = 12;
		// 반복처리
		for(int i = 0; i < LEN; i++) {
			// 숫자
			if(random.nextBoolean()) {
				chatroomId.append(random.nextInt(10));
			}
			// 영문자
			else {
				// 대문자
				if(random.nextBoolean()) {
					chatroomId.append((char) (random.nextInt(26) + 'A'));
				}
				// 소문자
				else {
					chatroomId.append((char) (random.nextInt(26) + 'a'));
				}
			}
		}
		return chatroomId.toString();
	}
	
	@GetMapping("/chat.do")
	public void chat(@RequestParam String chatroomId, Model model) {
	//	List<CraigMsg> craigMsg = chatService.findCraigMsgByChatroomId(chatroomId);
	//	model.addAttribute("craigMsg", craigMsg);
	}
}
