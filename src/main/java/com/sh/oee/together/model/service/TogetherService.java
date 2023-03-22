package com.sh.oee.together.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.together.model.dto.Together;

public interface TogetherService {

	List<Together> selectTogetherList(String writer);

	List<Map<String,String>> selectTogetherCategory();

	List<Together> selectTogetherListByDongName(List<String> myDongList);

}
