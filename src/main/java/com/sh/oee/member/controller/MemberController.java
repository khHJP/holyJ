package com.sh.oee.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Gu;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({ "loginMember" })
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	/**
	 * 정은 시작
	 */
	@GetMapping("/memberEnroll.do")
	public void memberEnroll(Model model) {
		List<Gu> guList = memberService.selectGuList();
		log.debug("guList = {}", guList);
		List<Dong> dongList = memberService.selectDongList();
		log.debug("dongList = {}", dongList);
		
		model.addAttribute("guList", guList);
		model.addAttribute("dongList", dongList);
	}

	@GetMapping("/memberLogin.do")
	public void memberLogin() {
		/* return "member/login"; */
	}
	
	
	
	@GetMapping("/memberLogout.do")
	public String memberLogout(SessionStatus status) {
		if (!status.isComplete()) {
			status.setComplete();
		}
		
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("/checkIdDuplicate.do")
	public Map<String, Object> checkIdDuplicate(@RequestParam String memberId){
		Map<String, Object> map = new HashMap<String, Object>();
		Member member = memberService.selectOneMember(memberId);
		boolean available = (member == null);
		
		map.put("memberId", memberId);
		map.put("available", available);
		
		return map;
	}

	/**
	 * 정은 끝
	 */

	// --------------- 하나 시작----------------------------------------
	@GetMapping("/myPage.do")
	public void myPage() {
	}

	@GetMapping("/myProfile.do")
	public void myProfile() {
	}

	@GetMapping("/memberDetail.do")
	public void memberDetail() {
	}

	// @RequestMapping("/member") 작성
	// views에 member folder 생성후 myPage.jsp 생성
	// -------------- 하나 끝 --------------------------------------------

}
