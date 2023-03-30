package com.sh.oee.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sh.oee.admin.model.service.AdminService;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	public AdminService adminService;
	
	/* select 조회 
	 * - 페이징 처리 해야 함 
	 */
	
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(Model model) {
		List<Member> adminMemberList = adminService.selectAdminMemberList();
		log.debug("adminMemberList = ()", adminMemberList);
		model.addAttribute("adminMemberList", adminMemberList);
	}
	
	@GetMapping("/adminCraigList.do")
	public void adminCraigList(Model model) {
		List<Craig> adminCraigList = adminService.selectAdminCraigList();
		log.debug("adminCraigList = ()", adminCraigList);
		model.addAttribute("adminCraigList", adminCraigList);
	}
	
	@GetMapping("/adminLocalList.do")
	public void adminLocalList(Model model) {
		List<Local> adminLocalList = adminService.selectAdminLocalList();
		log.debug("adminLocalList = ()", adminLocalList);
		model.addAttribute("adminUserReport", adminLocalList);
	}
	
	@GetMapping("/adminTogetherList.do")
	public void adminTogetherList(Model model) {
		List<Together> adminTogetherList = adminService.selectAdminTogetherList();
		log.debug("adminTogetherList = ()", adminTogetherList);
		model.addAttribute("adminTogetherList", adminTogetherList);
	}
	
	@GetMapping("/adminBoardReport.do")
	public void adminBoardReport(Model model) {
		List<BoardReport> adminBoardReport = adminService.selectAdminBoardReport();
		log.debug("adminBoardReport = ()", adminBoardReport);
		model.addAttribute("adminBoardReport", adminBoardReport);
	}
	
	@GetMapping("/adminUserReport.do")
	public void adminUserReport(Model model) {
		List<UserReport> adminUserReport = adminService.selectAdminUserReport();
		log.debug("adminUserReport = ()", adminUserReport);
		model.addAttribute("adminUserReport", adminUserReport);
	}
	
}
