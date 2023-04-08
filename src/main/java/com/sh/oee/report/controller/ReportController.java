package com.sh.oee.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.ReportReason;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.report.model.service.ReportService;

import lombok.extern.slf4j.Slf4j;


@RequestMapping("/report")
@Slf4j
@Controller
public class ReportController {

	@Autowired
	private ReportService reportService;
	
	/** 👻 정은 시작 👻 */
	
	/**
	 * 신고하기 폼 불러오기
	 * @param reportType
	 * @param boardNo
	 * @param reportedId
	 * @param model
	 */
	@GetMapping("/reportEnroll.do")
	public void reportEnroll(@RequestParam String reportType, 
							 @RequestParam int boardNo, 
							 @RequestParam String reportedId,
							 Model model) {
		// 3개 모두 잘 넘어와야 함
		log.debug("reportType = {}", reportType);
		log.debug("boardNo = {}", boardNo);
		log.debug("reportedId = {}", reportedId);
		
		Map<String, Object> info = new HashMap<>();
		info.put("boardNo", boardNo);
		info.put("reportedId", reportedId);
		info.put("reportType", reportType);
		
		// 업무로직
		List<ReportReason> reasonList = reportService.getReportReason(reportType);
		
		// view 전달
		model.addAttribute("reasonList", reasonList);
		model.addAttribute("info", info);
		
	}
	
	/**
	 * 게시글 신고 등록
	 * @param boardReport
	 * @return
	 */
	@PostMapping("/boardReportEnroll.do")
	public String boardReportEnroll(BoardReport boardReport, RedirectAttributes redirectAttr) {
		log.debug("boardReport = {}", boardReport);
		
		// 업무로직
		int result = reportService.boardReportEnroll(boardReport);
		
		// view 전달
		redirectAttr.addFlashAttribute("msg", "신고가 접수되었습니다.");
		
		String str = null;
		
		// 게시판 분기
		switch(boardReport.getReportType()) {
		case CR: 
			str = "craig/craigDetail.do?no=";
			break;
		case LO:
			str = "local/localDetail.do?no=";
			break;
		case TO:
			str = "together/togetherDetail.do?no=";
			break;
		}
		
		return "redirect:/" + str + boardReport.getReportPostNo();
	}
	
	/**
	 * 사용자 신고 등록
	 * @param userReport
	 * @return
	 */
	@PostMapping("/userReportEnroll.do")
	public String userReportEnroll(UserReport userReport, 
								  @RequestParam("reportType") String reportType, 
								  @RequestParam("reportPostNo") int reportPostNo, 
								  RedirectAttributes redirectAttr) {
		log.debug("userReport = {}", userReport);
		
		// 업무로직
		int result = reportService.userReportEnroll(userReport);
		
		// view 전달
		redirectAttr.addFlashAttribute("msg", "신고가 접수되었습니다.");
		
		String str = null;
		// 게시판 분기
		switch(reportType) {
		case "CR": 
			str = "craig/craigDetail.do?no=";
			break;
		case "LO":
			str = "local/localDetail.do?no=";
			break;
		case "TO":
			str = "together/togetherDetail.do?no=";
			break;
		}
		
		return "redirect:/" + str + reportPostNo;
	}
	
	/** 👻 정은 끝 👻 */

	/** 효정 시작 */
	@PostMapping("/chat/userReportEnroll.do")
	@ResponseBody
	public void chatUserReportEnroll (Member writer, String reasonNo) {
		log.debug("오긴하나요 = {}", writer);
	//	log.debug("오긴하나요 = {}", reportedMember);
		log.debug("오긴하나요 = {}", reasonNo);
	}
	/** 효정 끝 */
	
}
