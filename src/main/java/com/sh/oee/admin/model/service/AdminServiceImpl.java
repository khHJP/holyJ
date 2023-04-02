package com.sh.oee.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.admin.model.dao.AdminDao;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;
import com.sh.oee.report.model.dto.BoardReport;
import com.sh.oee.report.model.dto.UserReport;
import com.sh.oee.together.model.dto.Together;

@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;

	/*
	 * select
	 */
	
	// 회원 목록 조회
	@Override
	public List<Member> selectAdminMemberList(RowBounds rowBounds) {
		return adminDao.selectAdminMemberList(rowBounds);
	}
	
	// 중고거래 게시글 목록 조회
	@Override
	public List<Craig> selectAdminCraigList(RowBounds rowBounds) {
		return adminDao.selectAdminCraigList(rowBounds);
	}

	// 동네생활 게시글 목록 조회
	@Override
	public List<Local> selectAdminLocalList(RowBounds rowBounds) {
		return adminDao.selectAdminLocalList(rowBounds);
	}

	// 같이해요 게시글 목록 조회
	@Override
	public List<Together> selectAdminTogetherList(RowBounds rowBounds) {
		return adminDao.selectAdminTogetherList(rowBounds);
	}

	// 게시글 신고 목록 조회
	@Override
	public List<BoardReport> selectAdminBoardReport(RowBounds rowBounds) {
		return adminDao.selectAdminBoardReport(rowBounds);
	}

	// 사용자 신고 목록 조회
	@Override
	public List<UserReport> selectAdminUserReport(RowBounds rowBounds) {
		return adminDao.selectAdminUserReport(rowBounds);
	}
	
	// 총 회원 수 조회
	@Override
	public int selectAdminMemberTotalCount(List<Member> adminMemberList) {
		return adminDao.selectAdminMemberTotalCount(adminMemberList);
	}
	
	// 총 중고거래 게시글 수 조회
	@Override
	public int selectAdminCraigTotalCount(List<Craig> adminCraigList) {
		return adminDao.selectAdminCraigTotalCount(adminCraigList);
	}

	// 총 동네생활 게시글 수 조회
	@Override
	public int selectAdminLocalTotalCount(List<Local> adminLocalList) {
		return adminDao.selectAdminLocalTotalCount(adminLocalList);
	}

	// 총 같이해요 게시글 수 조회
	@Override
	public int selectAdminTogetherTotalCount(List<Together> adminTogetherList) {
		return adminDao.selectAdminTogetherTotalCount(adminTogetherList);
	}

	// 총 게시글 신고 수 조회
	@Override
	public int selectAdminBoardReportTotalCount(List<BoardReport> adminBoardReport) {
		return adminDao.selectAdminBoardReportTotalCount(adminBoardReport);
	}

	// 총 사용자 신고 수 조회
	@Override
	public int selectAdminUserReportTotalCount(List<UserReport> adminUserReport) {
		return adminDao.selectAdminUserReportTotalCount(adminUserReport);
	}
	
	/*
	 * update
	 */
	
	// 회원 권한 수정
	@Override
	public int updateAdminMemberRole(Map<String, Object> adminMemberRoleUpdateMap) {
		return adminDao.updateAdminMemberRole(adminMemberRoleUpdateMap);
	}
	
	// 중고거래 카테고리 수정
	@Override
	public int updateAdminCraigCategory(Map<String, Object> adminCraigCategoryMap) {
		return adminDao.updateAdminCraigCategory(adminCraigCategoryMap);
	}
	
	// 동네생활 카테고리 수정
	@Override
	public int updateAdminLocalCategory(Map<String, Object> adminLocalCategoryMap) {
		return adminDao.updateAdminLocalCategory(adminLocalCategoryMap);
	}

	// 같이해요 카테고리 수정
	@Override
	public int updateAdminTogetherCategory(Map<String, Object> adminTogetherCategoryMap) {
		return adminDao.updateAdminTogetherCategory(adminTogetherCategoryMap);
	}

	// 회원 삭제 탈퇴일 수정
	@Override
	public int updateAdminMemberUnregister(String memberId) {
		return adminDao.updateAdminMemberUnregister(memberId);
	}

	/*
	 * delete
	 */

	// 중고거래 게시글 삭제
	@Override
	public int deleteAdminCraig(int no) {
		return adminDao.deleteAdminCraig(no);
	}
	
	// 동네생활 게시글 삭제
	@Override
	public int deleteAdminLocal(int no) {
		return adminDao.deleteAdminLocal(no);
	}
	
	// 같이해요 게시글 삭제
	@Override
	public int deleteAdminTogether(int no) {
		return adminDao.deleteAdminTogether(no);
	}
}
