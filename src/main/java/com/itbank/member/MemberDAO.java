package com.itbank.member;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface MemberDAO {

	
	int insert(MemberDTO member);

	MemberDTO selectOne(MemberDTO member);
	
	MemberDTO selectOne2(MemberDTO member);

	@Select("select count(*) from member where member_email = #{member_email}")
	int select(String member_email);

	@Select("select count(*) from member where member_nick = #{member_nick}")
	int selectNick(String member_nick);

	
	@Select("select * from member where	member_email = #{member_email} and member_password = #{member_password}")
	MemberDTO doubleCheck(MemberDTO member);

	int modify(MemberDTO member);

	@Select("select * from member where member_name = #{member_name} and member_phone = #{member_phone}")
	MemberDTO findId(MemberDTO member);

	@Select("select * from member where member_name = #{member_name} and member_phone = #{member_phone} and member_email = #{member_email}")
	MemberDTO findPw(MemberDTO member);

	@Update("update member set member_password = #{member_password} where member_email = #{member_email}")
	int updatePw(MemberDTO member);

	



}
