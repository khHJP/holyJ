package com.sh.oee.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {

	@Autowired
	private MemberService memberSerive;
	
	@GetMapping("/temp.do")
	public String temp() {
		return "common/temp";
	}
}
