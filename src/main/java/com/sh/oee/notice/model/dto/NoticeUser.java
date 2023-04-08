package com.sh.oee.notice.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeUser {
    private int no;
    private String memberId;
    private String msg;
    private Type type;
    private LocalDateTime regDate;
    private String readYN; // Y/N
}
