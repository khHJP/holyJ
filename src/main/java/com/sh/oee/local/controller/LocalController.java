package com.sh.oee.local.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.local.model.dto.Local;
import com.sh.oee.local.model.dto.LocalComment;
import com.sh.oee.local.model.service.LocalService;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dto.Together;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j 
@RequestMapping("/local")
public class LocalController {
	
	@Autowired
	private LocalService localService;
	
	//동네생활 게시물 목록
	@GetMapping("/localList.do")
	public void localList(Model model) {
		
		List<Local> localList = localService.localList();
		List<Map<String,String>> localCategory = localService.localCategoryList();
		
		log.debug("localList : {}", localList);
		log.debug("localCategory = {} ", localCategory);
		
		model.addAttribute("localList", localList);
		model.addAttribute("localCategory",localCategory);
	}
	
	// 동네생활 글쓰기 페이지
	@GetMapping("/localEnroll.do")
	public void localEnroll(Model model) {
		
		List<Map<String,String>> localCategory = localService.localCategoryList();
		
		log.debug("localCategroy = {}", localCategory);
		
		model.addAttribute("localCategory",localCategory);
	}
	
	//동네생활 글 등록
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//--------------- 하나 시작 ---------------------------------------
	// 게시글 가져오기
	@GetMapping("/myLocal.do")
	public void local(Authentication authentication, Model model) {
		// member  
		Member member = ((Member)authentication.getPrincipal());
		log.debug("member = {} ", member);
		
		List<Local> myLocal = localService.selectLocalList(member);
		
		log.debug("myLocal = {}",myLocal);
		
		model.addAttribute("myLocal",myLocal);
	}
	// 댓글 가져오기
	@GetMapping("/myLocalComment.do")
	public void localComment(Model model) {		
		//List<LocalComment> myLocalComment = localService.selectLocalCommentList();
		
		//log.debug("myLocalComment = {}",myLocalComment);
		
		//model.addAttribute("myLocalComment",myLocalComment);
	}
	
	//-------------- 하나 끝 ------------------------------------------
	
	
	
}
