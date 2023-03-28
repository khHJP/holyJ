package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigEntity;
import com.sh.oee.craig.model.dto.CraigPage;

public interface CraigService {

	// 전체목록조회 
	List<Craig> craigList(List<String> dongList, RowBounds rowBounds );

	// 카테고리 목록 조회 
	List<Map<String, String>> craigCategoryList();

	// 게시글등록
	int insertCraigBoard(Craig craig);
	
	//첨부파일등록
	int insertCraigAttachment(CraigAttachment attach);

	//게시글+첨부파일 함께 조회 
	Craig selectcraigOne(int no, boolean hasRead);

	
	//내카테
	String selectMyCraigCategory(int categoryNo);

	//update -사실은 insert도같이 
	int updateCraigBoard(Craig craig);

	
	//delete 원래 첨부파일
	int deleteCraigAttachment(int orifileattno);

	//첨부파일 조회 
	List<CraigAttachment> selectcraigAttachments(int no);


	//---------------------하나 시작------------------------
	List<Craig> myBuyCraig(String memberId);
	//---------------------하나 끝-------------------------
	
	//게시글 + 첨부파일 삭제 - ok
	int deleteCraigBoard(int no);

	
	//조회수증가 - 보류 0325
	int craigReadCount(int no);

	
	//페이지 나오게 
	int getContentCnt(List<String> dongList );


	//wish 조회 
	int selectCraigWish(Map<String, Object> param);

	
	//wish delete 
	int DeleteCraigWish(Map<String, Object> param);

	//wish insert 
	int InsertCraigWish(Map<String, Object> param);


	// 게시물 wish
	int selectCraigWishOne(int no);

	//리스트에 쓸 wishCnt
	List<Integer> selectCraigWishCnt(List<String> dongList);
	
	
	
	// 🐹 ------- 효정 start ---------- 🐹	
	Craig findCraigByCraigNo(int craigNo);
	// 🐹 --------- 효정 end ---------- 🐹	



}
