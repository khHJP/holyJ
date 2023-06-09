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
import java.util.Collections;
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
	private MannerService mannerService; // 혜진추가 0406

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
	public List<Map<String, Object>> findMyCraigChat(String memberId) {
		log.debug("멤버아이디 = {}", memberId);

		// 1. 멤버 아이디를 가지고 craig_chat에서 참여중인 채팅방 전부 가져오기 (나가기 안한 방만)
		List<CraigChat> myCraigChat = chatService.findAllCraigChatroom(memberId);

		List<Map<String, Object>> chatList = new ArrayList<>();

		// 2. 각 채팅방의 마지막 메시지 + 메시지 작성자 객체 map -> List에 담기

		for (int i = 0; i < myCraigChat.size(); i++) {
			Map<String, Object> chatMap = new HashMap<>();

			CraigChat chat = myCraigChat.get(i);

			log.debug("채팅 = {}", chat);
			log.debug("채팅방번호 = {}", chat.getChatroomId());

			if (chat.getCraigNo() != 0) { // 게시글이 삭제되지 않았을 때
				CraigMsg lastChat = chatService.findLastCraigMsgByChatroomId(chat.getChatroomId());
				log.debug("마지막채팅 = {}", lastChat);

				// 게시글 제목 담기
				chatMap.put("craigTitle", craigService.findCraigByCraigNo(chat.getCraigNo()).getTitle());

				if (lastChat != null) { // 채팅이 한개라도 있을때
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
				}
				;
			}
			;
		}
		;
		return chatList;
	}

	/**
	 * 나의오이 - 같이해요 채팅
	 */
	@GetMapping("/findMyTogetherChat.do")
	@ResponseBody
	public List<Map<String, Object>> findMyTogetherChat(String memberId) {
		log.debug("멤버아이디 = {}", memberId);

		// 1. 멤버 아이디를 가지고 TOGETHER_CHAT 에서 참여중인 채팅방 전부 가져오기 (모집종료 안된 글만)
		List<TogetherChat> myTogetherChat = chatService.findAllTogetherChatroom(memberId);

		List<Map<String, Object>> chatList = new ArrayList<>();

		// 2. 각 채팅방의 마지막 메시지 + 메시지 작성자 객체 map -> List에 담기
		for (int i = 0; i < myTogetherChat.size(); i++) {
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

			if (lastChat != null) { // 채팅이 한개라도 있을때
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
			}
			;

		}
		;
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
		if (memberId.equals(writer)) {
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

			if (togetherChat == null) {
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
		for (TogetherChat chat : allMembers) {
			if (chat.getMemberId().equals(chatUser.getMemberId())) {
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

		if (file.getSize() > 0) {
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

		Map<String, Object> delMap = new HashMap<>();
		delMap.put("memberId", memberId);
		delMap.put("chatroomNo", chatroomNo);

		int result = chatService.exitTogether(delMap);
	}

	/* -------------------------- 중고거래 -------------------------- */

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

		if (file.getSize() > 0) {
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
	@PostMapping("/exitCraigChat.do")
	public void exitCraigChat(@RequestParam String memberId, @RequestParam String chatroomId) {
		Map<String, Object> delMap = new HashMap<>();
		delMap.put("memberId", memberId);
		delMap.put("chatroomId", chatroomId);

		int result = chatService.exitCraigChat(delMap);
	}

	/**
	 * 중고거래 게시글 작성자가 본인 게시글에서 대화중인 채팅방 선택시
	 */
	@GetMapping("/sellerChatList.do")
	public void sellerChatList(@RequestParam int craigNo, Authentication authentication, Model model) {
		// 각 채팅방별 대화상대 정보, 마지막채팅을 Model에 담기 위해 List 선언
		List<Map<String, Object>> chatModel = new ArrayList<>();

		// 1. 게시글 정보 (+첨부파일)
		Craig craig = craigService.findCraigByCraigNo(craigNo);
		craig.setAttachments(craigService.selectcraigAttachments(craigNo));
		model.addAttribute("craig", craig);

		// 2. 로그인한 사용자 id 꺼내기 (판매자)
		String memberId = ((Member) authentication.getPrincipal()).getMemberId();

		// 3. memberId, craigNo로 모든 채팅방 chatroom_id 조회
		Map<String, Object> craigChatMap = new HashMap<>();
		craigChatMap.put("memberId", memberId);
		craigChatMap.put("craigNo", craigNo);
		List<String> chatroomIds = chatService.findAllCraigChatroomIds(craigChatMap);

		// 4. chatroomId 별로 대화상대 객체, 마지막채팅메시지 조회
		for (String chatroomId : chatroomIds) {
			List<CraigMsg> craigMsgs = findCraigMsg(chatroomId, memberId);
			if (!craigMsgs.isEmpty()) { // not null으론 안걸러짐!

				// 4-1. 현재 사용자 id, 채팅방id로 각 채팅방의 대화상대 가져옴
				Map<String, Object> startUser = new HashMap<>();
				startUser.put("memberId", memberId);
				startUser.put("chatroomId", chatroomId);

				// 대화상대 객체 (닉네임, 지역, 프로필사진)
				Member otherUser = memberService.selectOneMember(chatService.findOtherFromCraigChat(startUser));
				// 대화상대 동 정보
				String otherDong = memberService.selectMydongName(otherUser.getDongNo());
				// 마지막메시지
				CraigMsg lastChat = craigMsgs.get(craigMsgs.size() - 1);

				// 4-2 각 정보를 map에 담고, List에 추가
				Map<String, Object> chatMap = new HashMap<>();
				chatMap.put("otherUser", otherUser);
				chatMap.put("otherDong", otherDong);
				chatMap.put("lastChat", lastChat);

				chatModel.add(chatMap);
			}
		}
		// 5. model에 List 넣어주기!
		model.addAttribute("chatModel", chatModel);
	}

	/**
	 * 중고거래 게시글에서 채팅하기 선택시
	 */
	@ResponseBody
	@GetMapping("/craigChat/{craigNo}")
	public String craigChat(@PathVariable int craigNo, Authentication authentication, Model model) {

		// 1. 로그인한 사용자 id 꺼내기
		String memberId = ((Member) authentication.getPrincipal()).getMemberId();

		// 2. 게시글 번호로 게시글객체 -> 판매자정보 꺼내기
		// 게시글정보만 가져오는 메소드 새로 추가함!
		Craig craig = craigService.findCraigByCraigNo(craigNo); // 게시글객체
		String sellerId = craig.getWriter(); // 판매자아이디

		// 3. memberId, craigNo로 chatroom_id 조회
		Map<String, Object> craigChatMap = new HashMap<>();
		craigChatMap.put("memberId", memberId);
		craigChatMap.put("craigNo", craigNo);

		String chatroomId = chatService.findCraigChatroomId(craigChatMap);

		// 4. 조회한 chatroom_id로 분기
		// 채팅방 첫 입장시
		if (chatroomId == null) {
			// 4-1. chatroomId 생성
			chatroomId = generateCraigChatroomId();

			// 4-2. craig_chat 테이블에 2행 insert (로그인한 사용자 memberId, 게시글 작성자 sellerId)
			List<CraigChat> chatMembers = Arrays.asList(new CraigChat(chatroomId, memberId, craigNo), // 채팅방아이디, 사용자아이디,
																										// 게시글번호
					new CraigChat(chatroomId, sellerId, craigNo)); // 채팅방아이디, 판매자아이디, 게시글번호
			int result = chatService.createCraigChatroom(chatMembers);
		}

		return chatroomId; // 채팅방id, 사용자id 리턴
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
	public String craigChatPop(@RequestParam String chatroomId, @RequestParam String memberId,
			@RequestParam int craigNo, Model model) {

		List<CraigMsg> chatLogs = null; // chatLogs 객체 선언

		// 1. craigChat객체 가져오기 (chatroomId, memberId)
		Map<String, Object> craigChatMap = new HashMap<>();
		craigChatMap.put("memberId", memberId);
		craigChatMap.put("chatroomId", chatroomId);

		CraigChat craigChat = chatService.findCraigChat(craigChatMap);

		// 2. craigMsgs 담기
		chatLogs = findCraigMsg(chatroomId, memberId);
		model.addAttribute("craigMsgs", chatLogs);

		// 3. PLACE 메시지 담기
		CraigMsg placeMsg = null;
		for (CraigMsg chatLog : chatLogs) {
			if (chatLog.getType() == ChatLogType.PLACE) {
				placeMsg = chatLog;
			}
		}
		model.addAttribute("placeMsg", placeMsg);

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

		// 5. 게시글 정보 + 첨부파일 담기
		Craig craig = craigService.findCraigByCraigNo(craigNo);
		List<CraigAttachment> craigImg = craigService.selectcraigAttachments(craigNo);
		craig.setAttachments(craigImg);
		model.addAttribute("craig", craig);

		// 6. 약속 담기
		CraigMeeting meeting = null;
		meeting = meetingService.findMeetingByCraigNo(craigNo);
		model.addAttribute("meeting", meeting);
		if (meeting != null) {
			model.addAttribute("meetingDate", convertMeetingDate(meeting.getMeetingDate()));
		}

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
		mannerMap.put("writer", memberId); // 내가매너평가했다
		mannerMap.put("craigNo", craigNo);
		Manner mydonemanner = mannerService.selectMannerOne(mannerMap);
		log.debug("● manner = {}", mydonemanner);
		model.addAttribute("mydonemanner", mydonemanner);

		return "chat/craigChatroom";
	}

	public List<CraigMsg> findCraigMsg(String chatroomId, String memberId) {
	
		List<CraigMsg> craigMsgs = null; // 메시지 리스트 선언
		
		// 1. craigChat객체 가져오기 (chatroomId, memberId)
	    CraigChat craigChat = chatService.findCraigChat(Map.of(
	            "memberId", memberId,
	            "chatroomId", chatroomId
	    ));

		if (craigChat != null) {
			// 2. 채팅내역 담기 - DEL_DATE 조회 후 분기
			// 2-1. 나갔던 채팅방일 경우
			if (craigChat.getDelDate() != null) {
				// craig_chat의 해당 멤버 행 update (reg_date: 지금, del_date: null)
				chatService.reJoinCraigChat(Map.of(
						"memberId", memberId,
						"chatroomId", chatroomId
				));
			}
			// 2-2. reg_date 이후 내화내역 담기
			// sent_time은 unix초 형식 -> reg_date와 비교를 위해 변환
			Timestamp regDate = Timestamp.valueOf(craigChat.getRegDate());
			craigMsgs = chatService.findCraigMsgAfterReg(Map.of(
				        "regDate", regDate.getTime(),
				        "chatroomId", chatroomId
			));
		} 

		return craigMsgs == null ? new ArrayList<>() : craigMsgs;
	}

	
	public String convertMeetingDate(LocalDateTime meetingDate) {
		String dateText = "";

		DayOfWeek dayOfWeek = meetingDate.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.SHORT, Locale.KOREAN); // 요일 한국어로 출력 (토)

		dateText += meetingDate.getMonthValue() + "/" + meetingDate.getDayOfMonth() + "(" + day + ") "
				+ meetingDate.format(DateTimeFormatter.ofPattern("a hh:mm"));

		return dateText;
	}

}
