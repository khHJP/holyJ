package com.sh.oee.manner.model.service;

import java.util.List;

import com.sh.oee.manner.model.dto.Manner;

public interface MannerService {

	List<Manner> selectMannerList(String memberId);

}
