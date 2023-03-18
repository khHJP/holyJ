package com.sh.oee.together.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.oee.together.model.dao.TogetherDao;

@Service
public class TogetherServiceImpl implements TogetherService {

	@Autowired
	private TogetherDao togetherDao;
	
}
