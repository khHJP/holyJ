package com.sh.oee.together.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dao.TogetherDao;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;

@Service
@Transactional(rollbackFor = Exception.class)
public class TogetherServiceImpl implements TogetherService {

	@Autowired
	private TogetherDao togetherDao;

	@Override
	public List<Together> selectTogetherList(Member member) {
		return togetherDao.selectTogetherList(member);
	}
	
	@Override
	public List<Map<String,String>> selectTogetherCategory() {
		return togetherDao.selectTogetherCategory();
	}

	@Override
	public List<Together> selectTogetherListByDongName(List<String> myDongList) {
		return togetherDao.selectTogetherListByDongName(myDongList);
	}

	@Override
	public Together selectTogetherByNo(int no) {
		return togetherDao.selectTogetherByNo(no);
	}

	@Override
	public int insertTogether(TogetherEntity together) {
		// 같이해요 게시글 등록
		int result = togetherDao.insertTogether(together);
		// 같이해요 채팅방 생성..?
		Map<String, Object> param = new HashMap<>();
		param.put("togetherNo", together.getNo());
		param.put("memberId", together.getWriter());
		param.put("role", 'A');
		insertTogetherChat(param);
		
		return result;
	}
	
	private int insertTogetherChat(Map<String, Object> param) {
		return togetherDao.insertTogetherChat(param);
	}

	@Override
	public int togetherDelete(int no) {
		return togetherDao.togetherDelete(no);
	}

	@Override
	public int togetherUpdate(TogetherEntity together) {
		return togetherDao.togetherUpdate(together);
	}
	
	
	
}
