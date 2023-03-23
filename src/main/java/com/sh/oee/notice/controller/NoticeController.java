package com.sh.oee.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.notice.model.dto.NoticeKeyword;
import com.sh.oee.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	public NoticeService noticeService;
	//-------------------------------하나시작--------------------
	@GetMapping("/noticeKeyword.do")
	public void noticeKeyword() {}
	
	@PostMapping("/keywordInsert.do")
	public String keywordInsert(NoticeKeyword keyword, Authentication authentication) {
		log.debug("keyword = {}", keyword);
		// 1. db변경
		int result = noticeService.keywordInsert(keyword);
		
		return "redirect:/notice/noticeKeyword.do";
		
	}
	//-------------------------------하나 끝---------------------
}