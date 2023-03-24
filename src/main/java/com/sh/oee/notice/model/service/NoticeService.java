package com.sh.oee.notice.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dto.NoticeKeyword;

public interface NoticeService {

	int insertKeyword(NoticeKeyword keyword, Member member);

	List<NoticeKeyword> selectKeywordList(Member member);

}
