package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.local.model.dao.LocalDao;
import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;

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
	public List<Local> localList() {
		return localDao.localList();
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
}
