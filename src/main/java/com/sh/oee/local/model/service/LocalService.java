package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;


import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;
import com.sh.oee.local.model.dto.LocalCommentEntity;
import com.sh.oee.local.model.dto.LocalEntity;
import com.sh.oee.local.model.dto.LocalLike;
import com.sh.oee.member.model.dto.Member;


public interface LocalService {

	//동네생활 전체목록
	List<Local> selectLocalListByDongName(Map<String, Object> param, RowBounds rowBounds);

	//카테고리
	List<Map<String, String>> localCategoryList();
	
	//게시글 등록
	int insertLocalBoard(Local local);
	
	//첨부파일 등록
	int insertLocalAttachment(LocalAttachment attach);
	
	//게시글 한건 조회
	Local selectLocalOne(int no);
	
	
	// ----------------------------- 하나 시작 -----------------------------------------------
	List<Local> selectLocalList(Member member);
	List<LocalCommentEntity> selectLocalCommentList(String memberId);
	// ----------------------------- 하나 끝 -----------------------------------------------
	
	// 게시글 삭제
	int deleteLocal(int no);

	// 게시글 수정 첨부파일 
	List<LocalAttachment> selectLocalAttachments(int no);
	
	// 게시글 수정
	int updateLocalBoard(Local local);

	// 조회수 증가
	int hits(int no);

	
	//좋아요
	int selectLocalLike(Map<String, Object> param);

	int DeleteLocalLike(Map<String, Object> param);

	int InsertLocalLike(Map<String, Object> param);

	

	int selectAttachNo(int no);

	int updateAttachFile(LocalAttachment attach);

	int getLocalTotalCount(Map<String, Object> param);

	
	//댓글
	int insertComment(LocalCommentEntity comment);

	List<LocalCommentEntity> commentList(int no);

	List<LocalCommentEntity> selectLocalCommentListByBoardNo(int no);

	

	

	


}
