package com.sh.oee.together.model.dto;

import java.time.LocalDateTime;

import com.sh.oee.chat.model.dto.Role;
import com.sh.oee.chat.model.dto.TogetherChat;
import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class JoinMember extends TogetherChat {
	
	private Member member;
	private int joinCnt;

	public JoinMember(@NonNull int chatroomNo, int togetherNo, @NonNull String memberId, @NonNull Role role,
			LocalDateTime regDate, long lastCheck) {
		super(chatroomNo, togetherNo, memberId, role, regDate, lastCheck);
	}

	public JoinMember(@NonNull int chatroomNo, @NonNull String memberId, @NonNull Role role) {
		super(chatroomNo, memberId, role);
	}

	public JoinMember(@NonNull int chatroomNo, int togetherNo, @NonNull String memberId, @NonNull Role role,
			LocalDateTime regDate, long lastCheck, Member member) {
		super(chatroomNo, togetherNo, memberId, role, regDate, lastCheck);
		this.member = member;
	}
	
	
}
