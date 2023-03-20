package com.sh.oee.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member")
@Controller
@SessionAttributes("loginMember")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	/**
	 * 정은 시작
	 */
	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {} 
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin(String memberId, String password, Model model, RedirectAttributes redirectAttr) {
		log.debug("memberId = {} ", memberId);
		log.debug("password = {} ", password);
		
		Member member = memberService.selectOneMember(memberId);
		log.debug("member = {} ", member);
		
		// 로그인 성공
		if(member != null) {
			model.addAttribute("loginMember", member);
		}
		// 로그인 실패
		else {
			redirectAttr.addFlashAttribute("msg", "사용자 아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/memberLogout.do")
	public String memberLogout(SessionStatus status) {
		if(!status.isComplete()) {
			status.setComplete();
		}
		return "redirect:/";
	}
	
	/**
	 * 정은 끝
	 */
	
	
	//--------------- 하나 시작----------------------------------------
	@GetMapping("/myPage.do")
	public void myPage() {}
	@GetMapping("/myProfile.do")
	public void myProfile() {}
	@GetMapping("/memberDetail.do")
	public void memberDetail() {}	

	// @RequestMapping("/member") 작성
	// views에 member folder 생성후 myPage.jsp 생성
	//-------------- 하나 끝 --------------------------------------------
	
}
