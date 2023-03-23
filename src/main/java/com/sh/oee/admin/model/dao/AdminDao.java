package com.sh.oee.admin.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.oee.member.model.dto.Member;

@Mapper
public interface AdminDao {

	List<Member> selectAdminList();

	List<Member> selectAdminMemberList();

}
