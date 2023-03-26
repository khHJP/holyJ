package com.sh.oee.member.controller;


import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
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

	/** 정은 시작 */
	
	/**
	 * 회원가입 폼 불러오기
	 * @param model
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



	

	
	/**
	 * 회원가입 정보 DB에 저장
	 * @param member
	 * @param redirectAtrr
	 * @return
	 */

	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAtrr) {
		log.debug("member = {}", member);
		String rawPassword = member.getPassword();
		
		// 비밀번호 복호화
		String encodePassword = passwordEncoder.encode(rawPassword);
		member.setPassword(encodePassword);
		log.debug("member = {} ", member);
		
		int result = memberService.insertMember(member);
		
		redirectAtrr.addFlashAttribute("msg", "오이 가족이 되신걸 환영합니다!"); // msg 안나옴,, 왤까,,?
		
		return "redirect:/";
	}

	
	/**
	 * 로그인 폼 불러오기
	 */
	@GetMapping("/memberLogin.do")
	public void memberLogin() {
		/* return "member/login"; */
	}




	/**
	 * 로그아웃
	 * @param status
	 * @return
	 */
	@GetMapping("/memberLogout.do")
	public String memberLogout(SessionStatus status) {
		if (!status.isComplete()) {
			status.setComplete();
		}
		
		return "redirect:/";
	}

	
	/**
	 * 아이디 중복체크 (비동기)
	 * @param memberId
	 * @return
	 */
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
	
	/*@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpSession session, Model model) {
	/**
	 * 로그인 성공시 작동
	 * @param response
	 * @param session
	 * @param request
	 * @return
	 */
	@PostMapping("/loginSuccess.do")
	public String loginSuccess(HttpServletResponse response, HttpSession session, HttpServletRequest request) {
		// 인증에 성공한 loginMember
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Member loginMember = (Member) authentication.getPrincipal();
		
		// 내 동네 정보
		String dongs = memberService.selectMydongName(loginMember.getDongNo());
		dongs += (":" + memberService.selectDongNearOnly(loginMember.getDongNo()));
		
		if(loginMember.getDongRange().equals(DongRangeEnum.F)) {
			dongs += (":" +  memberService.selectDongNearFar(loginMember.getDongNo()));
		}
		log.debug("dons = {}", dongs);
		
//		List<String> dongList = Arrays.asList(dongs.split(","));
//		log.debug("dongList = {}", dongList);
//		session.setAttribute("myDongList", dongList); // @SessionAttributes는 객체만 저장할 수 있기때문에 HttpSession에 저장
		
		String myDong = dongs.replace(",", ":");
		log.debug("myDong = {}", myDong);
		
		// 자동로그인시 세션 값이 증발 문제로 HttpSession 저장대신 Cookie 저장으로 변경 
		Cookie myDongList = new Cookie("myDongList", URLEncoder.encode(myDong)); // 콤마는 쿠키값에 저장 못함
		myDongList.setPath(request.getContextPath());
		myDongList.setMaxAge(60 * 60 * 24 * 30); // 쿠키의 유효기간 설정 (초 단위)
		response.addCookie(myDongList); // 쿠키를 응답에 추가
		
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
		/*List<Gu> guList = memberService.selectGuList();
		log.debug("guList = {}", guList);
		List<Dong> dongList = memberService.selectDongList();
		log.debug("dongList = {}", dongList);

		model.addAttribute("guList", guList);
		model.addAttribute("dongList", dongList);
		
		log.debug("authentication = {}", authentication);*/
		log.debug("member = {}", model);
		
		Member princiapal = (Member) authentication.getPrincipal();
		List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) authentication.getAuthorities();
		
	}
	 
	 @PostMapping("/memberUpdate.do")
		public String memberUpdate(Member member, Authentication authentication) {
		 
			 String rawPassword = member.getPassword();
			 String encodePassword = passwordEncoder.encode(rawPassword);
			 member.setPassword(encodePassword);
			 
			log.debug("member = {}", member);
			// 1. db변경
			int result = memberService.updateMember(member);			
			
			return "redirect:/member/myProfile.do";
	 }
	 
	 @PostMapping("/memberDelete.do")
	 public String memberDelete(Authentication authentication, RedirectAttributes redirectAttr) {
		 String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		 log.debug("memberId = {}", memberId);
		 // 1. db변경
		 int result = memberService.memberDelete(memberId);
		 
		 redirectAttr.addFlashAttribute("msg", "탈퇴되었습니다.");
		 return "redirect:/";
	 }
	 
	 @PostMapping("/updateProfile.do")
	 public void updateProfile(HttpServletRequest request, HttpServletResponse response) {
	 }

	// @RequestMapping("/member") 작성
	// views에 member folder 생성후 myPage.jsp 생성
	// -------------- 하나 끝 --------------------------------------------


}