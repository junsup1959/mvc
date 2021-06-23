package com.itbank.member;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface MemberDAO {

	
	int insert(MemberDTO member);

	MemberDTO selectOne(MemberDTO member);
	
	MemberDTO selectOne2(MemberDTO member);

	@Select("select count(*) from member where member_email = #{member_email} and member_password = #{member_password}")
	int selectOne3(MemberDTO dto);
	
	@Select("select * from member where member_number = #{member_number}")
	MemberDTO selectOne4(String member_number);
	
	@Select("select count(*) from member where member_email = #{member_email}")
	int select(String member_email);

	@Select("select count(*) from member where member_nick = #{member_nick}")
	int selectNick(String member_nick);

	
	@Select("select * from member where	member_email = #{member_email} and member_password = #{member_password}")
	MemberDTO doubleCheck(MemberDTO member);

	int modify(MemberDTO member);
	
	int modifyPw(MemberDTO member);

	@Select("select * from member where member_name = #{member_name} and member_phone = #{member_phone}")
	MemberDTO findId(MemberDTO member);

	@Select("select * from member where member_name = #{member_name} and member_phone = #{member_phone} and member_email = #{member_email}")
	MemberDTO findPw(MemberDTO member);

	@Update("update member set member_password = #{member_password} where member_email = #{member_email}")
	int updatePw(MemberDTO member);

	@Delete("delete from member where member_email = #{member_email} and member_password = #{member_password}")
	int deleteMember(MemberDTO member);

	@Select("select count(*) from member")
	int memberCount();

	List<MemberDTO> customerDateList(HashMap<String, Object> param);

	List<MemberDTO> customerGradeList(HashMap<String, Object> param);

	List<MemberDTO> customerThisList(HashMap<String, Object> param);

	List<MemberDTO> customerLastList(HashMap<String, Object> param);

	List<MemberDTO> customerDeletedList(HashMap<String, Object> param);

	List<MemberDTO> listAll();

	List<MemberDTO> list(String listType);

	int insertDelMember(MemberDTO member_del);





	



}
