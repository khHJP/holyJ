package com.sh.oee.together.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.together.model.dao.TogetherDao;
import com.sh.oee.together.model.dto.Together;

@Service
public class TogetherServiceImpl implements TogetherService {

	@Autowired
	private TogetherDao togetherDao;

	@Override
	public List<Together> selectTogetherList(String writer) {
		return togetherDao.selectTogetherList(writer);
	}
	
}
