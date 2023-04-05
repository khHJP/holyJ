package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.local.model.dao.LocalDao;
import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;
import com.sh.oee.local.model.dto.LocalComment;
import com.sh.oee.local.model.dto.LocalCommentEntity;
import com.sh.oee.local.model.dto.LocalEntity;
import com.sh.oee.local.model.dto.LocalLike;
import com.sh.oee.member.model.dto.Member;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional(rollbackFor = Exception.class)
@Service
public class LocalServiceImpl implements LocalService {
	
	@Autowired
	private LocalDao localDao;
	
	//동네생활 전체 목록 조회
	@Override
	public List<Local> selectLocalListByDongName(Map<String, Object> param, RowBounds rowBounds) {
		return localDao.selectLocalListByDongName(param, rowBounds);
	}
	
	//카테고리
	@Override
	public List<Map<String, String>> localCategoryList() {
		return localDao.localCategoryList();
	}

	// ----------------------------- 하나 시작 -----------------------------------------------
	@Override
	public List<Local> selectLocalList(Member member) {
		// TODO Auto-generated method stub
		return localDao.selectLocalList(member);
	}
	@Override
	public List<LocalCommentEntity> selectLocalCommentList(String memberId) {
		// TODO Auto-generated method stub
		return localDao.selectLocalCommentList(memberId);
	}
	// ----------------------------- 하나 끝 -----------------------------------------------
	
	//게시글 등록
	@Override
	public int insertLocalBoard(Local local) {
		
		int result = localDao.insertLocalBoard(local);
		log.debug("local no = {}", local.getNo());
		
		List<LocalAttachment> attachments = local.getAttachments();
		if(attachments.size() > 0) {
			for(LocalAttachment attach : attachments) {
				attach.setLocalNo(local.getNo());
				result = insertLocalAttachment(attach);
			}
		}
		return result;
		
	}
	
	@Override
	public int insertLocalAttachment(LocalAttachment attach) {
		return localDao.insertLocalAttachment(attach);
	}

	
	//게시글 한건 조회
	@Override
	public Local selectLocalOne(int no) {
		return localDao.selectLocalOne(no);
	}
	
	//게시글 수정
	@Override
	public int updateLocalBoard(Local local) {
		
		int result = localDao.updateLocalBoard(local);
		log.debug("local no = {}" , local.getNo());
		
		return result;
	}
	
	//게시글 수정 첨부파일
	@Override
	public List<LocalAttachment> selectLocalAttachments(int no){
		return localDao.selectLocalAttachments(no);
	}

	//게시글 삭제
	@Override
	public int deleteLocal(int no) {
		
		int result = 0;
		result = localDao.deleteLocal(no);
		log.debug("local no = {} " , no);
		
		return result;
	}
	
	//조회수 증가
	@Override
	public int hits(int no) {
		int result = localDao.hits(no);
		return result;
	}
	
	@Override
	public int selectLocalLike(Map<String,Object> param) {
		return localDao.selectLocalLike(param);
	}
	
	@Override
	public int DeleteLocalLike(Map<String, Object> param) {
		return localDao.DeleteLocalLike(param);
	}
	
	
	
	@Override
	public int InsertLocalLike(Map<String, Object> param) {
		return localDao.InsertLocalLike(param);
	}

	@Override
	public int selectAttachNo(int no) {
		
		return localDao.selectAttachNo(no);
	}

	@Override
	public int updateAttachFile(LocalAttachment attach) {
		return localDao.updateAttachFile(attach);
		
	}

	@Override
	public int getLocalTotalCount(Map<String, Object> param) {
		return localDao.getLocalTotalCount(param);
	}

	//댓글
	@Override
	public int insertComment(LocalCommentEntity comment) {
		return localDao.insertComment(comment);
	}


//	@Override
//	public int insertComment(Map<String, Object> param) {
//		// TODO Auto-generated method stub
//		return 0;
//	}

	@Override
	public List<LocalCommentEntity> selectLocalCommentListByBoardNo(int no, String orderBy) {
		// TODO Auto-generated method stub
		return localDao.commentList(no,orderBy);
	}

	@Override
	public int deleteComment(int no) {
		return localDao.deleteComment(no);
	}

	@Override
	public int updateComment(LocalComment comment) {
		return localDao.updateComment(comment);
	}

	@Override
	public int insertReComment(LocalCommentEntity comment) {
		return localDao.insertReComment(comment);
	}

	@Override
	public List<LocalCommentEntity> commentNewList(int no) {
		return localDao.commentNewList(no);
	}

	@Override
	public List<LocalCommentEntity> commentList(int no, String orderBy) {
		return localDao.commentList(no, orderBy);
	}
}
