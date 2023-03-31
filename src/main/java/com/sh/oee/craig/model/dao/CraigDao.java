package com.sh.oee.craig.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigPage;

@Mapper
public interface CraigDao {


	//카테고리로 검색 
	List<Craig> craigList(Map<String, Object> param, RowBounds rowBounds);

	@Select("select * from craig_category")
	List<Map<String, String>> craigCategoryList();

	//craig 게시판에 등록
	int insertCraigBoard(Craig craig);

	//craig attachment등록
	int insertCraigAttachment(CraigAttachment attach);

	//craig 조인
	Craig selectcraigOne(int no);

	@Select("select CATEGORY_NAME from craig_category where category_no = #{categoryNo}")
	String selectMyCraigCategory(int categoryNo);

	
	//update
	int updateCraigBoard(Craig craig);

	int updateCraigAttachment(CraigAttachment attach);

	@Delete("delete from craig_attachment where attach_no = #{orifileattno}")
	int deleteCraigAttachment(int orifileattno);

	//in up
	int upinsertCraigAttachment(CraigAttachment attach);

	
	//select all
	List<CraigAttachment> selectcraigAttachments(int no);


	//-----------------------하나시작------------------------
	List<Craig> myBuyCraig(String memberId);
	List<Craig> mySalCraig(String memberId);
	List<Craig> mySalFCraig(String memberId);
	List<Craig> myWishCraig(String memberId);
	@Update("update craig set state = 'CR3' where no = #{no}")
	int salFCraig(int no);
	@Update("update craig set state = 'CR1' where no = #{no}")
	int bookCraig(int no);
	@Update("update craig set state = 'CR2' where no = #{no}")
	int salCraig(int no);
	//-----------------------하나끝------------------------

	@Delete("delete from craig where no = #{no}")
	int deleteCraigBoard(int no);

	@Delete("delete from craig_attachment where craig_no = #{no}")
	int deleteCraigBoardAttachment(int no);

	//
	int craigReadCount(int no);

	
	// content총수 구하기
	int getContentCnt(Map<String, Object> param);
	
	// 🐹 ------- 효정 start ---------- 🐹
	@Select("select * from craig where no = #{craigNo}")
	Craig findCraigByCraigNo(int craigNo);
	// 🐹 --------- 효정 end ---------- 🐹	


	//wish
	int selectCraigWish(Map<String, Object> param);

	@Delete("delete from craig_wish where craig_no = #{no} and member_id = #{memberId}")
	int DeleteCraigWish(Map<String, Object> param);

	@Insert("insert into CRAIG_WISH values(seq_CRAIG_WISH_no.nextval, #{no},  #{memberId}, default)")
	int InsertCraigWish(Map<String, Object> param);

	@Select("select count(*) from craig_wish where craig_no = #{no}")
	int selectCraigWishOne(int no);

	//새로 wishcount 총수구하기 (걍 조회 + 카테고리 조회 +검색조회 )
	List<Integer> selectCraigWishCnt(Map<String, Object> param);



	

}
