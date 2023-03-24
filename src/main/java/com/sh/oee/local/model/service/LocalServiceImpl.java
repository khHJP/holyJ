package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.local.model.dao.LocalDao;
import com.sh.oee.local.model.dto.Local;
import com.sh.oee.member.model.dto.Member;

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
	
}
