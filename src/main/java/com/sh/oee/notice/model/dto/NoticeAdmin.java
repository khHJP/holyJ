package com.sh.oee.notice.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeAdmin {
    private int no;
    private String msg;
    private Date regDate;
}
