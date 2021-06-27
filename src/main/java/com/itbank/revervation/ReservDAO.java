package com.itbank.revervation;

import org.apache.ibatis.annotations.Insert;

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
			+ "#{reserv_num})")
	int insert(ReservDTO dto);

}
