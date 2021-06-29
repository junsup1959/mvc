package com.itbank.revervation;

public class ReservDTO {
	private String imp_uid,branchcode,start_date,movie_code,wdate;
	private String member_email,member_name,merchant_uid,pay,member_age,reserv_num,deleted;
	private int adult,youth,ct;
	
	public void countAYC(String member_age){
		String[] List = member_age.split(",");
		adult = Integer.valueOf(List[0]);
		youth = Integer.valueOf(List[1]);
		ct = Integer.valueOf(List[2]);
	}
	
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getBranchcode() {
		return branchcode;
	}
	public void setBranchcode(String branchcode) {
		this.branchcode = branchcode;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getMovie_code() {
		return movie_code;
	}
	public void setMovie_code(String movie_code) {
		this.movie_code = movie_code;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getPay() {
		return pay;
	}
	public void setPay(String pay) {
		this.pay = pay;
	}
	public String getMember_age() {
		return member_age;
	}
	public void setMember_age(String member_age) {
		this.member_age = member_age;
	}
	public String getReserv_num() {
		return reserv_num;
	}
	public void setReserv_num(String reserv_num) {
		this.reserv_num = reserv_num;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getYouth() {
		return youth;
	}
	public void setYouth(int youth) {
		this.youth = youth;
	}
	public int getCt() {
		return ct;
	}
	public void setCt(int ct) {
		this.ct = ct;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
}
