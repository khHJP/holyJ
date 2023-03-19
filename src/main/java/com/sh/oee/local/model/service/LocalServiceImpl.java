package com.sh.oee.local.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.local.model.dao.LocalDao;
import com.sh.oee.local.model.dto.Local;

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
	
}
