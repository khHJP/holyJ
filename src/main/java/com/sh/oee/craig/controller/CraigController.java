package com.sh.oee.craig.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sh.oee.common.OeeUtils;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigPage;
import com.sh.oee.craig.model.service.CraigService;
import com.sh.oee.member.model.dto.Dong;
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
	public void craigList( @RequestParam(defaultValue = "1")int cpage, Model model, Authentication authentication,
						   @RequestParam(required = false) String searchKeyword ){

	try {
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
			log.debug( "■ searchDong = {}", searchDong);
		}
		
		List<String> dongList = Arrays.asList(searchDong.split(","));
		log.debug( "■ dongList = {}", dongList);
		
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		
		// paging
		int limit = 12; //한페이지당 조회할 게시글 수 
		int offset = (cpage - 1)*limit; // 현제페이지가 1 ->  첫페이지는 0 //  현재페이지가 2 -> 두번째 페이지는 10 	
		RowBounds rowBounds = new RowBounds(offset, limit);



		List<Craig> craigList = null;
		List<Integer> wishCnt = null;
		List<Integer> craigChatCnt = null;
		int totals = 0; // 토탈게시물수 
		int totalPage =0; // 토탈페이지
		List<Craig> searchCraigs = null; //검색용
		int categoryNo = 0;
		
		// ■ 검색아님 - 일반일때 - select all list  
		if(searchKeyword == null) {
			
	    	Map<String, Object> param = new HashMap<>();    	
	    	param.put("dongName", dongList); //ㅁㅁ
	    	param.put("categoryNo", categoryNo);
	    	param.put("searchKeyword", searchKeyword);

	    	craigList = craigService.craigList(param, rowBounds); // 새로메서드 0330
			wishCnt = craigService.selectCraigWishCnt(param,  rowBounds);  // 각 게시물의 관심수 list
			craigChatCnt = craigService.selectCraigChatCnt(param,  rowBounds);  // // 각 게시물의 채팅수 list 
					
			log.debug( "■■■ craigList 게시물[rowbounds됨^^]= {}", craigList);	
			log.debug( " ♥wishCnt = {}", wishCnt);	

			totals = craigService.getContentCnt(param );		
			totalPage = (int) Math.ceil((double) totals/limit);	
			log.debug( "■■■ total 페이지 수 = {}", totalPage);	
			
		}

		else if(searchKeyword != null) {
			
			/// donglist, 키워드, rowbounds
	    	Map<String, Object> param = new HashMap<>();    	
	    	param.put("dongName", dongList);
	    	param.put("searchKeyword", searchKeyword);
	    	param.put("categoryNo", categoryNo);
	    	
	    	log.debug( "■■■■ searparamchCraigs : " + param ); 
	    		
			searchCraigs = craigService.craigList(param, rowBounds);
			log.debug( "■■■■ searchCraigs : " + searchCraigs ); 
			
			wishCnt = craigService.selectCraigWishCnt(param, rowBounds);
			craigChatCnt = craigService.selectCraigChatCnt(param , rowBounds);  // // 각 게시물의 채팅수 list 
			log.debug( "♥wishCnt = {}, ♥craigChatCnt = {}", wishCnt, craigChatCnt);	
			
			totals = craigService.getContentCnt(param );	
			totalPage = (int) Math.ceil((double) totals/limit);	
			log.debug( "■■■ total 페이지 수 = {}", totalPage);	

		}
		
		
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", cpage);		
		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		model.addAttribute("member", member);
		model.addAttribute("wishCnt", wishCnt);
		model.addAttribute("craigChatCnt", craigChatCnt);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchCraigs", searchCraigs);
		
		
		// 페이징
		CraigPage  craigPage = new CraigPage(totals, cpage, limit, 5);
		model.addAttribute("craigPage", craigPage);
		
		
		}catch (Exception e) {
			throw e;
		}
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
 
	 // ■ select one craigboard - 0402  --  ModelAndView mav
	 @GetMapping("/craigDetail.do")
	 public String craigDetail(@RequestParam int no, Model model, Authentication authentication, 
	 							HttpServletRequest request, HttpServletResponse response) {
		 
		 Member member = ((Member)authentication.getPrincipal());
		 log.debug("■ member : " +  member);
			
			String boardCookieVal = "";  
			boolean hasRead = false; // false = 안읽었다 
			
			Cookie[] cookies = request.getCookies();
	
			if( cookies != null) {// 무조건해야됨 
				for( Cookie cookie : cookies) {
					String name = cookie.getName();
					String value = cookie.getValue();
					
					if("craigboard".equals(name)) {
						boardCookieVal  = value; // craigboard = "[84][22]" 
						if(value.contains("[" + no + "]" )){
							hasRead = true;
							request.getSession().setAttribute("boardCookieVal", boardCookieVal);
						}	
					}
				}//end-forEach	
			}//end - if(cookie있을경우)
			
			//응답쿠키
			if(!hasRead) { //읽지않았다
				Cookie craigcookie = new Cookie("craigboard", boardCookieVal + "[" + no + "]" );
				craigcookie.setMaxAge(30*24*60*60); // 30days term
				craigcookie.setPath(request.getContextPath());
				response.addCookie(craigcookie);	
			}
			
			 // ● selectcraigOneRe - map- nhparam에 담을 애들 
			 Map<String, Object> nhparam = new HashMap<>();
			 nhparam.put("no", no);			
			 nhparam.put("hasRead", hasRead);	
			
			 Craig craigboard = craigService.selectcraigOneRe( nhparam );
						 
			 craigboard.setContent(OeeUtils.convertLineFeedToBr(
										OeeUtils.escapeHtml(craigboard.getContent())));

			 // ● wish 조회 - map- param 에 담을 애들 
			 Map<String, Object> param = new HashMap<>();
			 param.put("memberId", member.getMemberId());
			 param.put("no", no);
			 
			 int findCraigWish = craigService.selectCraigWish(param);
			 
			 log.debug("■ member : " +  member);
			 log.debug("■ craigboard : " + craigboard);	
			 log.debug("■ findCraigWish : " + findCraigWish);	
	

			 //
			 Map<String, Object> otherParam = new HashMap<>();
			 otherParam.put("memberId", craigboard.getMember().getMemberId());
			 otherParam.put("no",no);
			 
			 
			 List<Craig> othercraigs = craigService.selectOtherCraigs( otherParam );
//			 mav.addObject("othercraigs", othercraigs);			 
//			 mav.addObject("craigboard", craigboard); 
//			 mav.addObject("findCraigWish", findCraigWish);		 
//			 mav.setViewName("craig/craigDetail");		 
//			 model.addAttribute("name", "abc");   --- model은 왜안돼?????????????
			 model.addAttribute("craigboard", craigboard);
			 model.addAttribute("findCraigWish", findCraigWish);
			 model.addAttribute("othercraigs", othercraigs);

			 
			 return "craig/craigDetail" ;
//			 return mav;
	 }


	 @ResponseBody
	 @GetMapping("/getMyCraigDong.do")
	 public Map<String, Object> getMyCraigDong(@RequestParam int dongNo) {
		 
		 List<Dong>  dongguname  = memberService.selectMydongGuName(dongNo);
		 
		 Map<String,Object> map = new HashMap<>();
		 map.put("guName", dongguname.get(0).getGu());
		 map.put("dongName", dongguname.get(0).getDongName());
		 log.debug( "■ dongguName : " + map );

		 return map;
	}
	
	 // 카테고리 
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
		 
  		 boolean hasRead = true;

		 Map<String, Object> nhparam = new HashMap<>();
		 nhparam.put("no", no);			
		 nhparam.put("hasRead", hasRead);	
		
		 Craig craigboard = craigService.selectcraigOneRe( nhparam );
		
		 List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		 //orifile
		 List<CraigAttachment> originalCraigFiles  = craigService.selectcraigAttachments(no);
		 log.debug( "■ originalCraigFiles : " + originalCraigFiles );
			
		 model.addAttribute("craigboard", craigboard);
		 model.addAttribute("craigCategory", craigCategory);
		 model.addAttribute("originalCraigFiles", originalCraigFiles);
		 

	  }

    // ■ update - 로직을 바꿔서 다시해보자
	 @PostMapping("/craigBoardUpdate.do")
	 public String craigboardUpdate(@RequestParam int no, Model model,Craig craig, @RequestParam(required = false, defaultValue = "0", value="attachNo")  List<Integer> attachNo,
			 @RequestParam("upFile") List<MultipartFile> upFiles,  RedirectAttributes redirectAttr ) {
	 	
		 	String saveDirectory = application.getRealPath("/resources/upload/craig");
		 	
	  		 boolean hasRead = true;

			 Map<String, Object> nhparam = new HashMap<>();
			 nhparam.put("no", no);			
			 nhparam.put("hasRead", hasRead);	
			
			 Craig craigboard = craigService.selectcraigOneRe( nhparam );
			 log.debug( "■ 바꿀거 선택해온거  " + craigboard ); //90 91 92
			 
		 	// attachment db 조회 ex) 90 91 92 
			List<CraigAttachment> originalCraigFiles  = craigService.selectcraigAttachments(no);
			List<Integer> orifileno = new ArrayList<>(); // list에 넣기 
			 
			 for(int i=0; i<originalCraigFiles.size();  i++) {
				 orifileno.add( originalCraigFiles.get(i).getAttachNo());
			 }
			 
			 log.debug( "■ orifileno(원래 db에 있던애들_: " + orifileno ); //90 91 92
			 log.debug( "■ 넘어온 attachNo(내가 지운거만 안넘어옴 ex_(90) 91 92 +93 : " + attachNo ); // 91 92

			 List<Integer> delList =  new ArrayList<>();
			 
			 // case - delete [90일 경우   ex_(90) 91 92 +93] 
			 orifileno.removeAll( attachNo );  // 대신 원본 배열 변형생김 
			 for(int i=0; i<orifileno.size(); i++) {
				 int delno = orifileno.get(i);
				 delList.add(delno);
				 
				 log.debug( "■ delno 지워야되는번호  : " + delList);
				 
				 int delResult = craigService.deleteCraigAttachment(delList.get(i));
				 log.debug( "■ 사진 지움 여부 : " + delResult );						 
			 }

			for(MultipartFile upFile : upFiles) {
					int i =0;
					log.debug("upFile = {}", upFile);
					log.debug("upFile - = {}", upFile.getOriginalFilename());
					log.debug("upFile-size = {}", upFile.getSize());	
				
					if(upFile.getSize() > 0 ) {//1-1) 저장할거찾는중  
						 log.debug( "♠♠♠ UPFILE : " + upFile ); //뭐가넘어오지 ? 91 92 93인가?   
// ♠♠♠ UPFILE : MultipartFile[field="upFile", filename=chair3.png, contentType=image/png, size=216132]
						 
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
					   
							log.debug("여기들어와야돼 : ", attach );	
							attach.setReFilename(renamedFilename);
							attach.setOriginalFilename(originalFilename);
							craig.addAttachment(attach);
					}//end if
			}// end multi 

			//  Date.valueOf( craig.getCompleteDate() );
			
			int result = craigService.updateCraigBoard(craig);
			log.debug( "■ real_update_result : " + result );

			redirectAttr.addFlashAttribute("msg", "중고거래 게시글을 성공적으로 수정했습니다😘");
			return "redirect:/craig/craigDetail.do?no="+no;
	 }
	 
	 
	 //■ delete
	 @PostMapping("/craigBoardDelete.do")
	 public String craigBoardDelte(@RequestParam int no,  RedirectAttributes redirectAttr) {
		 
		 try {
			 int result = craigService.deleteCraigBoard(no);
			 log.debug( "■ delete_result : " + result );
		 }catch (Exception e) {
			 log.debug( "오류 = {}", e );
		 }
		 
 		 redirectAttr.addFlashAttribute("msg", "중고거래 게시글을 성공적으로 삭제했습니다☺️");		 
		 return "redirect:/craig/craigList.do";
	 }

	//■ wish
    @ResponseBody
    @PostMapping("/insertOrDeleteCraigWish.do")
	public int insertOrDeleteCraigWish(  @RequestParam int no, String memberId  ) {
    	//only 게시글 번호만 가져옴 

    	Map<String, Object> param = new HashMap<>();
		
    	 param.put("memberId", memberId);
		 param.put("no", no);
		
		 int findCraigWish = craigService.selectCraigWish(param);
		
		 int result = 0; 
		 if( findCraigWish == 1 ) { //이미 있는데 클릭했어요 -> delete result =
			 result = craigService.DeleteCraigWish(param);
			 result = 0;
		 }
		 else {
			 result = craigService.InsertCraigWish(param); 
		 }

		 log.debug( "■ wish_result : " + result );  	

		 return result;
	}
    
    // ■ no - wish가져오기 
    @ResponseBody
    @GetMapping("/selectCraigWishOne.do")
    public int selectCraigWishOne(@RequestParam int no) {  
    	log.debug("■[wish] 비동기 no 값넘어오는지 확인 = {} ", no);
    	int result = craigService.selectCraigWishOne(no);
    	return result;
    }
    
    // ■ no - 채팅방 
    @ResponseBody
    @GetMapping("/selectCraigChrooms.do")
    public int selectCraigChrooms(@RequestParam int no) {  
    	log.debug("■[chat] 비동기 no 값넘어오는지 확인 = {} ", no);
    	int result = craigService.selectCraigChrooms(no);
  //  	int realResult = (int)result/2;
    	return result;
    }
	 
    
    // ■ 비동기 카테고리 검색
    @ResponseBody
    @GetMapping("/selectCategorySearch.do")
    public Map<String, Object>  selectCategorySearch( @RequestParam int categoryNo,
    		@RequestParam(defaultValue = "1")int cpage, Model model, Authentication authentication ) {    	
    			
    	log.debug( "■■■■ searparamchCraigs : " + categoryNo ); 
    			
    			// member  
    			Member member = ((Member)authentication.getPrincipal());
			
    			// dong range  
    			int dongNo = member.getDongNo();
    			String NF = member.getDongRange().toString();	

    			String searchDong = memberService.selectMydongName(dongNo ) + ","; //자기동네
    				   searchDong += memberService.selectDongNearOnly(dongNo );
    			
    			if(NF.equals("F")) {
    				searchDong += "," + memberService.selectDongNearFar(dongNo );
    				log.debug( "■ searchDong = {}", searchDong);
    			}
    			
    			List<String> dongList = Arrays.asList(searchDong.split(","));
    			log.debug( "■ dongList = {}", dongList);
    			
    			// paging
    			int limit = 12; //한페이지당 조회할 게시글 수 
    			int offset = (cpage - 1)*limit; // 현제페이지가 1 ->  첫페이지는 0 //  현재페이지가 2 -> 두번째 페이지는 10 
    		
    			RowBounds rowBounds = new RowBounds(offset, limit);
 
				///////////// donglist, 키워드, rowbounds
    			String searchKeyword = null;
		    	Map<String, Object> param = new HashMap<>();    	
		    	param.put("dongName", dongList); //ㅁㅁ
		    	param.put("categoryNo", categoryNo);
		    	param.put("searchKeyword", searchKeyword);
		    	log.debug( "■■■■ categoryparam : " + param ); 
		    	
		    	
    			List<Craig> searchCrategory = craigService.craigList(param, rowBounds);
				log.debug( "■■■■ searchCraigs : " + searchCrategory ); 
    	
				List<Integer> wishCnt = craigService.selectCraigWishCnt(param, rowBounds); //
				List<Integer> craigChatCnt = craigService.selectCraigChatCnt(param, rowBounds);  //
				log.debug( "■■■■ wishCnt(List) = {}, craigChatCnt(List) = {}", wishCnt , craigChatCnt );				

				int totals = craigService.getContentCnt(param );	
				int totalPage = (int) Math.ceil((double) totals/limit);	
	
				// 리턴
				Map<String, Object> categoryMap = new HashMap<>();  
				categoryMap.put("searchCrategory", searchCrategory);
				categoryMap.put("wishCnt", wishCnt);
				categoryMap.put("craigChatCnt", craigChatCnt);				
				categoryMap.put("totalPage", totalPage);
				categoryMap.put("page", cpage);
				
				return categoryMap;
    } 

	 
	 @ResponseBody
	 @GetMapping("/findmeFromChat.do")
	 public int findmeFromChat(@RequestParam int no, Authentication authentication, Model model) {
		 
		 Member member = ((Member)authentication.getPrincipal());
		 
		 Map<String, Object> param = new HashMap<>();  
		 param.put("no", no);
		 param.put("memberId", member.getMemberId());
		 
		 Integer result = craigService.findmeFromChat(param);
		 log.debug("result  : ", result);
		 return result;
	 }
	 

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 /*
	  * 하나시작
	  */
	 
	 @GetMapping("/mySalCraig.do")
		public void mySalCraig(Authentication authentication, Model model) {
			// member  
			String memberId = ((Member)authentication.getPrincipal()).getMemberId();
			log.debug("memberId = {} ", memberId);
			
			List<Craig> mySalCraig = craigService.mySalCraig(memberId);
				
			log.debug("mySalCraig = {}",mySalCraig);
				
			model.addAttribute("mySalCraig",mySalCraig);
		}
	 
	 @GetMapping("/mySalCraig1.do")
	 public void mySalCraig1(String memberId, Model model) {
		 // member  
		 log.debug("memberId = {} ", memberId);
		 
		 List<Craig> mySalCraig = craigService.mySalCraig(memberId);
		 
		 log.debug("mySalCraig = {}",mySalCraig);
		 
		 model.addAttribute("mySalCraig",mySalCraig);
	 }
	 
	 @GetMapping("/mySalFCraig.do")
	 public void mySalFCraig(Authentication authentication, Model model) {
		 // member  
		 String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		 log.debug("memberId = {} ", memberId);
			
		 List<Craig> mySalFCraig = craigService.mySalFCraig(memberId);
				
		 log.debug("mySalFCraig = {}",mySalFCraig);
				
		 model.addAttribute("mySalFCraig",mySalFCraig);
	 }
	 @GetMapping("/mySalFCraig1.do")
	 public void mySalFCraig1(String memberId, Model model) {
		 // member  
		 log.debug("memberId = {} ", memberId);
		 
		 List<Craig> mySalFCraig = craigService.mySalFCraig(memberId);
		 
		 log.debug("mySalFCraig = {}",mySalFCraig);
		 
		 model.addAttribute("mySalFCraig",mySalFCraig);
	 }
	 
	 @ResponseBody
	 @PostMapping("/salCraig.do")
	 public int salCraig(@RequestParam int no) {
		 log.debug("no = {}", no);
		 
		 return craigService.salCraig(no);
		 
	 }
	
	 @PostMapping("/salFCraig.do")
	 public String salFCraig(@RequestParam int no) {
		 log.debug("no = {}", no);
		 
		int result = craigService.salFCraig(no);
		return "redirect:/craig/mySalFCraig.do";
	 }
	 
	 @GetMapping("/myBuyCraig.do")
	 public void myBuyCraig(Authentication authentication, Model model) {
		 // member  
		 String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		 log.debug("member = {} ", memberId);
		
		 List<Craig> myBuyCraig = craigService.myBuyCraig(memberId);
			
		log.debug("myBuyCraig = {}",myBuyCraig);
			
		model.addAttribute("myBuyCraig",myBuyCraig);
		 
	 }
	 
	 
	 @GetMapping("/myWishCraig.do")
	 public void myWishCraig(Authentication authentication, Model model) {
		 // member  
		 String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		 log.debug("member = {} ", memberId);
		 
		 List<Craig> myWishCraig = craigService.myWishCraig(memberId);
		 
		 log.debug("myWishCraig = {}",myWishCraig);
		 
		 model.addAttribute("myWishCraig",myWishCraig);
		 
	 }
	 /*
	  * 하나끝
	  */
	 
	 
}
