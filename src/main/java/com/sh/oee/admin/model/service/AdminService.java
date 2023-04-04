package com.sh.oee.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

public interface AdminService {

	/* select */
	
	// 회원 목록 조회
	List<Member> selectAdminMemberList(Map<String, Object> param, RowBounds rowBounds);
	
	// 중고거래 게시글 목록 조회
	List<Craig> selectAdminCraigList(Map<String, Object> param, RowBounds rowBounds);

	// 동네생활 게시글 목록 조회
	List<Local> selectAdminLocalList(Map<String, Object> param, RowBounds rowBounds);

	// 같이해요 게시글 목록 조회
	List<Together> selectAdminTogetherList(Map<String, Object> param, RowBounds rowBounds);

	// 게시글 신고 목록 조회
	List<BoardReport> selectAdminBoardReport(RowBounds rowBounds);

	// 사용자 신고 목록 조회
	List<UserReport> selectAdminUserReport(RowBounds rowBounds);
	
	// 총 회원 수 조회
	int selectAdminMemberTotalCount(Map<String, Object> param);
	
	// 총 중고거래 게시글 수 조회
	int selectAdminCraigTotalCount(Map<String, Object> param);
	
	// 총 동네생활 게시글 수 조회
	int selectAdminLocalTotalCount(Map<String, Object> param);
	
	// 총 같이해요 게시글 수 조회
	int selectAdminTogetherTotalCount(Map<String, Object> param);
	
	// 총 게시글 신고 수 조회
	int selectAdminBoardReportTotalCount(List<BoardReport> adminBoardReport);
	
	// 총 사용자 신고 수 조회
	int selectAdminUserReportTotalCount(List<UserReport> adminUserReport);
	
	/* update */
	
	// 회원 권한 수정
	int updateAdminMemberRole(Map<String, Object> adminMemberRoleUpdateMap);

	// 중고거래 카테고리 수정
	int updateAdminCraigCategory(Map<String, Object> adminCraigCategoryMap);

	// 동네생활 카테고리 수정
	int updateAdminLocalCategory(Map<String, Object> adminLocalCategoryMap);

	// 같이해요 카테고리 수정
	int updateAdminTogetherCategory(Map<String, Object> adminTogetherCategoryMap);

	// 회원 삭제 탈퇴일 수정
	int updateAdminMemberUnregister(String memberId);
	
	/* delete */
	
	// 중고거래 게시글 삭제
	int deleteAdminCraig(int no);
	
	// 동네생활 게시글 삭제
	int deleteAdminLocal(int no);
	
	// 같이해요 게시글 삭제
	int deleteAdminTogether(int no);

}
