package com.sh.oee.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dto.NoticeAdmin;
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
	        
	         int result = noticeService.insertKeyword(param);
	     //   log.debug("result = {}",result);

	        
	        redirectAttr.addFlashAttribute("msg", "키워드를 성공적으로 등록했습니다.");
	        return "redirect:/notice/noticeKeywordList.do";
	        
	    }
	    @ResponseBody
	    @PostMapping("/deleteKeyword.do")
	    public int deleteKeyword(@RequestParam int keywordNo){
			log.debug("keywordNo = {}", keywordNo);
			
			//redirectAttr.addFlashAttribute("msg", "키워드를 삭제했습니다.");
			return noticeService.deleteKeyword(keywordNo);
	    }
	//-------------------------------하나 끝---------------------
	    
	    /* 예지 시작 */
	    
	    @GetMapping("/newNotice.do")
	    public void newNotice (Model model) {}
	    
	    @GetMapping("/allNotice.do")
	    public void allNotice (@RequestParam(defaultValue = "1") int currentPage, Model model) {
			// 페이지 처리
			int limit = 4;
			int offset = (currentPage - 1) * limit;
			RowBounds rowBounds = new RowBounds(offset, limit);
			
			int totalCount = 0;
			int totalPages = 0;
			
	    	List<NoticeAdmin> adminNoticeList = noticeService.selectAdminNoticeList(rowBounds);
	    	log.debug("adminNoticeList = {}", adminNoticeList);
	    	
			totalCount = noticeService.selectAdminNoticeTotalCount();
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());
	    	
	    	model.addAttribute("adminNoticeList", adminNoticeList);
			model.addAttribute("totalPages", totalPages);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("limit", limit);
	    }
	    
	    @GetMapping("/adminNoticeList.do")
	    public void adminNoticeList (@RequestParam(defaultValue = "1") int currentPage, Model model) {
			// 페이지 처리
			int limit = 10;
			int offset = (currentPage - 1) * limit;
			RowBounds rowBounds = new RowBounds(offset, limit);
			
			int totalCount = 0;
			int totalPages = 0;
			
	    	List<NoticeAdmin> adminNoticeList = noticeService.selectAdminNoticeList(rowBounds);
	    	log.debug("adminNoticeList = {}", adminNoticeList);
	    	
			totalCount = noticeService.selectAdminNoticeTotalCount();
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());
	    	
	    	model.addAttribute("adminNoticeList", adminNoticeList);
			model.addAttribute("totalPages", totalPages);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("limit", limit);
	    }
	    
	    @MessageMapping("/admin/notice")
	    @SendTo("/app/admin/notice")
	    public NoticeAdmin adminNotice(NoticeAdmin notice) {
	    	log.debug("/admin/notice : notice = {}", notice);
	    	
	    	int result = noticeService.insertAdminNotice(notice);	  
	    	log.debug("notice = {}", notice);
	    	
	    	return notice;
	    }
	    
	    @PostMapping("/adminNoticeDelete.do")
	    public String adminNoticeDelete(@RequestParam int no, RedirectAttributes redirectAttr, SessionStatus status) {
			// 업무 로직
			log.debug("no = {}", no);

			int result = noticeService.deleteAdminNotice(no);

			if (!status.isComplete()) {
				status.setComplete();
			}

			// view
			redirectAttr.addFlashAttribute("msg", "전체 공지 삭제 성공!");

			return "redirect:/notice/adminNoticeList.do";
	    }
	    
	    /* 예지 끝 */
}