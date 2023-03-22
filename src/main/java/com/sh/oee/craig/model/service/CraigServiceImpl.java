package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.craig.model.dao.CraigDao;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;

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

	
	@Override
	public int insertCraigAttachment(CraigAttachment attach) {
		return craigDao.insertCraigAttachment(attach);
	}

	
	//select one
	@Override
	public Craig selectcraigOne(int no) {
		return craigDao.selectcraigOne(no);
	}

	@Override
	public String selectMyCraigCategory(int categoryNo) {
		return craigDao.selectMyCraigCategory(categoryNo);
	}

}

	
		
		
