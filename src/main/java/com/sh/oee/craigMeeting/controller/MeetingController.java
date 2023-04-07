package com.sh.oee.craigMeeting.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sh.oee.chat.model.service.ChatService;
import com.sh.oee.craig.model.service.CraigService;
import com.sh.oee.craigMeeting.model.service.MeetingService;
import com.sh.oee.member.model.service.MemberService;
import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/craigMeeting")
public class MeetingController {

	@Autowired
	private ChatService chatService;
	@Autowired
	private CraigService craigService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private TogetherService togetherService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private ServletContext application;

	/**
	 * 중고거래 예약 처리
	 */
	@PostMapping("/enrollMeeting")
	@ResponseBody
	public Map<String, Object> craigMeeting(String chatroomId, String memberId, String meetingDate){
		log.debug("오셨나욥 = {}", chatroomId);

		// 1. 문자열로 받아온 meetingDate을 LocalDateTime으로 변환
		LocalDateTime date = LocalDateTime.parse(meetingDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")); 
		log.debug("날짜보자 = {}", date);
		
		// 2. CRAIG_MEETING 테이블에 insert 
		
		// chatroomId로 craigNo 찾기
		Map<String, Object> chatMap = new HashMap<>();
		chatMap.put("chatroomId", chatroomId);
		chatMap.put("memberId", memberId);
		int no = chatService.findCraigChat(chatMap).getCraigNo();
		
		// insert
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("chatroomId", chatroomId);
		map.put("memberId", memberId);
		map.put("date", date);
		
		// BUYER 아이디 찾기
		// 판매자아이디, 채팅방 아이디로 판매자 외의 다른 멤버 가져옴
		String seller = craigService.findCraigByCraigNo(no).getWriter();
		Map<String, Object> otherMap = new HashMap<>();
		otherMap.put("memberId", seller);
		otherMap.put("chatroomId", chatroomId);
		
		String buyer = chatService.findOtherFromCraigChat(otherMap);

		map.put("buyer", buyer);
		
		int result = meetingService.enrollMeeting(map);
		
		return map;
	}
	
	/**
	 * 장소공유시 update처리
	 */
	@PostMapping("/enrollMeetingPlace")
	@ResponseBody
	public void enrollMeetingPlace(int no, String meetingLat, String meetingLon){
		log.debug("약속번호 = {}", no);
		log.debug("위도 = {}", meetingLat);
		log.debug("경도 = {}", meetingLon);
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("meetingLat", meetingLat);
		map.put("meetingLon", meetingLon);
		
		int result = meetingService.enrollMeetingPlace(map);
	}
}
