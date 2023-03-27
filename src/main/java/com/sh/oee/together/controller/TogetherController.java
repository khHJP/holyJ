package com.sh.oee.together.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	/**
	 * 같이해요 등록
	 * @param together
	 * @param month
	 * @param date
	 * @param meridiem
	 * @param hour
	 * @param minute
	 * @return
	 */
	@PostMapping("/togetherEnroll.do")
	public String togetherEnroll(TogetherEntity together, 
								@RequestParam String month,
								@RequestParam String date,
								@RequestParam String meridiem,
								@RequestParam String hour,
								@RequestParam String minute,
								RedirectAttributes redirectAttr) {
		
		log.debug("together = {}", together);
		log.debug("month = {}", month);
		log.debug("date = {}", date);
		log.debug("meridiem = {}", meridiem);
		log.debug("hour = {}", hour);
		log.debug("minute = {}", minute);
		
		// LocalDateTime 객체 생성
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd a hh:mm:ss");
		LocalDateTime dateTime = LocalDateTime.now() // 현재 시각 (사용할 경우)
							.withMonth(Integer.parseInt(month))
							.withDayOfMonth(Integer.parseInt(date))
		                    .withHour(meridiem.equals("pm") ? Integer.parseInt(hour) + 12 : Integer.parseInt(hour)) // 오전/오후에 따라 시간 설정
		                    .withMinute(Integer.parseInt(minute))
		                    .withSecond(0)
		                    .withNano(0);
		
		log.debug("dateTime = {}", dateTime);
		
		String formattedDateTime = dateTime.format(formatter); // 포맷팅된 날짜시간 문자열
		log.debug("formattedDateTime = {}", formattedDateTime);

		together.setDateTime(dateTime);
		
		// 업무로직
		int result = togetherService.insertTogether(together);
		
		// view 전달
		redirectAttr.addFlashAttribute("msg", "게시글을 등록했습니다!");
		
		return "redirect:/together/togetherList.do";
	}

	/**
	 * 같이해요 수정 폼 불러오기
	 * @param no
	 */
	@GetMapping("/togetherUpdate.do")
	public void togetherUpdate(@RequestParam int no, Model model) {
		log.debug("no ={}", no);
		
		// 업무로직
		Together together = togetherService.selectTogetherByNo(no);
		List<Map<String,String>> categorys = togetherService.selectTogetherCategory();
		log.debug("together = {}", together);
		
		// 개행, 자바스크립트 코드 방어
//		together.setContent(OeeUtils.convertLineFeedToBr(OeeUtils.escapeHtml(together.getContent())));
		
		// view 전달
		model.addAttribute("together", together);
		model.addAttribute("categorys", categorys);
		
	}
	
	/**
	 * 같이해요 수정
	 * @param together
	 * @return
	 */
	@PostMapping("/togetherUpdate.do")
	public String togetherUpdate(TogetherEntity together, 
								@RequestParam String month,
								@RequestParam String date,
								@RequestParam String meridiem,
								@RequestParam String hour,
								@RequestParam String minute) {
		log.debug("together = {}", together);
		
		// LocalDateTime 객체 생성
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd a hh:mm:ss");
		LocalDateTime dateTime = LocalDateTime.now() // 현재 시각 (사용할 경우)
							.withMonth(Integer.parseInt(month))
							.withDayOfMonth(Integer.parseInt(date))
		                    .withHour(meridiem.equals("pm") ? Integer.parseInt(hour) + 12 : Integer.parseInt(hour)) // 오전/오후에 따라 시간 설정
		                    .withMinute(Integer.parseInt(minute))
		                    .withSecond(0)
		                    .withNano(0);
		log.debug("dateTime = {}", dateTime);
		
		String formattedDateTime = dateTime.format(formatter); // 포맷팅된 날짜시간 문자열
		log.debug("formattedDateTime = {}", formattedDateTime);

		together.setDateTime(dateTime);
		
		// 업무로직
		int result = togetherService.togetherUpdate(together);
		
		return "redirect:/together/togetherDetail.do?no=" + together.getNo();
	}
	
	
	/**
	 * 같이해요 삭제
	 * @param no
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/togetherDelete.do")
	public String togetherDelete(@RequestParam int no, RedirectAttributes redirectAttr) {
		log.debug("no = {}", no);
		
		// 업무로직
		int result = togetherService.togetherDelete(no);
		
		// view 전달
		redirectAttr.addFlashAttribute("msg", "게시글을 삭제했습니다!");
		
		return "redirect:/together/togetherList.do";
	}
	
	/** 👻 정은 끝 👻 */
	
}
