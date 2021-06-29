package com.itbank.revervation;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ReservDAO {

	@Insert("insert into reservation(imp_uid,branchcode,start_date,movie_code,member_email,member_name,merchant_uid,pay,member_age,reserv_num)"
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
			+ ",#{reserv_num})")
	int insert(ReservDTO dto);

	@Select("select * from reservation where member_email=#{member_email} and deleted='n'")
	List<ReservDTO> selectlist(String member_email);

	@Update("update reservation set deleted='y' where member_email=#{member_email} and imp_uid=#{imp_uid} and merchant_uid =#{merchant_uid}")
	int delete(HashMap<String, Object> param);

}
