package com.sh.oee.notice.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
<<<<<<< HEAD
	private int no;
	private String memberId;
	private String msg;
	private Type type;
	private LocalDateTime regDate;
	private String readYN;
=======
    private int no;
    private String memberId;
    private String msg;
    private Type type;
    private LocalDateTime regDate;
    private String readYN; // Y/N
>>>>>>> branch 'master' of https://github.com/khHJP/holyJ.git
}
