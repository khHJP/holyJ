package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sh.oee.craig.model.dao.CraigDao;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigPage;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Slf4j
@Service
public class CraigServiceImpl implements CraigService {

	
	@Autowired
	private CraigDao craigDao;

	@Override
	public List<Craig> craigList(RowBounds rowBounds, List<String> dongList ) {
		return craigDao.craigList(rowBounds, dongList);
	}

	//카테고리 목록조회 
	@Override
	public List<Map<String, String>> craigCategoryList() {
		return craigDao.craigCategoryList();
	}


	//게시글등록
	@Override
	public int insertCraigBoard(Craig craig) {
		//글만등록 
		int result =  craigDao.insertCraigBoard(craig);
		log.debug("■ craig no = {}", craig.getNo());
		
		//첨부파일등록
		List<CraigAttachment> attachments = craig.getAttachments();
		if(attachments.size() > 0) {
			for(CraigAttachment attach : attachments) {
				attach.setCraigNo(craig.getNo());
				result = insertCraigAttachment(attach);
			}	
		}
		return result;
	}

	//첨부파일등록
	@Override
	public int insertCraigAttachment(CraigAttachment attach) {
		return craigDao.insertCraigAttachment(attach);
	}

	
	//select one 게시글 
	@Override
	public Craig selectcraigOne(int no, boolean hasRead) {
	//	boolean hasRead = (boolean) param.get("hasRead");
	//	int no = (int) param.get("no");
		
		if(!hasRead) craigReadCount(no);
		log.debug("■ selectcraigOne - impl - no = {}", no);
		
		return craigDao.selectcraigOne( no );
	}

	//select one 카테고리
	@Override
	public String selectMyCraigCategory(int categoryNo) {
		return craigDao.selectMyCraigCategory(categoryNo);
	}

	/**
	//update 
	@Override
	public int updateCraigBoard(Craig craig) {
		//글만등록 
		int result =  craigDao.updateCraigBoard(craig);
		log.debug("■ craig no = {}", craig.getNo());
		
		//첨부파일등록
		List<CraigAttachment> attachments = craig.getAttachments();
		log.debug("■ 멀티플은 없는데 이게 찍힌다고 ? attachments = {}", attachments);
		
		
		if(attachments.size() > 0 ) {
	
			for(CraigAttachment attach : attachments) {
				
				attach.setCraigNo(craig.getNo());
				result = upinsertCraigAttachment(attach);
			}	
		}
		return result;
	}
**/
	
	@Override
	public int updateCraigBoard(Craig craig, List<MultipartFile> upFiles) {
		//글만등록 
		int result =  craigDao.updateCraigBoard(craig);
		log.debug("■ craig no = {}", craig.getNo());
		
		//craig에 원래있던번호 +방금 등록한 파일번호 ?
		List<Object> upFiless = null;
		
		for(int i=0; i<craig.getAttachments().size(); i++ ) {
			upFiless.add( craig.getAttachments().get(i).getAttachNo());
		}
		
		// 지금 가지고 온 파일no와 비교 ?기존등록된 파일들고오기 
		for(int i=0; i<upFiless.size(); i++) {
	       int attachno = (int) upFiles.get(i).get
	       
	       if(! upFiles.contains(attachno) ) {
	           craigDao.deleteCraigAttachment(attachno);
	       }
		}
		
		
		//첨부파일등록
		List<CraigAttachment> attachments = craig.getAttachments();
		log.debug("■ 멀티플은 없는데 이게 찍힌다고 ? attachments = {}", attachments);
		
		
		if(attachments.size() > 0 ) {
	
			for(CraigAttachment attach : attachments) {
				
				attach.setCraigNo(craig.getNo());
				result = upinsertCraigAttachment(attach);
			}	
		}
		return result;
	}
	
	private int upinsertCraigAttachment(CraigAttachment attach) {
		// TODO Auto-generated method stub
		return  craigDao.upinsertCraigAttachment(attach);
	}

	//update - attachment 
	private int updateCraigAttachment(CraigAttachment attach) {
		return craigDao.updateCraigAttachment(attach);
	}

	
	//delete - attachment 
	@Override
	public int deleteCraigAttachment(int orifileattno) {
		return craigDao.deleteCraigAttachment( orifileattno);
	}

	@Override
	public List<CraigAttachment> selectcraigAttachments(int no) {
		return craigDao.selectcraigAttachments(no);
	}

	//게시글삭제 
	@Override
	public int deleteCraigBoard(int no) {
		//글만 삭제 
		int result = 0;
		result = craigDao.deleteCraigBoard(no);
		log.debug("■ craig no = {}", no );
		
		//첨부파일삭제
		result +=  craigDao.deleteCraigBoardAttachment(no);
		return result;
	}

	
	//조회수증가
	@Override
	public int craigReadCount(int no) {
		return craigDao.craigReadCount(no);
	}

	
	//페이지
	@Override
	public int getContentCnt(List<String> dongList ) {
		return craigDao.getContentCnt(dongList);
	}
	

}

	
		
		
