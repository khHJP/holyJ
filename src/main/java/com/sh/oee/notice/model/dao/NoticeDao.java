package com.sh.oee.notice.model.dao;

import java.util.List;
import java.util.Map;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dto.NoticeKeyword;

public interface NoticeDao {

	int insertKeyword(Map<String, Object> param);

	List<NoticeKeyword> selectKeywordList(Member member);

}
