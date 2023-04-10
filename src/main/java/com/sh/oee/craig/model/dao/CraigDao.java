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


	//■ 카테고리로 검색 
	List<Craig> craigList(Map<String, Object> param, RowBounds rowBounds);

	@Select("select * from craig_category")
	List<Map<String, String>> craigCategoryList();

	//craig 게시판에 등록
	int insertCraigBoard(Craig craig);

	//craig attachment등록
	int insertCraigAttachment(CraigAttachment attach);

	@Select("select CATEGORY_NAME from craig_category where category_no = #{categoryNo}")
	String selectMyCraigCategory(int categoryNo);

	//update
	int updateCraigBoard(Craig craig);

	//delete
	@Delete("delete from craig_attachment where attach_no = #{orifileattno}")
	int deleteCraigAttachment(int orifileattno);

	//in up
	int upinsertCraigAttachment(CraigAttachment attach);

	//select all
	List<CraigAttachment> selectcraigAttachments(int no);

	@Delete("delete from craig where no = #{no}")
	int deleteCraigBoard(int no);

	@Delete("delete from craig_attachment where craig_no = #{no}")
	int deleteCraigBoardAttachment(int no);

	// 조회수 증가시키기 
	int craigReadCount(int no);
	
	// content총수 구하기 (걍 조회 + 카테고리 조회 +검색조회 )
	int getContentCnt(Map<String, Object> param);
	
	// 새로 wishcount 총수구하기 (걍 조회 + 카테고리 조회 +검색조회 )
	List<Integer> selectCraigWishCnt(Map<String, Object> param, RowBounds rowBounds);

	// wish 한게시물
	int selectCraigWish(Map<String, Object> param);
	
	@Delete("delete from craig_wish where craig_no = #{no} and member_id = #{memberId}")
	int DeleteCraigWish(Map<String, Object> param);

	@Insert("insert into CRAIG_WISH values(seq_CRAIG_WISH_no.nextval, #{no},  #{memberId}, default)")
	int InsertCraigWish(Map<String, Object> param);

	@Select("select count(*) from craig_wish where craig_no = #{no}")
	int selectCraigWishOne(int no);

	@Select("select floor(count(*)/2)   From craig_chat where craig_no = #{no} and del_date is null")
	int selectCraigChrooms(int no);

	//게시물 리스트 - chatroomcount
	List<Integer> selectCraigChatCnt(Map<String, Object> param, RowBounds rowBounds);

	//조회수 증가시키기가 추가된 게시글 상세보기 
	Craig selectcraigOneRe(Map<String, Object> nhparam);

	//상품+2
	List<Craig> selectOtherCraigs(Map<String, Object> otherParam);

	//나채팅방 찾아
	int findmeFromChat(Map<String, Object> param);

	
// ================================ 혜진 ================================
	
	
	
	
	//-----------------------하나시작------------------------
	List<Craig> myBuyCraig(String memberId);
	List<Craig> mySalCraig(String memberId);
	List<Craig> mySalCraig1(String memberId);
	List<Craig> mySalFCraig(String memberId);
	List<Craig> myWishCraig(String memberId);
	@Update("update craig set state = 'CR3', complete_date = sysdate where no = #{no}")
	int salFCraig(int no);
	@Update("update craig set state = 'CR2' where no = #{no}")
	int salCraig(int no);
	//-----------------------하나끝------------------------

	
	
	// 🐹 ------- 효정 start ---------- 🐹
	@Select("select * from craig where no = #{craigNo}")
	Craig findCraigByCraigNo(int craigNo);
	
	@Update("update craig set state = 'CR1', buyer = #{buyer} where no = #{no}")
	int updateCraigMeeting(Map<String, Object> map);
	// 🐹 --------- 효정 end ---------- 🐹	







	

}
