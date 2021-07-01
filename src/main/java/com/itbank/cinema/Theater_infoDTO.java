package com.itbank.cinema;


//상영관 코드	screen_code	varchar2(20)
//상영 영화코드	movie_code	varchar2(15)
//상영 title	movie_title	varchar2(30)
//상영일시(상영시작)	start_date	varchar2(30)
//상영일시(상영끝)	end_date	varchar2(30)
//start_time
//end_time
//상영시간	runtime	number
//2d 3d	movie_type	char(1)
//관람등급	movie_audit	varchar2(25)


public class Theater_infoDTO {
	private String screen_code, movie_code, movie_title, start_date, end_date, movie_type, start_time, end_time, movie_audit, seat_amount;
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	private int runtime;
	public String getScreen_code() {
		return screen_code;
	}
	public void setScreen_code(String screen_code) {
		this.screen_code = screen_code;
	}
	public String getMovie_code() {
		return movie_code;
	}
	public void setMovie_code(String movie_code) {
		this.movie_code = movie_code;
	}
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getMovie_type() {
		return movie_type;
	}
	public void setMovie_type(String movie_type) {
		this.movie_type = movie_type;
	}
	public int getRuntime() {
		return runtime;
	}
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
	public String getMovie_audit() {
		return movie_audit;
	}
	public void setMovie_audit(String movie_audit) {
		this.movie_audit = movie_audit;
	}
	public String getSeat_amount() {
		return seat_amount;
	}
	public void setSeat_amount(String seat_amount) {
		this.seat_amount = seat_amount;
	}
	
	
	
}
