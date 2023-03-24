package com.sh.oee.together.model.service;

import java.util.List;
import java.util.Map;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;

public interface TogetherService {


	List<Together> selectTogetherList(Member member);

	List<Map<String,String>> selectTogetherCategory();

	List<Together> selectTogetherListByDongName(List<String> myDongList);

	Together selectTogetherByNo(int no);


}
