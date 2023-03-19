package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.sh.oee.craig.model.dao.CraigDao;
import com.sh.oee.craig.model.dto.CraigEntity;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Slf4j
@Service
public class CraigServiceImpl implements CraigService {

	
	@Autowired
	private CraigDao craigDao;

	@Override
	public List<CraigEntity> craigList() {
		return craigDao.craigList();
	}

	//카테고리 목록조회 
	@Override
	public List<Map<String, String>> craigCategoryList() {
		return craigDao.craigCategoryList();
	}

	@Override
	public ResponseEntity<?> craigPlaceEnroll(double latitude, double longitude, String placeDetail) {
		String URL = "http://localhost:8080/craig/craigEnroll";
		return  new RestTemplate().exchange( URL, HttpMethod.PUT, null, Map.class);
	}
	
}
