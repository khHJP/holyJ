package com.sh.oee.together.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.sh.oee.member.model.dto.Member;
import com.sh.oee.together.model.dto.Together;
import com.sh.oee.together.model.dto.TogetherEntity;

@Mapper
public interface TogetherDao {

	List<Together> selectTogetherList(Member member);
	
	List<TogetherEntity> selectTogetherList(String memberId);
	
	@Select("select * from together_category")
	List<Map<String,String>> selectTogetherCategory();

	List<Together> selectTogetherListByDongName(List<String> myDongList, RowBounds rowBounds);

	Together selectTogetherByNo(int no);

	int insertTogether(TogetherEntity together);

	int insertTogetherChat(Map<String, Object> param);

	@Delete("delete together where no = #{no}")
	int togetherDelete(int no);

	int togetherUpdate(TogetherEntity together);

	@Update("update together set status = 'N' where no = #{no}")
	int togetherStatusUpdate(int no);

	int getTogetherTotalCount(List<String> myDongList);

}
