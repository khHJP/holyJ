package com.sh.oee.craig.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.common.OeeUtils;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;

import com.sh.oee.craig.model.service.CraigService;
import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/craig")
@Controller
public class CraigController {

	@Autowired
	private CraigService craigService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private MemberService memberService;
	

	
	
	
	// ■ select all boardList
	@GetMapping("/craigList.do")
	public void craigList(@RequestParam(defaultValue = "1")int cpage, Model model, Authentication authentication){

		// member  
		Member member = ((Member)authentication.getPrincipal());
		log.debug("■ 찍히냐 member = {} ", member);
				
		// dong range  
		int dongNo = member.getDongNo();
		String NF = member.getDongRange().toString();	

		String searchDong = memberService.selectMydongName(dongNo ) + ","; //자기동네
			   searchDong += memberService.selectDongNearOnly(dongNo );
		
		if(NF.equals("F")) {
			searchDong += "," + memberService.selectDongNearFar(dongNo );
			log.debug( "■ dongNearOnly = {}", searchDong);
		}
		
		List<String> dongList = Arrays.asList(searchDong.split(","));
		log.debug( "■ dongList = {}", dongList);
		
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
	//	log.debug( "■ craigCategory = {}", craigCategory);
		
		// paging 
		int limit = 12; //한페이지당 조회할 게시글 수 
		int offset = (cpage - 1)*limit; // 현제페이지가 1 ->  첫페이지는 0 //  현재페이지가 2 -> 두번째 페이지는 10 
	
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		//select all list  
		List<Craig> craigList = craigService.craigList(rowBounds, dongList);
		log.debug( "■ craigList = {}", craigList);

		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		model.addAttribute("member", member);
		
		return;
	}
	
	
	
	// ■ just go to the craig enroll page - 걍이동
	@GetMapping("/craigEnroll.do")
	public void craigEnroll(Model model ) {
		
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		log.debug( "■ craigCategory = {}", craigCategory);
		
		model.addAttribute("craigCategory", craigCategory);
		return;
	}
	
	
	
	// ■ insert to the craig board 
	@PostMapping("/craigBoardEnroll.do")
	public String insertCraigBoard(Craig craig, @RequestParam("upFile") List<MultipartFile> upFiles, 
			  RedirectAttributes redirectAttr){
		
		log.debug("craig = {}", craig);
		
		String saveDirectory = application.getRealPath("/resources/upload/craig");
		log.debug("saveDirectory = {}", saveDirectory);
		
		// 첨부파일저장 방법1 - 1)서버컴퓨터에저장 및 attachment 객체 만들기 
		for(MultipartFile upFile : upFiles) {
			log.debug("upFile = {}", upFile);
			log.debug("upFile - = {}", upFile.getOriginalFilename());
			log.debug("upFile-size = {}", upFile.getSize());	
		
		
			if(upFile.getSize() > 0 ) {//1-1)저장 
				String renamedFilename =  OeeUtils.renameMultipartFile( upFile );
				String originalFilename = upFile.getOriginalFilename();
				File destFile = new File(saveDirectory, renamedFilename);
				
				try {
					upFile.transferTo(destFile);	
				}catch(IllegalStateException | IOException e){
					log.error(e.getMessage(), e);
				}
				
				//1-2) attachment 객체생성 및  board에 추가
				CraigAttachment attach = new CraigAttachment();
				attach.setReFilename(renamedFilename);
				attach.setOriginalFilename(originalFilename);
				craig.addAttachment(attach);
			}
			
		}//end-for문
		
		//저장
		int result = craigService.insertCraigBoard(craig);
		log.debug( "result : " + result );

		redirectAttr.addFlashAttribute("msg", "중고거래 게시글을 성공적으로 등록했습니다😊");
		
		return "redirect:/craig/craigList.do";
		
	}
	
	
	 // ■ just go to the place - 걍이동
	 @GetMapping("/craigPickPlace.do")
	 public void craigPickPlace() {
	  
	  }
	 
	 // ■ select one craigboard
	 @GetMapping("/craigDetail.do")
	 public void craigDetail(@RequestParam int no, Model model) {
		 Craig craigboard = craigService.selectcraigOne(no);
		 
		 craigboard.setContent(OeeUtils.convertLineFeedToBr(
					OeeUtils.escapeHtml(craigboard.getContent())));
		 
		 log.debug("■ craigboard : " + craigboard);	
		 model.addAttribute("craigboard", craigboard);
	 }
	 
	 
	 
	 @ResponseBody
	 @GetMapping("/getMyCraigDong.do")
	 public Map<String, Object> getMyCraigDong(@RequestParam int dongNo) {
		 
		 String dongName = memberService.selectMydongName(dongNo);
		 log.debug( "■ dongName : " + dongName );
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("dongName", dongName);
		 
		 return map;
	}
	 
	 @ResponseBody
	 @GetMapping("/getMyCraigCategory.do")
	 public Map<String,Object>  getMyCraigCategory(@RequestParam int categoryNo) {
		 

		 
		 String categoryName = craigService.selectMyCraigCategory(categoryNo);
		 log.debug( "■ categoryName : " + categoryName );
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("categoryName", categoryName);
		 
		 return map;
	}
	 

	 // ■ just go to the place - 걍이동
	 @GetMapping("/craigUpdate.do")
	 public void craigUpdate(@RequestParam int no, Model model) {
		 Craig craigboard = craigService.selectcraigOne(no);
		 List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		 //orifile
		 List<CraigAttachment> originalCraigFiles  = craigService.selectcraigAttachments(no);
		 log.debug( "■ originalCraigFiles : " + originalCraigFiles );
			
		 model.addAttribute("craigboard", craigboard);
		 model.addAttribute("craigCategory", craigCategory);
		 model.addAttribute("originalCraigFiles", originalCraigFiles);

	  }


	 @PostMapping("/craigBoardUpdate.do")
	 public String craigboardUpdate(@RequestParam int no, Model model,Craig craig, @RequestParam(required = false, defaultValue = "0", value="attachNo")  List<Integer> attachNo,
			 @RequestParam("upFile") List<MultipartFile> upFiles,  RedirectAttributes redirectAttr ) {
	 
			 List<CraigAttachment> originalCraigFiles  = craigService.selectcraigAttachments(no);
			 
			 Craig craigboard  = craigService.selectcraigOne(no);
			 log.debug( "■ 원래 기존객체 craigboard : " + craigboard ); 
			 log.debug( "■ 넘어온 attachNo -- 내가 지운거만 안넘어오는거같은데: " + attachNo );
			 
	
			 // 1 - 원래 파일이 없다면 ? 지워야된다 원래 51 52 53 / 넘어온게 51 52 
			 
			
			 originalCraigFiles.removeAll( attachNo );
			 int delno =  Integer.parseInt( originalCraigFiles.toString());
			 log.debug( "■ delno지워야되는번호  : " + delno );
			 int delResult = craigService.deleteCraigAttachment(delno);
					 log.debug( "■ 사진 지움 여부 : " + delResult );
			
					 
			 // 2- 원래 파일 no가 넘어왔으면 ?  있으면 지우지도말고 저장하지도 말아야됨 
			 
			 // 3 - 새로운 파일이라면 ? 걍 저장만하면됨 
			 String saveDirectory = application.getRealPath("/resources/upload/craig");

		 	// 첨부파일저장 방법1 - 1)서버컴퓨터에저장 및 attachment 객체 만들기 
			for(MultipartFile upFile : upFiles) {
				log.debug("upFile = {}", upFile);
				log.debug("upFile - = {}", upFile.getOriginalFilename());
				log.debug("upFile-size = {}", upFile.getSize());	
			
				if(upFile.getSize() > 0 ) {//1-1)저장 
					String renamedFilename =  OeeUtils.renameMultipartFile( upFile );
					String originalFilename = upFile.getOriginalFilename();
					File destFile = new File(saveDirectory, renamedFilename);
					
					try {
						upFile.transferTo(destFile);	
					}catch(IllegalStateException | IOException e){
						log.error(e.getMessage(), e);
					}
					
					//1-2) attachment 객체생성 및  board에 추가
					CraigAttachment attach = new CraigAttachment();
						attach.setReFilename(renamedFilename);
						attach.setOriginalFilename(originalFilename);
						craig.addAttachment(attach);
				}
			}//end multi
		 
			//새로 파일 저장까지 추가 
			int result = craigService.updateCraigBoard(craig);
			log.debug( "■ update_result : " + result );

			redirectAttr.addFlashAttribute("msg", "중고거래 게시글을 성공적으로 수정했습니다😘");
			

			return "redirect:/craig/craigDetail.do?no="+no;
	 }


}
