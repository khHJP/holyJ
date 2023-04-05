package com.sh.oee.local.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sh.oee.local.model.dto.Local;

import com.sh.oee.local.model.dto.LocalAttachment;
import com.sh.oee.local.model.dto.LocalComment;
import com.sh.oee.local.model.dto.LocalCommentEntity;
import com.sh.oee.local.model.dto.LocalEntity;
import com.sh.oee.local.model.dto.LocalLike;
import com.sh.oee.member.model.dto.Member;


@Mapper
public interface LocalDao {
	

	//동네생활 전체목록
	List<Local> selectLocalListByDongName(Map<String, Object> param, RowBounds rowBounds);
	
	//카테고리
	@Select("select * from local_category")
	List<Map<String, String>> localCategoryList();

	//게시판 글등록
	int insertLocalBoard(Local local);
	
	int insertLocalAttachment(LocalAttachment attach);

	// ----------------------------- 하나 시작 -----------------------------------------------
	@Select("select * from local where writer = #{memberId}")
	List<Local> selectLocalList(Member member);
	
	List<LocalCommentEntity> selectLocalCommentList(String memberId);
	// ----------------------------- 하나 끝 -----------------------------------------------

	//게시글 한건 조회
	Local selectLocalOne(int no);

	//게시글 삭제
	@Delete("delete from local where no = #{no}")
	int deleteLocal(int no);
	
	//게시글 수정 첨부파일
	List<LocalAttachment> selectLocalAttachments(int no);
	
	//게시글 수정
	int updateLocalBoard(Local local);

	//조회수 증가
	int hits(int no);


	//좋아요
	int selectLocalLike(Map<String, Object> param);
	
	@Delete("delete from local_like where local_no = #{no} and member_id = #{memberId}")
	int DeleteLocalLike(Map<String, Object> param);

	@Insert("insert into LOCAL_LIKE values(seq_like_no.nextval, #{memberId},#{no}, default)")
	int InsertLocalLike(Map<String, Object> param);

	
	@Delete("delete from local_attachment where local_no = #{no}")
	int deleteLocalAttachment(int no);

	
	

	int selectAttachNo(int no);

	int updateAttachFile(LocalAttachment attach);

	int getLocalTotalCount(Map<String, Object> param);

	//댓글
	int insertComment(LocalCommentEntity comment);

	List<LocalCommentEntity> commentList(int no,String orderBy);

	//댓글삭제
	@Delete("delete from local_comment where comment_no = #{commentNo}")
	int deleteComment(int no);
	
	//댓글 수정
	int updateComment(LocalComment comment);

	int insertReComment(LocalCommentEntity comment);

	//댓글 최신순
	List<LocalCommentEntity> commentNewList(int no);
}
