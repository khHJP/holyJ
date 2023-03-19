package com.sh.oee.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sh.oee.member.model.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberSerive;
	
}
