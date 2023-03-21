package com.sh.oee.member.model.dto;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member implements UserDetails {
	
	private static final long serialVersionUID = 1L;
	
	@NonNull
	private String memberId;
	@NonNull
	private String password;
	@NonNull
	private String nickname;
	@NonNull
	private String phone;
	private double manner;
	private String profileImg;
	private int dongNo;
	@NonNull
	private DongRangeEnum dongRange;
	private int reportCnt;
	private LocalDateTime enrollDate;
	private LocalDateTime deleteDate;
	private boolean enabled;
	
	// 권한 목록
	List<SimpleGrantedAuthority> authorities;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}
	@Override
	public String getUsername() {
		return this.memberId;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return true;
	}
	
}
