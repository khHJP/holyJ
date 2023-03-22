package com.sh.oee.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.oee.member.model.dto.Dong;
import com.sh.oee.member.model.dto.Gu;
import com.sh.oee.member.model.dto.DongRange;
import com.sh.oee.member.model.dto.Member;

@Mapper
public interface MemberDao {

	/** 정은 시작 */
	Member selectOneMember(String memberId);

	@Select("select * from gu")
	List<Gu> selectGuList();
	
	@Select("select * from dong")
	List<Dong> selectDongList();

	/** 정은 끝 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * //혜진도전 0320 String[] selectDongNearNames(int dongNo);
	 */
	












		
	List<DongRange> selectDongNearNames(int dongNo);

	String selectDongNearOnly(int dongNo);

	String selectDongNearFar(int dongNo);

	String selectMydongName(int dongNo);

	
}
