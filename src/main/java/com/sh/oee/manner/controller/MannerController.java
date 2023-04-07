package com.sh.oee.manner.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.manner.model.dto.Manner;
import com.sh.oee.manner.model.service.MannerService;
import com.sh.oee.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/manner")
public class MannerController {

	@Autowired
	private MannerService mannerService;
	
	//------------- 하나 시작 ---------------------------------------
	@GetMapping("/myManner.do")
	public void mannerList(Authentication authentication, Model model) {		
		String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		
		List<Manner> mannerList = mannerService.selectMannerList(memberId);
		
		log.debug("mannerList = {}",mannerList);
		
		model.addAttribute("mannerList",mannerList);
	}
	@GetMapping("/myManner1.do")
	public void mannerList(String memberId, Model model) {		
		
		List<Manner> mannerList = mannerService.selectMannerList(memberId);
		
		log.debug("mannerList = {}",mannerList);
		
		model.addAttribute("mannerList",mannerList);
	}
	
	//-------------- 하나 끝 ------------------------------------------
}
