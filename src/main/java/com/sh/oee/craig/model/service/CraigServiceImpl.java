package com.sh.oee.craig.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sh.oee.craig.model.dao.CraigDao;
import com.sh.oee.craig.model.dto.Craig;
import com.sh.oee.craig.model.dto.CraigAttachment;
import com.sh.oee.craig.model.dto.CraigPage;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)
@Slf4j
@Service
public class CraigServiceImpl implements CraigService {

	
	@Autowired
	private CraigDao craigDao;

	//새로운 list뽑기 메서드 - no검색버전 - 잘되면이걸로쓰기 
	@Override
	public List<Craig> craigList(Map<String, Object> param, RowBounds rowBounds) {
		return craigDao.craigList(param, rowBounds);
	}

	//카테고리 목록조회 
	@Override
	public List<Map<String, String>> craigCategoryList() {
		return craigDao.craigCategoryList();
	}


	//게시글등록
	@Override
	public int insertCraigBoard(Craig craig) {
		//글만등록 
		int result =  craigDao.insertCraigBoard(craig);
		log.debug("■ craig no = {}", craig.getNo());
		
		//첨부파일등록
		List<CraigAttachment> attachments = craig.getAttachments();
		if(attachments.size() > 0) {
			for(CraigAttachment attach : attachments) {
				attach.setCraigNo(craig.getNo());
				result = insertCraigAttachment(attach);
			}	
		}
		return result;
	}

	//첨부파일등록
	@Override
	public int insertCraigAttachment(CraigAttachment attach) {
		return craigDao.insertCraigAttachment(attach);
	}

	
	//select one 게시글 
	@Override
	public Craig selectcraigOne(int no, boolean hasRead) {
	//	boolean hasRead = (boolean) param.get("hasRead");
	//	int no = (int) param.get("no");
		
		if(!hasRead) craigReadCount(no);
		log.debug("■ selectcraigOne - impl - no = {}", no);
		
		return craigDao.selectcraigOne( no );
	}

	//select one 카테고리
	@Override
	public String selectMyCraigCategory(int categoryNo) {
		return craigDao.selectMyCraigCategory(categoryNo);
	}

	
	//update 
	@Override
	public int updateCraigBoard(Craig craig) {
		//글만등록 
		int result =  craigDao.updateCraigBoard(craig);
		log.debug("■ craig no = {}", craig.getNo());
		
		//첨부파일등록
		List<CraigAttachment> attachments = craig.getAttachments();
		log.debug("■ 멀티플은 없는데 이게 찍힌다고 ? attachments = {}", attachments);
		
		
		if(attachments.size() > 0 ) {
	
			for(CraigAttachment attach : attachments) {
				
				attach.setCraigNo(craig.getNo());
				result = upinsertCraigAttachment(attach);
			}	
		}
		return result;
	}


	
	
	private int upinsertCraigAttachment(CraigAttachment attach) {
		// TODO Auto-generated method stub
		return  craigDao.upinsertCraigAttachment(attach);
	}

	//update - attachment 
	private int updateCraigAttachment(CraigAttachment attach) {
		return craigDao.updateCraigAttachment(attach);
	}

	
	//delete - attachment 
	@Override
	public int deleteCraigAttachment(int orifileattno) {
		return craigDao.deleteCraigAttachment( orifileattno);
	}

	@Override
	public List<CraigAttachment> selectcraigAttachments(int no) {
		return craigDao.selectcraigAttachments(no);
	}
//-------------------------- 하나 시작 --------------------------------------
	@Override
	public List<Craig> myBuyCraig(String memberId) {
		// TODO Auto-generated method stub
		return craigDao.myBuyCraig(memberId);
	}
	@Override
	public List<Craig> mySalCraig(String memberId) {
		// TODO Auto-generated method stub
		return craigDao.mySalCraig(memberId);
	}
	
	@Override
	public List<Craig> mySalFCraig(String memberId) {
		// TODO Auto-generated method stub
		return craigDao.mySalFCraig(memberId);
	}
	@Override
	public List<Craig> myWishCraig(String memberId) {
		// TODO Auto-generated method stub
		return craigDao.myWishCraig(memberId);
	}
	@Override
	public int salFCraig(int no) {
		// TODO Auto-generated method stub
		return craigDao.salFCraig(no);
	}
	@Override
	public int bookCraig(int no) {
		// TODO Auto-generated method stub
		return craigDao.bookCraig(no);
	}
	@Override
	public int salCraig(int no) {
		// TODO Auto-generated method stub
		return craigDao.salCraig(no);
	}
//-------------------------- 하나 끝 --------------------------------------

	//게시글삭제 
	@Override
	public int deleteCraigBoard(int no) {
		//글만 삭제 
		int result = 0;
		result = craigDao.deleteCraigBoard(no);
		log.debug("■ craig no = {}", no );
		
		//첨부파일삭제
		result +=  craigDao.deleteCraigBoardAttachment(no);
		return result;
	}

	
	//조회수증가
	@Override
	public int craigReadCount(int no) {
		return craigDao.craigReadCount(no);
	}

	
	//컨텐츠 총수
	@Override
	public int getContentCnt(Map<String, Object> param ) {
		return craigDao.getContentCnt(param);
	}

	//wish
	@Override
	public int selectCraigWish(Map<String, Object> param) {
		return craigDao.selectCraigWish(param);
	}

	//wish del
	@Override
	public int DeleteCraigWish(Map<String, Object> param) {
		return craigDao.DeleteCraigWish(param);
	}

	//wish insert
	@Override
	public int InsertCraigWish(Map<String, Object> param) {
		return craigDao.InsertCraigWish(param);
	}

	//게시물 wish
	@Override
	public int selectCraigWishOne(int no) {
		return  craigDao.selectCraigWishOne(no);
	}


	// 🐹 ------- 효정 start ---------- 🐹	
	@Override
	public Craig findCraigByCraigNo(int craigNo) {
		return craigDao.findCraigByCraigNo(craigNo);
	}
	// 🐹 --------- 효정 end ---------- 🐹	

	

	
	//새로 wishcount 총수구하기 (걍 조회 + 카테고리 조회 +검색조회 )
	@Override
	public List<Integer> selectCraigWishCnt(Map<String, Object> param) {
		return craigDao.selectCraigWishCnt(param);
	}







}

	
		
		
