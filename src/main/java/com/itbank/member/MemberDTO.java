package com.itbank.member;

//	   member_number    number primary key,
//	    member_email     varchar2(50) unique not null,
//	    member_name      varchar2(20) not null,
//	    member_password  varchar2(300) not null,
//	    member_phone     varchar2(20) not null,
//	    member_addr      varchar2(150) not null,
//	    member_gender    char(1) check(member_gender in ('M','F')),
//	    member_nick      varchar2(20) not null unique,
//	    member_deleted   char(1) DEFAULT 'n' CHECK(member_deleted in ('y', 'n'))

public class MemberDTO {

	private String member_number;
	private String member_email, member_name, member_password, member_phone, member_addr, member_gender, member_nick, member_deleted;
	private String member_addr1, member_addr2;

	
	public String getMember_number() {
		return member_number;
	}
	public void setMember_number(String member_number) {
		this.member_number = member_number;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_password() {
		return member_password;
	}
	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_addr() {
		if(member_addr1 != null) {
			return member_addr1 + member_addr2;
		}
		return member_addr;
	}
	public void setMember_addr(String member_addr) {
		this.member_addr = member_addr;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public String getMember_deleted() {
		return member_deleted;
	}
	public void setMember_deleted(String member_deleted) {
		this.member_deleted = member_deleted;
	}
	public String getMember_addr1() {
		return member_addr1;
	}
	public void setMember_addr1(String member_addr1) {
		this.member_addr1 = member_addr1;
	}
	public String getMember_addr2() {
		return member_addr2;
	}
	public void setMember_addr2(String member_addr2) {
		this.member_addr2 = member_addr2;
	}
	
	
	
}
