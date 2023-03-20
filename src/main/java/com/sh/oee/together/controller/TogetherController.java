package com.sh.oee.together.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/together")
@Slf4j
public class TogetherController {
	
	@Autowired
	private TogetherService togetherService;
	
	//--------------- 하나 시작 ---------------------------------------
		@GetMapping("/myTogether.do")
		public void myTogether(Model model, String memberId) {}
		
	//-------------- 하나 끝 ------------------------------------------
}
