package com.sh.oee.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member")
@Controller
public class MemberController {

	@Autowired
	private MemberService memberSerive;
	

	@GetMapping("/temp.do")
	public String temp() {
		return "common/temp";
	}
	
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

	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {} 
	
}
