package com.sh.oee.member.model.service;

import com.sh.oee.member.model.dto.Member;

public interface MemberService {

	Member selectOneMember(String memberId);

}
