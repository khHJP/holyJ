package com.sh.oee.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import com.sh.oee.member.model.dto.Member;

public class OeeUtils {
	/**
	 * yyyyMMdd_HHmmssSSS_123.jpg
	 *
	 * @param upFile
	 * @return
	 */
	public static String renameMultipartFile(MultipartFile upFile) {
		String originalFilename = upFile.getOriginalFilename();
		String ext = ""; // 확장자
		int beginIndex = originalFilename.lastIndexOf(".");
		if (beginIndex > -1)
			ext = originalFilename.substring(beginIndex); // . jpg 확장자 가져옴 
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS"); // ss 초, SSS 밀리초
		DecimalFormat df = new DecimalFormat("000"); // 022 001
		
		return sdf.format(new Date()) + df.format(Math.random() * 1000) + ext;
	}
	
	public static String idMultipartFile(MultipartFile upFile,Authentication authentication) {
		String memberId = ((Member)authentication.getPrincipal()).getMemberId();
		String originalFilename = upFile.getOriginalFilename();
		String ext = ""; // 확장자
		int beginIndex = originalFilename.lastIndexOf(".");
		if (beginIndex > -1)
			ext = originalFilename.substring(beginIndex); // . jpg 확장자 가져옴 		
		
		return memberId + ext;
	}
	
	
	//혜진추가
	public static String convertLineFeedToBr(String str) {
		return str.replaceAll("\n", "<br/>");
	}
	
	public static String escapeHtml(String str) {
		return str.replaceAll("<","&lt;").replaceAll(">", "&gt;");
	}
	
	
}
