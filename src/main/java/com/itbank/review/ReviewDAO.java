package com.itbank.review;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface ReviewDAO {

	@Insert("insert into review(idx,writer,movie_title,movie_code,content) "
			+ "values(review_seq.nextval,#{writer},#{movie_title},#{movie_code},#{content})")
	int insert(ReviewDTO dto);

	@Select("select * from review where movie_code=#{moviecode}")
	List<ReviewDTO> selectAll(int moviecode);

}
