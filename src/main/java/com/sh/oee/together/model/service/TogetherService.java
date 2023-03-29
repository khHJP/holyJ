package com.sh.oee.together.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;

public interface TogetherService {

	List<Together> selectTogetherList(Member member);

	List<Map<String,String>> selectTogetherCategory();

//	List<Together> selectTogetherListByDongName(List<String> myDongList, RowBounds rowBounds);
	List<Together> selectTogetherListByDongName(Map<String, Object> param, RowBounds rowBounds);

	Together selectTogetherByNo(int no);

	int insertTogether(TogetherEntity together);

	int togetherDelete(int no);

	int togetherUpdate(TogetherEntity together);

	int togetherStatusUpdate(int no);

	int getTogetherTotalCount(Map<String, Object> param);

}
