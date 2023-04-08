package com.sh.oee.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
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

	/*
	 * select 조회 - 검색 기능 추가해야 함 - 페이징 처리 해야 함
	 */

	// 회원 목록 조회
	@GetMapping("/adminMemberList.do")
	public void adminMemberList(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, Model model) {

		// 페이지 처리
		int limit = 10;
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<Member> adminMemberList = null;
		List<Member> adminMemberSearch = null;
		int totalCount = 0;
		int totalPages = 0;

		if (searchKeyword == null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			// 업무 로직
			adminMemberList = adminService.selectAdminMemberList(param, rowBounds);
			log.debug("adminMemberList = ()", adminMemberList);

			totalCount = adminService.selectAdminMemberTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());
		}

		else if (searchKeyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			log.debug("param = {}", param);

			// 업무 로직
			adminMemberSearch = adminService.selectAdminMemberList(param, rowBounds);
			log.debug("adminMemberSearch = ()", adminMemberSearch);

			totalCount = adminService.selectAdminMemberTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());

		}

		// view
		model.addAttribute("adminMemberList", adminMemberList);
		model.addAttribute("adminMemberSearch", adminMemberSearch);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
	}

	// 중고거래 게시글 목록 조회
	@GetMapping("/adminCraigList.do")
	public void adminCraigList(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, Model model) {
		// 페이지 처리
		int limit = 10;
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<Craig> adminCraigList = null;
		List<Craig> adminCraigSearch = null;
		int totalCount = 0;
		int totalPages = 0;

		if (searchKeyword == null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			// 업무 로직
			adminCraigList = adminService.selectAdminCraigList(param, rowBounds);
			log.debug("adminCraigList = ()", adminCraigList);

			totalCount = adminService.selectAdminCraigTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());
		}

		else if (searchKeyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			log.debug("param = {}", param);

			// 업무 로직
			adminCraigSearch = adminService.selectAdminCraigList(param, rowBounds);
			log.debug("adminCraigSearch = ()", adminCraigSearch);

			totalCount = adminService.selectAdminCraigTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());

		}

		// view
		model.addAttribute("adminCraigList", adminCraigList);
		model.addAttribute("adminCraigSearch", adminCraigSearch);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
	}

	// 동네생활 게시글 목록 조회
	@GetMapping("/adminLocalList.do")
	public void adminLocalList(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, Model model) {
		// 페이지 처리
		int limit = 10;
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<Local> adminLocalList = null;
		List<Local> adminLocalSearch = null;
		int totalCount = 0;
		int totalPages = 0;

		if (searchKeyword == null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			// 업무 로직
			adminLocalList = adminService.selectAdminLocalList(param, rowBounds);
			log.debug("adminLocalList = ()", adminLocalList);

			totalCount = adminService.selectAdminLocalTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());
		}

		else if (searchKeyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			log.debug("param = {}", param);

			// 업무 로직
			adminLocalSearch = adminService.selectAdminLocalList(param, rowBounds);
			log.debug("adminLocalSearch = ()", adminLocalSearch);

			totalCount = adminService.selectAdminLocalTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());

		}

		// view
		model.addAttribute("adminLocalList", adminLocalList);
		model.addAttribute("adminLocalSearch", adminLocalSearch);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
	}

	// 같이해요 게시글 목록 조회
	@GetMapping("/adminTogetherList.do")
	public void adminTogetherList(@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String searchKeyword, Model model) {
		// 페이지 처리
		int limit = 10;
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		List<Together> adminTogetherList = null;
		List<Together> adminTogetherSearch = null;
		int totalCount = 0;
		int totalPages = 0;

		if (searchKeyword == null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			// 업무 로직
			adminTogetherList = adminService.selectAdminTogetherList(param, rowBounds);
			log.debug("adminTogetherList = ()", adminTogetherList);

			totalCount = adminService.selectAdminTogetherTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());
		}

		else if (searchKeyword != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("searchKeyword", searchKeyword);

			log.debug("param = {}", param);

			// 업무 로직
			adminTogetherSearch = adminService.selectAdminTogetherList(param, rowBounds);
			log.debug("adminTogetherSearch = ()", adminTogetherSearch);

			totalCount = adminService.selectAdminTogetherTotalCount(param);
			log.debug("totalCount = {}", totalCount);

			// 전체 페이지 수 계산
			totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());

		}

		// view
		model.addAttribute("adminTogetherList", adminTogetherList);
		model.addAttribute("adminTogetherSearch", adminTogetherSearch);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
	}

	// 게시글 신고 목록 조회
	@GetMapping("/adminBoardReport.do")
	public void adminBoardReport(@RequestParam(defaultValue = "1") int currentPage, Model model) {
		// 페이지 처리
		int limit = 10;
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		// 업무 로직
		List<BoardReport> adminBoardReport = adminService.selectAdminBoardReport(rowBounds);
		log.debug("adminBoardReport = ()", adminBoardReport);

		int totalCount = adminService.selectAdminBoardReportTotalCount(adminBoardReport);
		log.debug("totalCount = {}", totalCount);

		// 전체 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());

		// view
		model.addAttribute("adminBoardReport", adminBoardReport);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
	}

	// 사용자 신고 목록 조회
	@GetMapping("/adminUserReport.do")
	public void adminUserReport(@RequestParam(defaultValue = "1") int currentPage, Model model) {
		// 페이지 처리
		int limit = 10;
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);

		// 업무 로직
		List<UserReport> adminUserReport = adminService.selectAdminUserReport(rowBounds);
		log.debug("adminUserReport = ()", adminUserReport);

		int totalCount = adminService.selectAdminUserReportTotalCount(adminUserReport);
		log.debug("totalCount = {}", totalCount);

		// 전체 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalCount / rowBounds.getLimit());

		// view
		model.addAttribute("adminUserReport", adminUserReport);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", currentPage);
	}
	
	// 관리자 공지 목록 조회
	@GetMapping("/adminNoticeList.do")
	public void adminNoticeList() {};

	/*
	 * update
	 */

	// 회원 권한 수정
	@PostMapping("/adminMemberRoleUpdate.do")
	public String adminMemberRoleUpdate(@RequestParam String memberId, String auth, RedirectAttributes redirectAtrr) {
		// 업무 로직
		log.debug("memberId = {}", memberId);
		log.debug("auth = {}", auth);

		Map<String, Object> adminMemberRoleUpdateMap = new HashMap<>();
		adminMemberRoleUpdateMap.put("memberId", memberId);
		adminMemberRoleUpdateMap.put("auth", auth);
		log.debug("adminMemberRoleUpdateMap", adminMemberRoleUpdateMap);

		int result = adminService.updateAdminMemberRole(adminMemberRoleUpdateMap);
		log.debug("result = {}", result);

		// view
		redirectAtrr.addFlashAttribute("msg", "회원 권한 수정 성공!");

		return "redirect:/admin/adminMemberList.do";
	}

	// 중고거래 카테고리 수정
	@PostMapping("/adminCraigCategoryUpdate.do")
	public String adminCraigCategoryUpdate(@RequestParam int no, int categoryNo, RedirectAttributes redirectAtrr) {
		// 업무 로직
		log.debug("no = {}", no);
		log.debug("categoryNo = {}", categoryNo);

		Map<String, Object> adminCraigCategoryMap = new HashMap<>();
		adminCraigCategoryMap.put("no", no);
		adminCraigCategoryMap.put("categoryNo", categoryNo);
		log.debug("adminCraigCategoryMap", adminCraigCategoryMap);

		int result = adminService.updateAdminCraigCategory(adminCraigCategoryMap);
		log.debug("result = {}", result);

		// view
		redirectAtrr.addFlashAttribute("msg", "중고거래 카테고리 수정 성공!");

		return "redirect:/admin/adminCraigList.do";
	}

	// 동네생활 카테고리 수정
	@PostMapping("/adminLocalCategoryUpdate.do")
	public String adminLocalCategoryUpdate(@RequestParam int no, int categoryNo, RedirectAttributes redirectAtrr) {
		// 업무 로직
		log.debug("no = {}", no);
		log.debug("categoryNo = {}", categoryNo);

		Map<String, Object> adminLocalCategoryMap = new HashMap<>();
		adminLocalCategoryMap.put("no", no);
		adminLocalCategoryMap.put("categoryNo", categoryNo);
		log.debug("adminLocalCategoryMap", adminLocalCategoryMap);

		int result = adminService.updateAdminLocalCategory(adminLocalCategoryMap);
		log.debug("result = {}", result);

		// view
		redirectAtrr.addFlashAttribute("msg", "동네생활 카테고리 수정 성공!");

		return "redirect:/admin/adminLocalList.do";
	}

	// 같이해요 카테고리 수정
	@PostMapping("/adminTogetherCategoryUpdate.do")
	public String adminTogetherCategoryUpdate(@RequestParam int no, int categoryNo, RedirectAttributes redirectAtrr) {
		// 업무 로직
		log.debug("no = {}", no);
		log.debug("categoryNo", no);

		Map<String, Object> adminTogetherCategoryMap = new HashMap<>();
		adminTogetherCategoryMap.put("no", no);
		adminTogetherCategoryMap.put("categoryNo", categoryNo);
		log.debug("adminTogetherCategoryMap", adminTogetherCategoryMap);

		int result = adminService.updateAdminTogetherCategory(adminTogetherCategoryMap);
		log.debug("result = {}", result);

		// view
		redirectAtrr.addFlashAttribute("msg", "같이해요 카테고리 수정 성공!");

		return "redirect:/admin/adminTogetherList.do";
	}

	// 회원 삭제 탈퇴일 수정
	@PostMapping("/adminMemberUnregisterUpdate.do")
	public String adminMemberUnregisterUpdate(@RequestParam String memberId, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("memberId = {}", memberId);

		int result = adminService.updateAdminMemberUnregister(memberId);
		log.debug("result = {}", result);

		// view
		redirectAttr.addFlashAttribute("msg", "회원 삭제 성공!");

		return "redirect:/admin/adminMemberList.do";
	}

	// 게시글 신고 처리
	@PostMapping("/adminCraigBoardReportHandle.do")
	public String adminCraigBoardReportHandle(@RequestParam int reportNo, @RequestParam int reportPostNo, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("reportNo = {}", reportNo);
		log.debug("reportPostNo = {}", reportPostNo);
		
		int result = adminService.updateAdminBoardReportHandle(reportNo);
		log.debug("result = {}", result);
		
		int post = adminService.updateAdminCraigBoardReportYn(reportPostNo);
		log.debug("post = {}", post);
		int member = adminService.updateAdminCraigMemberBoardReportCnt(reportPostNo);
		log.debug("member = {}", member);

		// view
		redirectAttr.addFlashAttribute("msg", "중고거래 게시글 신고 처리 성공!");

		return "redirect:/admin/adminBoardReport.do";
	}
	
	@PostMapping("/adminLocalBoardReportHandle.do")
	public String adminLocalBoardReportHandle(@RequestParam int reportNo, @RequestParam int reportPostNo, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("reportNo = {}", reportNo);
		log.debug("reportPostNo = {}", reportPostNo);
		
		int result = adminService.updateAdminBoardReportHandle(reportNo);
		log.debug("result = {}", result);
		
		int post = adminService.updateAdminLocalBoardReportYn(reportPostNo);
		log.debug("post = {}", post);
		int member = adminService.updateAdminLocalMemberBoardReportCnt(reportPostNo);
		log.debug("member = {}", member);

		// view
		redirectAttr.addFlashAttribute("msg", "동네생활 게시글 신고 처리 성공!");

		return "redirect:/admin/adminBoardReport.do";
	}
	
	@PostMapping("/adminTogetherBoardReportHandle.do")
	public String adminTogetherBoardReportHandle(@RequestParam int reportNo, @RequestParam int reportPostNo, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("reportNo = {}", reportNo);
		log.debug("reportPostNo = {}", reportPostNo);
		
		int result = adminService.updateAdminBoardReportHandle(reportNo);
		log.debug("result = {}", result);
		
		int post = adminService.updateAdminTogetherBoardReportYn(reportPostNo);
		log.debug("post = {}", post);
		int member = adminService.updateAdminTogetherMemberBoardReportCnt(reportPostNo);
		log.debug("member = {}", member);

		// view
		redirectAttr.addFlashAttribute("msg", "같이해요 게시글 신고 처리 성공!");

		return "redirect:/admin/adminBoardReport.do";
	}
	
	// 사용자 신고 처리
	@PostMapping("/adminUserReportHandle.do")
	public String adminUserReportHandle(@RequestParam int reportNo, String reportedMember, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("reportNo = {}", reportNo);
		log.debug("reportedMember = {}", reportedMember);
		
		int result = adminService.updateAdminUserReportHandle(reportNo);
		log.debug("result = {}", result);
		int member = adminService.updateAdminMemberUserReportCnt(reportedMember);
		log.debug("member = {}", member);
		
		// view
		redirectAttr.addFlashAttribute("msg", "사용자 신고 처리 성공!");

		return "redirect:/admin/adminUserReport.do";
	}

	// 게시글 신고 취소
	@PostMapping("/adminBoardReportCancle.do")
	public String adminBoardReportCancle(@RequestParam int reportNo, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("reportNo = {}", reportNo);

		int result = adminService.updateAdminBoardReportHandle(reportNo);
		log.debug("result = {}", result);

		// view
		redirectAttr.addFlashAttribute("msg", "게시글 신고 취소 성공!");

		return "redirect:/admin/adminBoardReport.do";
	}
	
	// 사용자 신고 취소
	@PostMapping("/adminUserReportCancle.do")
	public String adminUserReportCancle(@RequestParam int reportNo, RedirectAttributes redirectAttr) {
		// 업무 로직
		log.debug("reportNo = {}", reportNo);

		int result = adminService.updateAdminUserReportHandle(reportNo);
		log.debug("result = {}", result);

		// view
		redirectAttr.addFlashAttribute("msg", "게시글 신고 취소 성공!");

		return "redirect:/admin/adminUserReport.do";
	}

	/*
	 * delete
	 */

	// 중고거래 게시글 삭제
	@PostMapping("/adminCraigDelete.do")
	public String adminCraigDelete(@RequestParam int no, RedirectAttributes redirectAttr, SessionStatus status) {
		// 업무 로직
		log.debug("no = {}", no);

		int result = adminService.deleteAdminCraig(no);

		if (!status.isComplete()) {
			status.setComplete();
		}

		// view
		redirectAttr.addFlashAttribute("msg", "중고거래 게시글 삭제 성공!");

		return "redirect:/admin/adminCraigList.do";
	}

	// 동네생활 게시글 삭제
	@PostMapping("/adminLocalDelete.do")
	public String adminLocalDelete(@RequestParam int no, RedirectAttributes redirectAttr, SessionStatus status) {
		// 업무 로직
		log.debug("no = {}", no);

		int result = adminService.deleteAdminLocal(no);

		if (!status.isComplete()) {
			status.setComplete();
		}

		// view
		redirectAttr.addFlashAttribute("msg", "동네생활 게시글 삭제 성공!");

		return "redirect:/admin/adminLocalList.do";
	}

	// 같이해요 게시글 삭제
	@PostMapping("/adminTogetherDelete.do")
	public String adminTogetherDelete(@RequestParam int no, RedirectAttributes redirectAttr, SessionStatus status) {
		// 업무 로직
		log.debug("no = {}", no);

		int result = adminService.deleteAdminTogether(no);

		if (!status.isComplete()) {
			status.setComplete();
		}

		// view
		redirectAttr.addFlashAttribute("msg", "같이해요 게시글 삭제 성공!");

		return "redirect:/admin/adminTogetherList.do";
	}

}
