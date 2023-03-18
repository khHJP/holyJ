package com.sh.oee.craig.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.service.CraigService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/craig")
@Controller
public class CraigController {

	@Autowired
	private CraigService craigService;
	
	//전체 중고거래 게시물 조회 - 이렇게 하면 모델에 안담김 그냥 객체 자체를 반환해야할듯 
	// 그리고 @RestController 이거 자체가 걍 데이터를 반환해주는거같음 page 아님 
	// - 추후 멤버별 N/F에 따라서 조회하는게 달라져야되는데 ,, ㄴㅇㄱ
	/**
	@GetMapping("/craigList")
	public String craigList(Model model){
		
		List<Craig> craigList = craigService.craigList();
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		
		log.debug( "■ craigList = {}", craigList);
		log.debug( "■ craigCategory = {}", craigCategory);
		
		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		
		return "forward:/craigList.jsp";
	}
	
	
	**/
	//전체 중고거래 게시물 조회 - 추후 멤버별 N/F에 따라서 조회하는게 달라져야되는데 ,, ㄴㅇㄱ
	@GetMapping("/craigList.do")
	public void craigList(Model model){
		
		List<Craig> craigList = craigService.craigList();
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		
		log.debug( "■ craigList = {}", craigList);
		log.debug( "■ craigCategory = {}", craigCategory);
		
		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		
		return;
	}
	
	//중고거래 게시물 등록
	@GetMapping("/craigEnroll.do")
	public void craigEnroll() {
		return;
	}
	
	
	
}
