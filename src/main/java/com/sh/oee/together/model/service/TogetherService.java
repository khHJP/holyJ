package com.sh.oee.together.model.service;

import java.util.List;

import com.sh.oee.together.model.dto.Together;

public interface TogetherService {

	List<Together> selectTogetherList(String writer);

}
