package com.sh.oee.together.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;
import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/together")
@Slf4j
public class TogetherController {
	
	@Autowired
	private TogetherService togetherService;
	
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	//--------------- 하나 시작 ---------------------------------------
	@GetMapping("/myTogether.do")
	public void together(Authentication authentication, Model model) {
		// member  
		Member member = ((Member)authentication.getPrincipal());
		log.debug("member = {} ", member);
		
		List<Together> myTogether = togetherService.selectTogetherList(member);
		
		log.debug("myTogether = {}",myTogether);
		
		model.addAttribute("myTogether",myTogether);
	}
		
	//-------------- 하나 끝 ------------------------------------------
	
	
	/** 정은 시작 👻 */
	
	/**
	 * 같이해요 목록조회
	 * @param session
	 * @param model
	 */
	@GetMapping("/togetherList.do")
	public void togetherList(HttpSession session, Model model) {
		// 나의 동네 범위
		List<String> myDongList = (List<String>)session.getAttribute("myDongList");
		log.debug("myDongList ={}", myDongList);
		
		List<Map<String,String>> categorys = togetherService.selectTogetherCategory();
		List<Together> togetherList = togetherService.selectTogetherListByDongName(myDongList);
		log.debug("togetherList = {}", togetherList);
		
		model.addAttribute("categorys", categorys);
		model.addAttribute("togetherList", togetherList);
		
	}
	
	@GetMapping("/togetherDetail.do")
	public void togetherDetail(@RequestParam int no, Model model) {
		log.debug("no = {}", no);
		
	}
	
	/** 정은 끝 👻 */
	
}
