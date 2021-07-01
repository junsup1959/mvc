package com.itbank.revervation;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ReservDAO {

	@Insert("insert into reservation(imp_uid,"
			+ "branchcode,"
			+ "start_date,"
			+ "movie_code,"
			+ "member_email,"
			+ "member_name,"
			+ "merchant_uid,"
			+ "pay,"
			+ "member_age,"
			+ "reserv_num"
			+ ",seatNum)"
			
			+ "values("
			+ "#{imp_uid}"
			+ ",#{branchcode}"
			+ ",#{start_date}"
			+ ",#{movie_code}"
			+ ",#{member_email}"
			+ ",#{member_name}"
			+ ",#{merchant_uid}"
			+ ",#{pay}"
			+ ",#{member_age}"
			+ ",#{reserv_num}"
			+ ",#{seatNum})")
	int insert(ReservDTO dto);

	@Select("select * from reservation where member_email=#{member_email} and deleted='n'")
	List<ReservDTO> selectlist(String member_email);

	@Update("update reservation set deleted='y' where member_email=#{member_email} and imp_uid=#{imp_uid} and merchant_uid =#{merchant_uid}")
	int delete(HashMap<String, Object> param);

	@Select("select seatNum from reservation where branchcode = #{branch} and movie_code=#{movie} and start_date=#{day}")
	List<ReservDTO> selectSeatNum(HashMap<String, Object> param);

}
