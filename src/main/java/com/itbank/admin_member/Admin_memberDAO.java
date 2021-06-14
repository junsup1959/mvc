package com.itbank.admin_member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface Admin_memberDAO {

	@Insert("insert into admin_member values("
			+ "to_char(sysdate,'yyyy') || to_char(admin_seq.nextval,'FM000')"
			+ ",#{admin_name}"
			+ ",#{admin_password}"
			+ ",#{admin_phone}"
			+ ",#{admin_addr}"
			+ ",#{admin_store}"
			+ ",#{admin_jday}"
			+ ",#{admin_dept}"
			+ ",'n')")
	int insert(Admin_memberDTO dto);

	@Select("select * from admin_member")
	List<Admin_memberDTO> selectAll();

	@Select("select * from admin_member where admin_num = #{admin_num}and admin_password = #{admin_password}")
	Admin_memberDTO login(Admin_memberDTO dto);

	
}
