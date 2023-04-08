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

import com.sh.oee.chat.model.dto.CraigChat;
import com.sh.oee.chat.model.dto.CraigMsg;
import com.sh.oee.chat.model.dto.MsgAttach;
import com.sh.oee.chat.model.service.ChatService;
import com.sh.oee.common.OeeUtils;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.service.CraigService;
import com.sh.oee.craigMeeting.model.dto.CraigMeeting;
import com.sh.oee.craigMeeting.model.service.MeetingService;
import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.member.model.service.MemberService;
import com.sh.oee.report.model.dto.ReportReason;
import com.sh.oee.report.model.service.ReportService;
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
	private ServletContext application;
	@Autowired
	private ReportService reportService;

	@GetMapping("/chatList.do")
	public void chatList() {

	}

	

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
