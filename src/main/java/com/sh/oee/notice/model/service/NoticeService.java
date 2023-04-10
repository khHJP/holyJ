package com.sh.oee.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.Payload;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dto.NoticeUser;
import com.sh.oee.notice.model.dto.NoticeAdmin;
import com.sh.oee.notice.model.dto.NoticeKeyword;

public interface NoticeService {


	List<NoticeKeyword> selectKeywordList(Member member);

	int insertKeyword(Map<String, Object> param);

	int deleteKeyword(int keywordNo);

	List<NoticeAdmin> selectAdminNoticeList(RowBounds rowBounds);

	int insertAdminNotice(NoticeAdmin notice);

	int deleteAdminNotice(int no);

	int selectAdminNoticeTotalCount();

}
