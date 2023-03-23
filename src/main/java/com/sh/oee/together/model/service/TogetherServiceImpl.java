package com.sh.oee.together.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.together.model.dao.TogetherDao;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;

@Service
public class TogetherServiceImpl implements TogetherService {

	@Autowired
	private TogetherDao togetherDao;

	@Override
	public List<TogetherEntity> selectTogetherList(String writer) {
		return togetherDao.selectTogetherList(writer);
	}

	@Override
	public List<Map<String,String>> selectTogetherCategory() {
		return togetherDao.selectTogetherCategory();
	}

	@Override
	public List<Together> selectTogetherListByDongName(List<String> myDongList) {
		return togetherDao.selectTogetherListByDongName(myDongList);
	}

	
}
