package com.sh.oee.manner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	@GetMapping("/sendManner.do")
	public void sendMannerList(Authentication authentication, @RequestParam int no, Model model) {		
		String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("no", no);
		
		
		List<Manner> sendMannerList = mannerService.selectSendMannerList(param);
		
		log.debug("sendMannerList = {}",sendMannerList);
		
		model.addAttribute("sendMannerList",sendMannerList);
	}
	@GetMapping("/takeManner.do")
	public void takeMannerList(Authentication authentication, @RequestParam int no, Model model) {		
		String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("no", no);
		
		
		List<Manner> takeMannerList = mannerService.selectTakeMannerList(param);
		
		log.debug("takeMannerList = {}",takeMannerList);
		
		model.addAttribute("takeMannerList",takeMannerList);
	}
	@GetMapping("/myManner1.do")
	public void mannerList(String memberId, Model model) {		
		
		List<Manner> mannerList = mannerService.selectMannerList1(memberId);
		
		log.debug("mannerList = {}",mannerList);
		
		model.addAttribute("mannerList",mannerList);
	}
	
	//-------------- 하나 끝 ------------------------------------------
	
	
	
	
	
	
	
	
	
	//혜진시작 0406
	@PostMapping("/craigMannerEnroll.do")
	public String craigMannerEnroll(Manner manner, Model model, @RequestParam String chatroomId, RedirectAttributes redirectAttr) {
		log.debug("■ manner ={}", manner );
		
		String memberId = manner.getWriter();
		int no = manner.getCraigNo();
		
		int result = mannerService.craigMannerEnroll( manner );		
		log.debug("result = {}",result);
		
		redirectAttr.addFlashAttribute("msg", "거래 후기를 성공적으로 보냈습니다😊");

		model.addAttribute("mannerresult", result);
		return "redirect:/chat/craigChat.do?chatroomId="+ chatroomId + "&memberId=" + memberId + "&craigNo="+no;
	}
	
	
	
	
	
	
	
	
	
	
}
