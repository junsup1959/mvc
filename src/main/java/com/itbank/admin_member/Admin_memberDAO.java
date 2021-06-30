package com.itbank.admin_member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface Admin_memberDAO {

	@Insert("insert into admin_member values("
			+ "to_char(sysdate,'yyyy') || to_char(admin_seq.nextval,'FM000')"
			+ ",#{admin_name}"
			+ ",1234"
			+ ",#{admin_phone}"
			+ ",#{admin_addr}"
			+ ",#{admin_store}"
			+ ",#{admin_jday}"
			+ ",#{admin_dept}"
			+ ",'n'"
			+ ",null)")
	int insert(Admin_memberDTO dto);

	@Select("select * from admin_member order by admin_num desc offset ${offset} rows fetch first ${perpage} rows only")
	List<Admin_memberDTO> selectAll(HashMap<String, Object> param);

	@Select("select * from admin_member where admin_num = #{admin_num} and admin_password = #{admin_password} and deleted='n'")
	Admin_memberDTO login(Admin_memberDTO dto);

	@Select("select * from admin_member where admin_num = #{admin_num}")
	Admin_memberDTO selectOne(String admin_num);

	@Update("update admin_member set "
			+ "admin_name=#{admin_name}, admin_phone = #{admin_phone}, "
			+ "admin_addr= #{admin_addr}, admin_store = #{admin_store},admin_jday=#{admin_jday}, "
			+ "admin_dept = #{admin_dept}, admin_lday=#{admin_lday}, deleted=#{deleted} "
			+ "where admin_num=#{admin_num}")
	int adminMemberUpdate(Admin_memberDTO dto);

	@Select("select count(*) from admin_member")
	int adminCount();

	@Update("update admin_member "
			+ "set admin_password = #{admin_password} "
			+ "where admin_num = #{admin_num}")
	int changePw(Admin_memberDTO dto);

	
}
