package com.sh.oee.member.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.sh.oee.member.model.dto.DongRangeEnum;
import com.sh.oee.member.model.dto.Gu;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})
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

	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAtrr) {
		log.debug("member = {}", member);
		String rawPassword = member.getPassword();
		
		// 비밀번호 복호화
		String encodePassword = passwordEncoder.encode(rawPassword);
		member.setPassword(encodePassword);
		log.debug("member = {} ", member);
		
		int result = memberService.insertMember(member);
		
		redirectAtrr.addFlashAttribute("msg", "오이 가족이 되신걸 환영합니다!");
		
		return "redirect:/";
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
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMember(memberId);
		boolean available = (member == null);

		map.put("memberId", memberId);
		map.put("available", available);

		return map;
	}
	
	@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpSession session, Model model) {
		// 인증에 성공한 loginMember
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Member loginMember = (Member) authentication.getPrincipal();
		
		// 내 동네 정보
		String dongs = memberService.selectDongNearOnly(loginMember.getDongNo());
		
		if(loginMember.getDongRange().equals(DongRangeEnum.F)) {
			dongs += ("," +  memberService.selectDongNearFar(loginMember.getDongNo()));
		}
		
		List<String> dongList = Arrays.asList(dongs.split(","));
		log.debug("dongList = {}", dongList);
		
		session.setAttribute("myDongList", dongList); // @SessionAttributes는 객체만 저장할 수 있기때문에 HttpSession에 저장
		
		// 필요한 로그인 후 처리 - 리다이렉트 되는 url을 변경하면 접근하려던 페이지에 대한 처리는 직접해야함
		String location = "/";
		
		// 시큐어리티가 지정한 리다이렉트 url 가져오기
		SavedRequest savedRequest = (SavedRequest)session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		if(savedRequest != null)
			location = savedRequest.getRedirectUrl();
		
		log.debug("location = {}", location);
		
		return "redirect:" + location;
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
	public void memberDetail(Model model, Authentication authentication) {
		List<Gu> guList = memberService.selectGuList();
		log.debug("guList = {}", guList);
		List<Dong> dongList = memberService.selectDongList();
		log.debug("dongList = {}", dongList);

		model.addAttribute("guList", guList);
		model.addAttribute("dongList", dongList);
		
		log.debug("authentication = {}", authentication);
		log.debug("member = {}", model);
		/*
		Member princiapal = (Member) authentication.getPrincipal();
		List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) authentication.getAuthorities();
		*/
	}

	@GetMapping("/myLocal.do")
	public void myLocal(Model model, String memberId) {
		

	}

	
	 @GetMapping("/myTogether.do") 
	 public void together(@RequestParam String memberId, Model model) { 
		 log.debug("memberId = {}", memberId);
	  
	 }
	 
	 @PostMapping("/memberUpdate.do")
		public String memberUpdate(Member member, Authentication authentication) {
			log.debug("member = {}", member);
			// 1. db변경
			int result = memberService.updateMember(member);
			// 2. security context의 인증객체 갱신
			Member newMember = member;
			Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
					newMember,
					authentication.getCredentials(),
					authentication.getAuthorities()
			);
			SecurityContextHolder.getContext().setAuthentication(newAuthentication);
			
			return "redirect:/member/memberDetail.do";
	 }
	 
	 @PostMapping("/memberDelete.do")
	 public String memberDelete(Member member, Authentication authentication) {
		 log.debug("member = {}", member);
		 // 1. db변경
		 int result = memberService.memberDelete(member);
		 
		 return "redirect:/";
	 }
	 

	// @RequestMapping("/member") 작성
	// views에 member folder 생성후 myPage.jsp 생성
	// -------------- 하나 끝 --------------------------------------------

}