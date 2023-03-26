package com.sh.oee.together.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.oee.common.OeeUtils;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;
import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/together")
@Slf4j
public class TogetherController {
	
	@Autowired
	private TogetherService togetherService;
	
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	/** 🐱 하나 시작 🐱 */
	@GetMapping("/myTogether.do")
	public void together(Authentication authentication, Model model) {
		// member  
		Member member = ((Member)authentication.getPrincipal());
		log.debug("member = {} ", member);
		
		List<Together> myTogether = togetherService.selectTogetherList(member);
		
		log.debug("myTogether = {}",myTogether);
		
		model.addAttribute("myTogether",myTogether);
	}
		
	/** 🐱 하나 끝 🐱 */
	
	
	/** 👻 정은 시작 👻 */
	
	/**
	 * 같이해요 목록조회
	 * @param session
	 * @param model
	 */
	@GetMapping("/togetherList.do")
	public void togetherList(HttpSession session, Model model) {
		// 나의 동네범위 꺼내기
		List<String> myDongList = (List<String>)session.getAttribute("myDongList");
		log.debug("myDongList ={}", myDongList);
		
		// 업무로직
		List<Map<String,String>> categorys = togetherService.selectTogetherCategory();
		List<Together> togetherList = togetherService.selectTogetherListByDongName(myDongList);
		log.debug("togetherList = {}", togetherList);
		
		// view 전달
		model.addAttribute("categorys", categorys);
		model.addAttribute("togetherList", togetherList);
		
	}
	
	/**
	 * 같이해요 상세조회
	 * @param no
	 * @param model
	 */
	@GetMapping("/togetherDetail.do")
	public void togetherDetail(@RequestParam(defaultValue = "") String category, @RequestParam int no, Model model) {
		log.debug("no = {}", no);
		
		// 업무로직
		Together together = togetherService.selectTogetherByNo(no);
		log.debug("together = {}", together);
		
		// 개행, 자바스크립트 코드 방어
		together.setContent(OeeUtils.convertLineFeedToBr(OeeUtils.escapeHtml(together.getContent())));
		
		// view 전달
		model.addAttribute("together", together);
		model.addAttribute("category", category);
		
	}
	
	/**
	 * 같이해요 폼 불러오기
	 * @param model
	 */
	@GetMapping("/togetherEnroll.do")
	public void togetherEnroll(Model model) {	
		// 업무로직
		List<Map<String,String>> categorys = togetherService.selectTogetherCategory();
		
		// view 전달
		model.addAttribute("categorys", categorys);
	}
	
	@PostMapping("/togetherEnroll.do")
	public String togetherEnroll(TogetherEntity together, 
								@RequestParam String month,
								@RequestParam String date,
								@RequestParam String meridiem,
								@RequestParam String hour,
								@RequestParam String minute) {
		
		log.debug("together = {}", together);
		log.debug("month = {}", month);
		log.debug("date = {}", date);
		log.debug("meridiem = {}", meridiem);
		log.debug("hour = {}", hour);
		log.debug("minute = {}", minute);
		
		return null;
	}
	
	/** 👻 정은 끝 👻 */
	
}
