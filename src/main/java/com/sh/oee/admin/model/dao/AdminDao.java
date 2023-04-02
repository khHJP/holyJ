package com.sh.oee.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

@Mapper
public interface AdminDao {

	/* select */
	
	// 회원 목록 조회
	List<Member> selectAdminMemberList(RowBounds rowBounds);
	
	// 중고거래 게시글 목록 조회
	List<Craig> selectAdminCraigList(RowBounds rowBounds);

	// 동네생활 게시글 목록 조회
	List<Local> selectAdminLocalList(RowBounds rowBounds);

	// 같이해요 게시글 목록 조회
	List<Together> selectAdminTogetherList(RowBounds rowBounds);

	// 게시글 신고 목록 조회
	List<BoardReport> selectAdminBoardReport(RowBounds rowBounds);

	// 사용자 신고 목록 조회
	List<UserReport> selectAdminUserReport(RowBounds rowBounds);
	
	// 총 회원 수 조회
	int selectAdminMemberTotalCount(List<Member> adminMemberList);
	
	// 총 중고거래 게시글 수 조회
	int selectAdminCraigTotalCount(List<Craig> adminCraigList);
	
	// 총 동네생활 게시글 수 조회
	int selectAdminLocalTotalCount(List<Local> adminLocalList);
	
	// 총 같이해요 게시글 수 조회
	int selectAdminTogetherTotalCount(List<Together> adminTogetherList);
	
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
