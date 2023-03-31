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
	//List<Craig> craigList(List<String> dongList, RowBounds rowBounds );

	
	//새로운 list뽑기 메서드 -1)걍 리스트뽑기 2)no검색+카테고리버전 3)검색 
	List<Craig> craigList(Map<String, Object> param, RowBounds rowBounds);
	
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
	List<Craig> mySalCraig(String memberId);
	List<Craig> mySalFCraig(String memberId);
	List<Craig> myWishCraig(String memberId);
	int salFCraig(int no);
	int bookCraig(int no);
	int salCraig(int no);
	//---------------------하나 끝-------------------------
	
	//게시글 + 첨부파일 삭제 - ok
	int deleteCraigBoard(int no);

	
	//조회수증가 - 보류 0325
	int craigReadCount(int no);

	
	//컨텐츠총수 나오게 
	int getContentCnt(Map<String, Object> param  );


	//wish 조회 
	int selectCraigWish(Map<String, Object> param);

	
	//wish delete 
	int DeleteCraigWish(Map<String, Object> param);

	//wish insert 
	int InsertCraigWish(Map<String, Object> param);


	// 게시물 wish
	int selectCraigWishOne(int no);

	
	
	
	
	// 🐹 ------- 효정 start ---------- 🐹	
	Craig findCraigByCraigNo(int craigNo);
	// 🐹 --------- 효정 end ---------- 🐹	

	//새로 wishcount 총수구하기 (걍 조회 + 카테고리 조회 +검색조회 )
	List<Integer> selectCraigWishCnt(Map<String, Object> param);








}
