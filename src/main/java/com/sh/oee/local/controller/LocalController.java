package com.sh.oee.local.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.local.model.dto.Local;
import com.sh.oee.local.model.service.LocalService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j 
@RequestMapping("/local")
public class LocalController {
	
	@Autowired
	private LocalService localService;
	
	//동네생활 게시물 목록
	@GetMapping("/localList.do")
	public void localList(Model model) {
		
		List<Local> localList = localService.localList();
		List<Map<String,String>> localCategory = localService.localCategoryList();
		
		log.debug("localList : {}", localList);
		log.debug("localCategory = {} ", localCategory);
		model.addAttribute("localList", localList);
		
	}
	
}
