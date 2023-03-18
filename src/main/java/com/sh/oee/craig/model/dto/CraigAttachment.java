package com.sh.oee.craig.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CraigAttachment {
	private int attachNo;
	private int craigNo;
	private String originalFilename;
	private String reFilename;
	private LocalDateTime regDate;
	
}

/**
create table CRAIG_ATTACHMENT (
attach_no number,
craig_no number not null,
original_filename varchar2(500),
re_filename varchar2(500),
reg_date date default sysdate,
constraint pk_craig_attach_no primary key (attach_no),
constraint fk_craig_attach_craig_no foreign key (craig_no) references craig(no) on delete cascade -- 중고거래 게시글 삭제시 첨부파일 삭제
);
**/
