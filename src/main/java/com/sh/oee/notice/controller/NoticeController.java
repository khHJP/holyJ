package com.sh.oee.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	    public String insertKeyword( @RequestParam String keyword, Authentication authentication, 
	            RedirectAttributes redirectAttr) {
	        
	        // member          
//	        Member member = ((Member)authentication.getPrincipal());
	        
	        String memberId = ((Member)authentication.getPrincipal()).getMemberId();
	        
	        log.debug("memberId = {}", memberId);
	        
	        Map<String, Object> param = new HashMap<>();
	        param.put("keyword", keyword);
	        param.put("memberId", memberId);
	        
	        log.debug("param = {}",param);
	        /* log.debug("noticeKeyword = {}", noticeKeyword); */
	        
//	        int result = noticeService.insertKeyword(param);
//	        log.debug("result = {}",result);
	        
	        redirectAttr.addFlashAttribute("msg", "키워드를 성공적으로 등록했습니다.");
	        return "redirect:/notice/noticeKeywordList.do";
	        
	    }
	    
	    @PostMapping("/deleteKeyword.do")
	    public ResponseEntity<?> deleteKeyword(@RequestParam int no, RedirectAttributes redirectAttr){
			log.debug("no = {}", no);
			
			redirectAttr.addFlashAttribute("msg", "키워드를 삭제했습니다.");
			return noticeService.deleteKeyword(no);
	    }
	//-------------------------------하나 끝---------------------
}