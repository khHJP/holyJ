package com.sh.oee.craig.model.dto;

import java.time.LocalDateTime;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CraigEntity {
	private int no;
	private int categoryNo;
	private String writer;
	private String title;
	private String content;
	private LocalDateTime regDate;
	private double latitude;
	private double longitude;
	private String placeDetail;
	private int price;
	private int hits; //조회수
	private State state; // default - 'CR2' |  예약중/판매중/판매완료
	private String buyer;
	private LocalDateTime completeDate;
	
}

/**
create table CRAIG (
	no number,
	category_no number not null,
	writer varchar2(30) not null,
	title varchar2(200) not null,
	content varchar2(3000) not null,
	reg_date date default sysdate,
	latitude number not null,
	longitude number not null,
	place_detail varchar2(50) not null,
	price number not null,
	hits number default 0, --조회수
	state varchar2(10) default 'CR2', -- 예약중/판매중/판매완료
	buyer varchar2(30),
	complete_date date,
	constraint pk_craig_no primary key(no),
	constraint fk_craig_category_no foreign key (category_no) references craig_category(category_no) on delete set null,
	constraint fk_craig_writer foreign key (writer) references member(member_id),
	constraint ck_craig_state check (state in ('CR1', 'CR2', 'CR3'))
);
**/
