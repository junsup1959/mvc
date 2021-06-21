package com.itbank.admin_board;

import java.util.HashMap;
import java.util.List;

public interface CoboardDAO {

	List<CoboardDTO> clist(HashMap<String, Object> param);

	int cboardCount();

	CoboardDTO cselectOne(int co_idx);

	CoboardDTO cnext(int co_idx);

	CoboardDTO cprev(int co_idx);

	int cupdate(CoboardDTO dto);

	int cinsert(CoboardDTO dto);

	int cdelete(int co_idx);

}
