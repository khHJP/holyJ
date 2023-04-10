package com.sh.oee.chat.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sh.oee.chat.model.dto.ChatLogType;
import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.dto.TogetherChat;
import com.sh.oee.chat.model.dto.TogetherMsg;
import com.sh.oee.chat.model.service.ChatService;
import com.sh.oee.common.OeeUtils;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.service.CraigService;
import com.sh.oee.craigMeeting.model.dto.CraigMeeting;
import com.sh.oee.craigMeeting.model.service.MeetingService;
import com.sh.oee.manner.model.dto.Manner;
import com.sh.oee.manner.model.service.MannerService;
import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;
import com.sh.oee.report.model.dto.ReportReason;
import com.sh.oee.report.model.service.ReportService;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.service.TogetherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private ChatService chatService;
	@Autowired
	private CraigService craigService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private TogetherService togetherService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private ReportService reportService;
	@Autowired
	private ServletContext application;	
	@Autowired
	private MannerService mannerService; //혜진추가 0406

	@GetMapping("/chatList.do")
	public void chatList(Authentication authentication, Model model) {
		// 1. 로그인한 사용자 꺼내기
		Member member = (Member) authentication.getPrincipal();
		
		model.addAttribute(member);
	}

	/**
	 * 나의오이 - 중고거래 채팅
	 */
	@GetMapping("/findMyCraigChat.do")
	@ResponseBody
	public List<Map<String, Object>> findMyCraigChat(String memberId){
		log.debug("멤버아이디 = {}", memberId);
		
		// 1. 멤버 아이디를 가지고 craig_chat에서 참여중인 채팅방 전부 가져오기 (나가기 안한 방만)
		List<CraigChat> myCraigChat = chatService.findAllCraigChatroom(memberId);
		
		List<Map<String, Object>> chatList = new ArrayList<>();
		
		// 2. 각 채팅방의 마지막 메시지 + 메시지 작성자 객체 map -> List에 담기
		
		for(int i = 0; i < myCraigChat.size(); i++) {
			Map<String, Object> chatMap = new HashMap<>();
			
			CraigChat chat = myCraigChat.get(i);
			
			log.debug("채팅 = {}", chat);
			log.debug("채팅방번호 = {}", chat.getChatroomId());

			
			if(chat.getCraigNo() != 0) { // 게시글이 삭제되지 않았을 때 
				CraigMsg lastChat = chatService.findLastCraigMsgByChatroomId(chat.getChatroomId());
				log.debug("마지막채팅 = {}", lastChat);
				
				// 게시글 제목 담기
				chatMap.put("craigTitle", craigService.findCraigByCraigNo(chat.getCraigNo()).getTitle());
				
				if(lastChat != null) { // 채팅이 한개라도 있을때
					Member chatWriter = memberService.selectOneMember(lastChat.getWriter());
					log.debug("마지막채팅 작성자 = {}", chatWriter);
					chatMap.put("lastChat", lastChat);
					chatMap.put("chatroomId", lastChat.getChatroomId());
					
					Map<String, Object> findChat = new HashMap<>();
					findChat.put("memberId", memberId);
					findChat.put("chatroomId", lastChat.getChatroomId());
					CraigChat craigChat = chatService.findCraigChat(findChat);
					
					chatMap.put("craigNo", craigChat.getCraigNo());
					chatMap.put("chatWriter", chatWriter);
					
					chatList.add(chatMap);
				};				
			};
		};
		return chatList;
	}
	
	/**
	 * 나의오이 - 같이해요 채팅
	 */
	@GetMapping("/findMyTogetherChat.do")
	@ResponseBody
	public List<Map<String, Object>> findMyTogetherChat(String memberId){
		log.debug("멤버아이디 = {}", memberId);
		
		// 1. 멤버 아이디를 가지고 TOGETHER_CHAT 에서 참여중인 채팅방 전부 가져오기 (모집종료 안된 글만)
		List<TogetherChat> myTogetherChat = chatService.findAllTogetherChatroom(memberId);
		
		List<Map<String, Object>> chatList = new ArrayList<>();
	
		// 2. 각 채팅방의 마지막 메시지 + 메시지 작성자 객체 map -> List에 담기
		for(int i = 0; i < myTogetherChat.size(); i++) {
			Map<String, Object> chatMap = new HashMap<>();
			
			TogetherChat chat = myTogetherChat.get(i);
			
			log.debug("채팅 = {}", chat);
			log.debug("채팅방번호 = {}", chat.getTogetherNo());

			
			TogetherMsg lastChat = chatService.findLastTogetherMsgByTogetherNo(chat.getTogetherNo());
			log.debug("마지막채팅 = {}", lastChat);
				
			// 게시글 제목 담기
			Together together = togetherService.findTogetherByChatroomNo(chat.getTogetherNo());
			
			chatMap.put("togetherTitle", together.getTitle());
			log.debug("제목 = {}", together.getTitle());	
			
			if(lastChat != null) { // 채팅이 한개라도 있을때
				Member chatWriter = memberService.selectOneMember(lastChat.getWriter());
				log.debug("마지막채팅 작성자 = {}", chatWriter);
				chatMap.put("lastChat", lastChat);
				chatMap.put("chatroomNo", lastChat.getChatroomNo());
				
				Map<String, Object> findChat = new HashMap<>();
				findChat.put("memberId", memberId);
				findChat.put("chatroomNo", lastChat.getChatroomNo());
				TogetherChat togetherChat = chatService.findTogetherChat(findChat);
				
				chatMap.put("togetherNo", togetherChat.getTogetherNo());
				chatMap.put("chatWriter", chatWriter);
				
				chatList.add(chatMap);
			};				
		
		};
		return chatList;
	}
	
	
	
	
	/**
	 * 같이해요 채팅방 입장
	 */
	@ResponseBody
	@GetMapping("togetherChat/{togetherNo}")
	public int togetherChat(@PathVariable int togetherNo, Authentication authentication, HttpSession session) {

		// 같이해요 detail 참여자 추가용
		int result = 0;
		
		// 1. 로그인한 사용자 id 꺼내기
		String memberId = ((Member) authentication.getPrincipal()).getMemberId();

		log.debug("memberId = {}", memberId);
		
		// 2. 게시글 번호로 게시글객체 -> 작성자 id 꺼내오기
		Together together = togetherService.selectTogetherByNo(togetherNo);
		String writer = together.getWriter();
		log.debug("writer = {}", writer);

		// 3. 사용자가 게시글 작성자일때
		if(memberId.equals(writer)) {
			log.debug("게시글작성자가 = {}", "사용자");
		}
		// 4. 게시글 작성자가 아닐때
		else {
			log.debug("게시글작성자가 = {}", "사용자가아님");
			// 5. 해당 대화방 참여여부 확인
			Map<String, Object> map = new HashMap<>();
			map.put("togetherNo", togetherNo);
			map.put("memberId", memberId);
			TogetherChat togetherChat = chatService.findTogetherMember(map);
			log.debug("채팅 = {}", togetherChat);
			
			if(togetherChat == null) {
				result = chatService.insertTogetherMember(map);
			}
			
		}

		return result;
	}
	/**
	 * 같이해요 채팅방 팝업 열기
	 */
	@GetMapping("/togetherChat.do")
	public String togetherChatPop(@RequestParam int togetherNo, Authentication authentication, Model model) {

		// 1. 사용자 담기
		Member chatUser = (Member) authentication.getPrincipal();
		log.debug("사용자담기 = {}", chatUser);
		model.addAttribute("chatUser", chatUser);
		
		// 2. 채팅방 참여자 담기
		Map<String, Object> map = new HashMap<>();
		map.put("togetherNo", togetherNo);
		map.put("memberId", chatUser.getMemberId());
		List<TogetherChat> allMembers = chatService.findAllTogetherMembers(map);
		log.debug("참여자담기 = {}", allMembers);
		
		// 참여자 Member객체 담을 List
		List<Member> chatMembers = new ArrayList<>();
		
		// 3. 메시지 리스트 담기
		// 내채팅 가져오기
		TogetherChat myChat = null;
		for(TogetherChat chat : allMembers) {
			if(chat.getMemberId().equals(chatUser.getMemberId())) {
				myChat = chat;
			} else {
				chatMembers.add(memberService.selectOneMember(chat.getMemberId()));
			}
 		}
		
		// 참여자목록 담기
		model.addAttribute("chatMembers", chatMembers);
		log.debug("내채팅정보 = {}", myChat);
		
		// 내채팅에서 꺼낸 reg_date 이후 작성된 메시지들만 가져옴
		Map<String, Object> regMap = new HashMap<>();
		Timestamp regDate = Timestamp.valueOf(myChat.getRegDate());
		regMap.put("regDate", regDate.getTime());
		regMap.put("togetherNo", togetherNo);
		
		List<TogetherMsg> togetherMsgs = chatService.findTogetherMsgAfterReg(regMap);
		model.addAttribute("togetherMsgs", togetherMsgs);
		log.debug("메시지들 = {}", togetherMsgs);
		
		// 4. 게시글 정보 담기
		Together together = togetherService.selectTogetherByNo(togetherNo);
		model.addAttribute("together", together);
		log.debug("게시글정보 = {}", together);
		
		// 5. 신고사유 항목 담기
		List<ReportReason> reasonList = reportService.getReportReason("US");
		model.addAttribute("reasonList", reasonList);
		
		return "chat/togetherChatroom";
	}
	/**
	 * 같이해요 채팅방 첨부파일 저장 처리
	 */
    @PostMapping("/togetherChatAttach")
    @ResponseBody
    public Map<String, Object> togetherChatAttach(MultipartFile file, String memberId) {
    
        String saveDirectory = application.getRealPath("/resources/upload/chat/together");
        log.debug("저장경로 = {}", saveDirectory);
        
        // 1. 반환할 MsgAttach객체 생성 
        MsgAttach attach = new MsgAttach();
        
        if(file.getSize() > 0) {
            // 2. 파일 저장하기
            String reFilename = OeeUtils.renameMultipartFile(file);
            String originalFilename = file.getOriginalFilename();
            File destFile = new File(saveDirectory, reFilename);
            try {
                file.transferTo(destFile);
            } catch (IllegalStateException | IOException e) {
                log.error(e.getMessage(), e);
            }
            
            // 2. craig_msg_attach에 한행 추가
            attach.setReFilename(reFilename);
            attach.setOriginalFilename(originalFilename);
            chatService.insertTogetherMsgAttach(attach);
        }
        Map<String, Object> map = new HashMap<>();
        Member member = memberService.selectOneMember(memberId);
        map.put("profileImg", member.getProfileImg());
        map.put("attach", attach);
        
        return map; // 메시지 보내기위해 필요한것: renamedFilename, profileImg 
    }
	
    @GetMapping("/findTogetherMember.do")
    @ResponseBody
    public Member findTogetherMember(String writer) {
    	log.debug("찍힙니까 = {}", writer);
    	
    	Member otherUser = memberService.selectOneMember(writer);
    	
    	return otherUser;
    }
    
	/**
	 * 같이해요 채팅방 나가기 처리 
	 */
	@PostMapping("/exitTogether.do")
	public void exitTogether(@RequestParam String memberId, @RequestParam int chatroomNo) {
		log.debug("아이디 = {}", memberId);
		log.debug("같이해요번호 = {}", chatroomNo);
		
		Map<String, Object> delMap= new HashMap<>();
		delMap.put("memberId", memberId);
		delMap.put("chatroomNo", chatroomNo);
		
		int result = chatService.exitTogether(delMap);
	}
    
    
    
	
	/* -------------------------- 중고거래 --------------------------  */
	
	/**
	 * 중고거래 채팅방 첨부파일 저장 처리
	 */
    @PostMapping("/craigChatAttach")
    @ResponseBody
    public Map<String, Object> craigChatAttach(MultipartFile file, String memberId) {
    
        String saveDirectory = application.getRealPath("/resources/upload/chat/craig");
        log.debug("저장경로 = {}", saveDirectory);
        
        // 1. 반환할 MsgAttach객체 생성 
        MsgAttach attach = new MsgAttach();
        
        if(file.getSize() > 0) {
            // 2. 파일 저장하기
            String reFilename = OeeUtils.renameMultipartFile(file);
            String originalFilename = file.getOriginalFilename();
            File destFile = new File(saveDirectory, reFilename);
            try {
                file.transferTo(destFile);
            } catch (IllegalStateException | IOException e) {
                log.error(e.getMessage(), e);
            }
            
            // 2. craig_msg_attach에 한행 추가
            attach.setReFilename(reFilename);
            attach.setOriginalFilename(originalFilename);
            chatService.insertCraigMsgAttach(attach);
        }
        Map<String, Object> map = new HashMap<>();
        Member member = memberService.selectOneMember(memberId);
        map.put("profileImg", member.getProfileImg());
        map.put("attach", attach);
        
        return map; // 메시지 보내기위해 필요한것: renamedFilename, profileImg 
    }
	/**
	 * 중고거래 채팅방 나가기 처리 
	 */
	@PostMapping("/updateDel.do")
	public void updateDel(@RequestParam String memberId, @RequestParam String chatroomId) {
		LocalDateTime delDate = LocalDateTime.now();
		
		log.debug("채팅방아이디 = {}", chatroomId);
		
		Map<String, Object> delMap= new HashMap<>();
		delMap.put("memberId", memberId);
		delMap.put("chatroomId", chatroomId);
		delMap.put("delDate", delDate);
		
		int result = chatService.updateDel(delMap);
	}
	
	/**
	 * 중고거래 게시글 작성자가 본인 게시글에서 대화중인 채팅방 선택시
	 */
	@GetMapping("/craigChatList.do")
	public void craigChatList(@RequestParam int craigNo, Authentication authentication, Model model) {
		// 1. 로그인한 사용자 id 꺼내기 (판매자)
		String memberId = ((Member) authentication.getPrincipal()).getMemberId();
//		log.debug("판매자 = {}", memberId);

		// 2. memberId, craigNo로 chatroom_id 조회
		Map<String, Object> craigChatMap = new HashMap<>();
		craigChatMap.put("memberId", memberId);
		craigChatMap.put("craigNo", craigNo);

		// 3. 해당 chatroomId로 모든 채팅방 조회해 List에 담기
		List<String> craigChatList = chatService.findCraigChatList(craigChatMap);
//		log.debug("채팅방id = {}", craigChatList);

		CraigMsg lastChat = new CraigMsg();

//		log.debug("리스트보기 = {}", craigChatList);

		// model로 전달할 대화상대 + 마지막메시지 객체
		List<Map<String, Object>> chatModel = new ArrayList<>();

		for (int i = 0; i < craigChatList.size(); i++) {

			String chatroomId = craigChatList.get(i);
			// 1. 채팅방id로 각 채팅방 마지막 메시지 가져옴
			lastChat = chatService.findLastCraigMsgByChatroomId(chatroomId);

			if (lastChat != null) {
				// 2. 현재 사용자 id, 채팅방id로 각 채팅방의 대화상대 가져옴
				Map<String, Object> startUser = new HashMap<>();
				startUser.put("memberId", memberId);
				startUser.put("chatroomId", chatroomId);
				// 대화상대 id
				String otherUserId = chatService.findOtherFromCraigChat(startUser);
				// id로 Member객체 가져옴
				Member otherUser = memberService.selectOneMember(otherUserId);

				// 대화상대 닉네임
				String otherName = otherUser.getNickname();
				// 대화상대 동 정보
				String otherDong = memberService.selectMydongName(otherUser.getDongNo());
				// 대화상대 프로필이미지
				String otherProf = otherUser.getProfileImg();

				// 3. 대화상대 + 메시지 담을 map
				Map<String, Object> chatMap = new HashMap<>();
				chatMap.put("otherName", otherName);
				chatMap.put("otherDong", otherDong);
				chatMap.put("otherProf", otherProf);
				chatMap.put("lastChat", lastChat);

				// 4. map을 List에 추가
				chatModel.add(chatMap);
			}
		}

		// 5. model에 List 넣어주기!
		model.addAttribute("chatModel", chatModel);

		// 6. model에 해당 중고거래 게시글 객체 담기
		Craig craig = craigService.findCraigByCraigNo(craigNo);
		model.addAttribute("craig", craig);

		// 7. model에 해당 중고거래 게시글 이미지 담기
		List<CraigAttachment> craigImg = craigService.selectcraigAttachments(craigNo);
		model.addAttribute("craigImg", craigImg);

	}

	/**
	 * 중고거래 게시글에서 채팅하기 선택시
	 */
	@ResponseBody
	@GetMapping("/craigChat/{craigNo}")
	public Map<String, Object> craigChat(@PathVariable int craigNo, Authentication authentication, Model model,
			HttpSession session) {

		// 1. 로그인한 사용자 id 꺼내기
		String memberId = ((Member) authentication.getPrincipal()).getMemberId();

		// 2. 게시글 번호로 게시글객체 -> 판매자정보 꺼내기
		// 게시글정보만 가져오는 메소드 새로 추가함!
		Craig craig = craigService.findCraigByCraigNo(craigNo);
		String sellerId = craig.getWriter();

		// 3. memberId, craigNo로 chatroom_id 조회

		Map<String, Object> craigChatMap = new HashMap<>();
		craigChatMap.put("memberId", memberId);
		craigChatMap.put("craigNo", craigNo);

		String chatroomId = chatService.findCraigChatroomId(craigChatMap);

		// 채팅방 첫 입장시
		if (chatroomId == null) {
			// 1. chatroomId 생성 chatroomId =
			chatroomId = generateCraigChatroomId();
			log.debug("채팅방번호 = {}", chatroomId);

			// 2. craig_chat 테이블에 2행 insert (로그인한 사용자memberId, 게시글 작성자 sellerId)
			List<CraigChat> chatMembers = Arrays.asList(new CraigChat(chatroomId, memberId, craigNo),
					new CraigChat(chatroomId, sellerId, craigNo));
			int result = chatService.createCraigChatroom(chatMembers);
		}

		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("chatroomId", chatroomId);
		

		return map;
	}

	/**
	 * 중고거래 채팅방 chatroomId 생성
	 */
	private String generateCraigChatroomId() {
		StringBuilder chatroomId = new StringBuilder();
		Random random = new Random();
		final int LEN = 12;
		// 반복처리
		for (int i = 0; i < LEN; i++) {
			// 숫자
			if (random.nextBoolean()) {
				chatroomId.append(random.nextInt(10));
			}
			// 영문자
			else {
				// 대문자
				if (random.nextBoolean()) {
					chatroomId.append((char) (random.nextInt(26) + 'A'));
				}
				// 소문자
				else {
					chatroomId.append((char) (random.nextInt(26) + 'a'));
				}
			}
		}
		return chatroomId.toString();
	}
	
	/**
	 * 채팅 존재여부 확인
	 */
	@ResponseBody
	@GetMapping("/criagMsgCnt")
	public int criagMsgCnt(String chatroomId) {
		int result = 0;
		List<CraigMsg> msgs = chatService.findCraigMsgBychatroomId(chatroomId);
		result = msgs.size();
		log.debug("개수={}", result);
		
		return result;
	}
	
	/**
	 * 중고거래 채팅방 팝업 열기
	 */
	@GetMapping("/craigChat.do")
	public String craigChatPop(@RequestParam String chatroomId, @RequestParam String memberId, @RequestParam int craigNo, Model model) {
		// 1. chatroomId, memberId, craigNo로 craigChat객체 가져오기
		Map<String, Object> craigChatMap = new HashMap<>();
		craigChatMap.put("memberId", memberId);
		craigChatMap.put("chatroomId", chatroomId);

		CraigChat craigChat = chatService.findCraigChat(craigChatMap);
		
		// craigMsgs 객체 선언
		List<CraigMsg> craigMsgs = null;
		
		CraigMsg place = null;
		
		// 2. DEL_DATE 조회 후 분기 
		// 2-1. DEL_DATE = null : 안나갔음
		if(craigChat.getDelDate() == null) {
			// 대화내역 찾기 (after reg_date)
			Map<String, Object> regMap = new HashMap<>();
			Timestamp reg = Timestamp.valueOf(craigChat.getRegDate());
			regMap.put("regDate", reg.getTime());
			regMap.put("chatroomId", chatroomId);
			
			craigMsgs = chatService.findCraigMsgAfterReg(regMap);
			
			model.addAttribute("craigMsgs", craigMsgs);			
		}
		
		// 2-2. DEL_DATE != null : 나갔던 채팅방임
		else {
			// ** craig_chat의 해당 멤버 행 update (reg_date: 지금, del_date: null)
			Map<String, Object> regMap = new HashMap<>();
			regMap.put("memberId", memberId);

			regMap.put("regDate",LocalDateTime.now());
			regMap.put("chatroomId", chatroomId);
			chatService.updateRegDel(regMap);
			
			// del_date는 LocalDateTime 형식! sent_time과 비교를 위해 Timestamp로 변환해준다
			Timestamp now = Timestamp.valueOf(LocalDateTime.now());
			regMap.put("regDate", now.getTime());
			// 대화내역 찾기 (after reg_date)
			craigMsgs = chatService.findCraigMsgAfterReg(regMap);
			model.addAttribute("craigMsgs", craigMsgs);
		}
		
		// 2-3. PLACE 메시지 담기
		for(int i = 0; i < craigMsgs.size(); i++) {
			if(craigMsgs.get(i).getType() == ChatLogType.PLACE) {
				log.debug("나와랏 = {}", craigMsgs.get(i));
				model.addAttribute("placeMsg", craigMsgs.get(i));
			}
		}
		
		// 3. 대화상대 Member객체 담기
		// 채팅방 아이디로 채팅방을 조회하고, 나온 멤버중 본인을 제외한 멤버 가져옴
		Map<String, Object> startUser = new HashMap<>();
		startUser.put("memberId", memberId);
		startUser.put("chatroomId", chatroomId);
		String otherUserId = chatService.findOtherFromCraigChat(startUser);
		// 조회한 아이디로 Member객체 조회
		Member otherUser = memberService.selectOneMember(otherUserId);
		
		model.addAttribute("otherUser", otherUser);
	
		// 4. 사용자 아이디 담기
		model.addAttribute("memberId", memberId);
		Member chatUser = memberService.selectOneMember(memberId);
		model.addAttribute("chatUser", chatUser);
		
		// 5. 게시글 정보 담기
		Craig craig = craigService.findCraigByCraigNo(craigNo);
		model.addAttribute("craig", craig);
		
		CraigMeeting meeting = null;
		meeting = meetingService.findMeetingByCraigNo(craigNo);
		model.addAttribute("meeting", meeting);
		if(meeting != null) {
			model.addAttribute("meetingDate", convertMeetingDate(meeting.getMeetingDate()));
		}
		
		// 6. 게시글 첨부파일 담기
		List<CraigAttachment> craigImg = craigService.selectcraigAttachments(craigNo);
		model.addAttribute("craigImg", craigImg);

		// 7. 채팅방아이디 담기
		model.addAttribute("chatroomId", chatroomId);

		// 8. 사용자의 dong_no로 해당 지역 위경도 가져오기
		int dongNo = chatUser.getDongNo();
		Dong dong = memberService.selectOneDong(dongNo);
		model.addAttribute("dong", dong);
		log.debug("동정보 = {}", dong);
		
		// 9. 신고사유 항목 담기
		List<ReportReason> reasonList = reportService.getReportReason("US");
		model.addAttribute("reasonList", reasonList);
		
		// ++ 10.매너평가 테이블 정보가져오기 -- 혜진 
		Map<String, Object> mannerMap = new HashMap<>();
		mannerMap.put("writer", memberId); //내가매너평가했다
		mannerMap.put("craigNo", craigNo);
		Manner mydonemanner = mannerService.selectMannerOne(mannerMap);
		log.debug("● manner = {}", mydonemanner);
		model.addAttribute("mydonemanner", mydonemanner);
				

		return "chat/craigChatroom";
	}
	
	public String convertMeetingDate (LocalDateTime meetingDate){
		String dateText = "";
		
		DayOfWeek dayOfWeek = meetingDate.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.SHORT, Locale.KOREAN); // 요일 한국어로 출력 (토) 
		
		dateText += 
				meetingDate.getMonthValue() + "/" + meetingDate.getDayOfMonth() + "(" + day + ") "
				+ meetingDate.format(DateTimeFormatter.ofPattern("a hh:mm"));

		return dateText;
	}
	
	

}
