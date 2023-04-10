package com.sh.oee.member.controller;


import java.net.URLEncoder;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.common.OeeUtils;
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
	private ServletContext application;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	/** 👻 정은 시작 👻 */
	
	/**
	 * 회원가입 폼 불러오기
	 * @param model
	 */
	@GetMapping("/memberEnroll.do")
	public void memberEnroll(Model model) {
		// 업무로직
		List<Gu> guList = memberService.selectGuList();
		log.debug("guList = {}", guList);
		List<Dong> dongList = memberService.selectDongList();
		log.debug("dongList = {}", dongList);

		// view 전달
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
		
		// 업무로직
		int result = memberService.insertMember(member);
		
		// view 전달
		redirectAtrr.addFlashAttribute("congratulation", "오이 가족이 되신걸 환영합니다!"); 
		
		return "redirect:/";
	}
	
	/**
	 * 로그인 폼 불러오기
	 */
	@GetMapping("/memberLogin.do")
	public void memberLogin() {}

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
		
		// 업무로직
		Member member = memberService.selectOneMember(memberId);
		boolean available = (member == null);

		// view 전달
		map.put("memberId", memberId);
		map.put("available", available);

		return map;
	}
	
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

	/** 👻 정은 끝 👻 */

	/** 🐱 하나 시작 🐱 */
	@GetMapping("/myPage.do")
	public void myPage() {
	}

	@GetMapping("/myProfile.do")
	public void myProfile() {
	}

	@GetMapping("/memberDetail.do")
	public void memberDetail(Authentication authentication) {
		Member princiapal = (Member) authentication.getPrincipal();
		List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) authentication.getAuthorities();
		
	}
	 
	 @PostMapping("/memberUpdate.do")
		public String memberUpdate(Member member, 
				Authentication authentication,
				@RequestParam("upFile") MultipartFile imageUpload,
				RedirectAttributes redirectAttr) {
			log.debug("member = {}", member);
			String rawPassword = member.getPassword();
			String encodePassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encodePassword);
			
			// 업로드 된 파일
			log.debug("imageUpload = {}", imageUpload);
			// 이미지 저장 주소
			String saveDirectory = application.getRealPath("/resources/upload/profile");
			log.debug("saveDirectory = {}", saveDirectory);
			
			// 만약 업로드된 사이즈가 0보다 크면
			if(imageUpload.getSize() > 0) {
				// OeeUtils에 가서 파일 이름을 가져온다.
				String profileImg = OeeUtils.idMultipartFile(imageUpload, authentication);
				// 파일지정 주소와 memberId.확장자를 새로운 File객체에 덮어씌운다.
				File destFile = new File(saveDirectory, profileImg);
				 try {
					 // imageUpload에 destFile을 업로드 한다.
					 imageUpload.transferTo(destFile);
				 }catch (IllegalStateException | IOException e) {
						log.error(e.getMessage(), e);
				 }
				 log.debug("profileImg = {} ",profileImg);
				 // 2. profile member에 추가		
				 member.setProfileImg(profileImg);
			}
			else {
				member.setProfileImg("oee.png");
			}
			// 1. db변경
			int result = memberService.updateMember(member);			
			
			// 2. security context의 인증객체 갱신
			Member newMember = memberService.selectOneMember(member.getMemberId());
			Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
					newMember,
					authentication.getCredentials(),
					authentication.getAuthorities()
			);
			SecurityContextHolder.getContext().setAuthentication(newAuthentication);
			
			redirectAttr.addFlashAttribute("msg", "회원 정보 수정 성공!");
			
			return "redirect:/member/memberDetail.do";
	 }
	 
	 @PostMapping("/memberDelete.do")
	 public String memberDelete(Authentication authentication, RedirectAttributes redirectAttr, SessionStatus sessionStatus) {
		 String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		 log.debug("memberId = {}", memberId);
		 
		 // 1. db변경
		 int result = memberService.memberDelete(memberId);
		
		 if(result>0) {
				SecurityContextHolder.clearContext();
				redirectAttr.addFlashAttribute("msg", "성공적으로 회원정보를 삭제했습니다.");
			}
			else 
				redirectAttr.addFlashAttribute("msg", "회원정보 삭제에 실패했습니다.");

			return "redirect:/";
	 }
	 
	 @PostMapping("/pwCheck.do")
	 public String pwdoubleCheck(Authentication authentication, @RequestParam String password, RedirectAttributes redirectAttr) {
		 String pword = ((Member) authentication.getPrincipal()).getPassword();
		 if(passwordEncoder.matches(password, pword)) {
			 return "redirect:/member/memberDetail.do";			 
		 }
		 else {
			 redirectAttr.addFlashAttribute("msg", "비밀번호를 다시 확인해 주세요.");
			 return "redirect:/member/pwCheck.do";
		 }
		 
	 }
	
	 @GetMapping("/pwCheck.do")
	 public void pwCheck(Authentication authentication) {	 }

	// @RequestMapping("/member") 작성
	// views에 member folder 생성후 myPage.jsp 생성
	 /** 🐱 하나 끝 🐱 */


}