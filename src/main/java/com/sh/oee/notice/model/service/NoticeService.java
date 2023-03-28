package com.sh.oee.notice.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dto.NoticeKeyword;

public interface NoticeService {


	List<NoticeKeyword> selectKeywordList(Member member);

	int insertKeyword(Map<String, Object> param);

	int deleteKeyword(int keywordNo);

}
