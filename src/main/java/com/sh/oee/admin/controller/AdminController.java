package com.sh.oee.admin.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	 * - 검색 기능 추가해야 함
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
		model.addAttribute("adminLocalList", adminLocalList);
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
	
	/*
	 * update
	 */
	
	@PostMapping("/adminMemberRoleUpdate.do")
	public String adminMemberRoleUpdate (@RequestParam String memberId, String auth) {
		log.debug("memberId = {}", memberId);
		
		Map<String, Object> adminMemberRoleUpdateMap = new HashMap<>();
		adminMemberRoleUpdateMap.put("memberId", memberId);
		adminMemberRoleUpdateMap.put("auth", auth);
		log.debug("adminMemberRoleUpdateMap", adminMemberRoleUpdateMap);
		
		int result = adminService.updateAdminMemberRole(adminMemberRoleUpdateMap);
		log.debug("result = {}", result);			
		
		return "redirect:/admin/adminMemberList.do";
	}
	
	@PostMapping("/adminCraigCategoryUpdate.do")
	public String adminCraigCategoryUpdate (
			@Param("no") String no, 
			@Param("categoryNo") String categoryNo, 
			Model model) {
		
		log.debug("no = {}", no);
		log.debug("categoryNo = {}", categoryNo);
		
		int result = adminService.updateAdminCraigCategory(no, categoryNo);
		log.debug("result = {}", result);			
		
		model.addAttribute("no", no);
		model.addAttribute("categoryNo", categoryNo);
		
		return "redirect:/admin/adminCraigList.do";
	}
	
	@PostMapping("/adminLocalCategoryUpdate.do")
	public String adminLocalCategoryUpdate (
			@Param("no") String no, 
			@Param("categoryNo") String categoryNo, 
			Model model) {
		log.debug("no = {}", no);
		log.debug("categoryNo = {}", categoryNo);
		
		int result = adminService.updateAdminLocalCategory(no, categoryNo);
		log.debug("result = {}", result);			
		
		model.addAttribute("no", no);
		model.addAttribute("categoryNo", categoryNo);
		
		return "redirect:/admin/adminLocalList.do";
	}
	
	@PostMapping("/adminTogetherCategoryUpdate.do")
	public String adminTogetherCategoryUpdate (@RequestParam int no, @RequestParam int categoryNo) {
		
		Map<String, Object> adminTogetherCategoryMap = new HashMap<>();
		adminTogetherCategoryMap.put("no", no);
		adminTogetherCategoryMap.put("categoryNo", categoryNo);
		log.debug("adminTogetherCategoryMap", adminTogetherCategoryMap);
		
		int result = adminService.updateAdminTogetherCategory(adminTogetherCategoryMap);
		log.debug("result = {}", result);
		
		return "redirect:/admin/adminTogetherList.do";
	}
	
	/*
	 * delete
	 */
	
	@PostMapping("/adminMemberDelete.do")
	public String adminMemberDelete (
			@RequestParam String memberId, 
			RedirectAttributes redirectAttr) {
		log.debug("memberId = {}", memberId);
		
		try {
			int result = adminService.deleteAdminMember(memberId);
			log.debug("result = {}", result);			
		} catch (Exception e) {
			redirectAttr.addFlashAttribute("msg", "회원을 성공적으로 삭제했습니다.");
		}
		
		return "redirect:/admin/adminMemberList.do";
	}
	
}
