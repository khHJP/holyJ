package com.sh.oee.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.notice.model.dto.NoticeAdmin;
import com.sh.oee.notice.model.dto.NoticeKeyword;

public interface NoticeDao {

	List<NoticeKeyword> selectKeywordList(Member member);

	int insertKeyword(Map<String, Object> param);

	int deleteKeyword(int keywordNo);

	List<NoticeAdmin> selectAdminNoticeList(RowBounds rowBounds);

	int insertAdminNotice(NoticeAdmin notice);

	int deleteAdminNotice(int no);

	int selectAdminNoticeTotalCount();

}
