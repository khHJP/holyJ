package com.sh.oee.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.member.model.dto.Member;
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
	@GetMapping("/noticeKeywordList.do")
	public void noticeKeywordList(Authentication authentication, Model model) {
		// member  
		Member member = ((Member)authentication.getPrincipal());
		log.debug("member = {}", member);
		
		List<NoticeKeyword> noticeKeyword = noticeService.selectKeywordList(member);
		log.debug("noticeKeyword = {}", noticeKeyword);
		
		model.addAttribute("noticeKeyword",noticeKeyword);
		
	}

	@PostMapping("/insertKeyword.do")
	public String insertKeyword(NoticeKeyword keyword, Authentication authentication, 
			RedirectAttributes redirectAttr) {
		
		// member  		
		Member member = ((Member)authentication.getPrincipal());
		log.debug("member = {}", member);
		
		log.debug("keyword = {}", keyword);
		int result = noticeService.insertKeyword(keyword, member);
		
		redirectAttr.addFlashAttribute("msg", "키워드를 성공적으로 등록했습니다.");
		
		
		return "redirect:/notice/noticeKeywordList.do";
		
	}
	//-------------------------------하나 끝---------------------
}