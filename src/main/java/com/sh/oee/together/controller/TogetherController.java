package com.sh.oee.together.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/together")
@Slf4j
public class TogetherController {
	
	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	//--------------- 하나 시작 ---------------------------------------
	@GetMapping("/myTogether.do")
	public void together(@RequestParam String writer, Model model) {
		log.debug("writer = {}", writer);
		
		List<Together> Together = togetherService.selectTogetherList(writer);
		
		log.debug("Together = {}",Together);
		
		model.addAttribute("Together",Together);
	}
		
	//-------------- 하나 끝 ------------------------------------------
	
	
	/**
	 * 정은 시작 👻
	 */
	@GetMapping("/togetherList.do")
	public void togetherList(HttpSession session, Model model) {
		// 나의 동네 범위
		List<String> myDongList = (List<String>)session.getAttribute("myDongList");
		log.debug("myDongList ={}", myDongList);
		
		List<Map<String,String>> categorys = togetherService.selectTogetherCategory();
		List<Together> togetherList = togetherService.selectTogetherListByDongName(myDongList);
		
		model.addAttribute("categorys", categorys);
		model.addAttribute("togetherList", togetherList);
		
	}
	
	
	/**
	 * 정은 끝 👻
	 */
	
}
