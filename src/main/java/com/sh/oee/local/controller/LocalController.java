package com.sh.oee.local.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.common.OeeUtils;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.local.model.dto.LocalAttachment;
import com.sh.oee.local.model.service.LocalService;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;

import java.io.File;
import java.io.IOException;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j 
@RequestMapping("/local")
public class LocalController {
	
	@Autowired
	private LocalService localService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ServletContext application;
	
	//동네생활 게시물 목록
	@GetMapping("/localList.do")
	public void localList(Model model , HttpSession session) {
	
		List<Local> localList = localService.localList();
		List<Map<String,String>> localCategory = localService.localCategoryList();
		
//		Member MemberSession = (Member) session.getAttribute("loginMember");
//		Member member = memberService.selectOneMember(MemberSession.getMemberId());
//		log.debug("member = {}" , member);
		
		log.debug("localList : {}", localList);
		log.debug("localCategory = {} ", localCategory);
		
		model.addAttribute("localList", localList);
		model.addAttribute("localCategory",localCategory);
	}
	
	// 동네생활 글쓰기 페이지
	@GetMapping("/localEnroll.do")
	public void localEnroll(Model model) {
		
		List<Map<String,String>> localCategory = localService.localCategoryList();
		
		log.debug("localCategroy = {}", localCategory);
		
		model.addAttribute("localCategory",localCategory);
	}
	
	//동네생활 글 등록
	@PostMapping("/localBoardEnroll.do")
	public String insertLocalBoard(Local local,
			@RequestParam("upFile") List<MultipartFile> upFiles,
			RedirectAttributes redirectAttr) {
		
		String saveDirectory = application.getRealPath("/reaources/upload/local");
		log.debug("saveDirectory = {}",saveDirectory);
		
	//첨부파일 저장 및 Attachment 객체 만들기
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {} ", upFile);
			log.debug("upFile = {} ", upFile.getOriginalFilename());
			log.debug("upFileSize = {} ", upFile.getSize());
			
			if(upFile.getSize() > 0) {
				// 저장
				String renamedFilename = OeeUtils.renameMultipartFile(upFile);
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				try {
					upFile.transferTo(destFile);
				}  catch (IllegalStateException | IOException e) {
					log.error(e.getMessage(), e);
				}
				
				// attach객체 생성 및 Board에 추가
				LocalAttachment attach = new LocalAttachment();
				attach.setReFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				local.addAttachment(attach);
			}
		}
		
		//Board 저장
		int result = localService.insertLocalBoard(local);
		log.debug("result : " + result);
		
		redirectAttr.addFlashAttribute("msg", "동네생활 게시글을 등록했습니다.");
		
		return "redirect:/local/localList.do";
	}
	
	
	//--------------- 하나 시작 ---------------------------------------
	@GetMapping("/myLocal.do")
	public void myLocal(Model model, String memberId) {
		/*
		 * List<Local> localList = localService.myLocal(memberId);
		 * 
		 * log.debug("localList:{}", localList); model.addAttribute("memberId : {}",
		 * memberId)
		 */
		
	}
			
	//-------------- 하나 끝 ------------------------------------------
	
}
