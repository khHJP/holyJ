package com.sh.oee.craig.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
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
			log.debug( "■ searchDong = {}", searchDong);
		}
		
		List<String> dongList = Arrays.asList(searchDong.split(","));
		log.debug( "■ dongList = {}", dongList);
		
		List<Map<String,String>>  craigCategory = craigService.craigCategoryList();
		
		// paging
		int limit = 12; //한페이지당 조회할 게시글 수 
		int offset = (cpage - 1)*limit; // 현제페이지가 1 ->  첫페이지는 0 //  현재페이지가 2 -> 두번째 페이지는 10 
	
		RowBounds rowBounds = new RowBounds(offset, limit);
		Object parameter = null;

		//select all list  
		List<Craig> craigList = craigService.craigList(dongList, rowBounds);
		List<Integer> wishCnt = craigService.selectCraigWishCnt(dongList);
		log.debug( "■■■ craigList 게시물[rowbounds안되는거같음]= {}", craigList);	
		
		log.debug( "♥wishCnt = {}", wishCnt);	
		
		// 토탈게시물수 
		int totals = craigService.getContentCnt(dongList );
		// 토탈페이지
		int totalPage = (int) Math.ceil((double) totals/limit);		
		log.debug( "■■■ total 페이지 수 = {}", totalPage);	
		

		model.addAttribute("totalPage", totalPage);
		model.addAttribute("page", cpage);
		
		model.addAttribute("craigList", craigList);
		model.addAttribute("craigCategory", craigCategory);
		model.addAttribute("member", member);
		model.addAttribute("wishCnt", wishCnt);
		
		// 페이징
		CraigPage  craigPage = new CraigPage(totals, cpage, limit, 5);
		model.addAttribute("craigPage", craigPage);
		
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
 
	 // ■ select one craigboard - 비동기로 해야될까?
/**	 
	 @GetMapping("/craigDetail.do")
	 public void craigDetail(@RequestParam int no, Model model, 
			 				Authentication authentication, HttpServletRequest request,
			 				 HttpServletResponse response) {
		 
		 Member member = ((Member)authentication.getPrincipal());
		 log.debug("■ member : " +  member);

			
		 // board 쿠키 처리 ( 클라이언트쪽에 board [번호] 저장 
			String boardCookieVal = "";
			boolean hasRead = false;
			
			Cookie[] cookies = request.getCookies();
	
			if( cookies != null) {
				for( Cookie cookie : cookies) {
					String name = cookie.getName();
					String value = cookie.getValue();
					
					if("board".equals(name)) {
						boardCookieVal  = value; // board = "[84][22]" 이런식으로 담김 
						if(value.contains("[" + no + "]" )){
							hasRead = true;
						}
					}
				}
				
			}
			
			//응답쿠키
			if(!hasRead) {
				Cookie cookie = new Cookie("board", boardCookieVal + "[" + no + "]" );
				cookie.setMaxAge(365*24*60*60);
				cookie.setPath(request.getContextPath()+"/craig/craigDetail");
				response.addCookie(cookie);	
			}
			
			 log.debug(" ===== 여기까지 찍히니 ?===== ");	
			 
			 Craig craigboard = craigService.selectcraigOne(no, hasRead);
			 
			 craigboard.setContent(OeeUtils.convertLineFeedToBr(
						OeeUtils.escapeHtml(craigboard.getContent())));

			 log.debug("■ 찍히는데 왜 모델앤뷰로안넘어갈까 ? craigboard : " + craigboard);
				
//			 model.addAttribute("loginmember", member);
			 model.addAttribute("craigboard", craigboard);
			 
			 return ;

	 }
 **/
 
	 // ■ select one craigboard - 원래
	 @GetMapping("/craigDetail.do")
	 public void craigDetail(@RequestParam int no, Model model, Authentication authentication) {
		 boolean hasRead = true;
		 
		 Member member = ((Member)authentication.getPrincipal());

		 Map<String, Object> param = new HashMap<>();
		 param.put("memberId", member.getMemberId());
		 param.put("no", no);
		 
		 Craig craigboard = craigService.selectcraigOne(no, hasRead);
		 
		 craigboard.setContent(OeeUtils.convertLineFeedToBr(
					OeeUtils.escapeHtml(craigboard.getContent())));
		 
		 
		 int findCraigWish = craigService.selectCraigWish(param);
		 
		 log.debug("■ member : " +  member);
		 log.debug("■ craigboard : " + craigboard);	
		 log.debug("■ findCraigWish : " + findCraigWish);	
		 
		 model.addAttribute("craigboard", craigboard);
		 model.addAttribute("findCraigWish", findCraigWish);
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
		/*
		 * Map<String,Object> param = new HashMap<>(); param.put("no", no);
		 * param.put("hasRead", hasRead);
		 */
		 
		 Craig craigboard = craigService.selectcraigOne(no, hasRead);
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
		 	Craig craigboard  = craigService.selectcraigOne(no, hasRead);
		 
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
				redirectAttr.addFlashAttribute("msg", "중고거래 게시글을 성공적으로 삭제했습니다☺️");
		 }
		 
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
    
    // ■ wish한게시물의 wish가져오기
    @ResponseBody
    @GetMapping("/selectCraigWishOne.do")
    public int selectCraigWishOne(@RequestParam int no) {    	
    	int result = craigService.selectCraigWishOne(no);
    	return result;
    }
	 
    
    // ■ 검색
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 /*
	  * 하나시작
	  */
	 
	 @GetMapping("/mySalCraig.do")
		public void mySalCraig(Authentication authentication, Model model) {
			// member  
			Member member = ((Member)authentication.getPrincipal());
			log.debug("member = {} ", member);
			/*
			List<Craig> mySalCraig = craigService.mySalCraig(member);
			
			log.debug("mySalCraig = {}",mySalCraig);
			
			model.addAttribute("mySalCraig",mySalCraig);
			*/
		}
	 @GetMapping("/mySalFCraig.do")
	 public void mySalFCraig(Authentication authentication, Model model) {
		 // member  
		 Member member = ((Member)authentication.getPrincipal());
		 log.debug("member = {} ", member);
		 /*
			List<Craig> mySalCraig = craigService.mySalCraig(member);
			
			log.debug("mySalCraig = {}",mySalCraig);
			
			model.addAttribute("mySalCraig",mySalCraig);
		  */
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
	 /*
	  * 하나끝
	  */
}
