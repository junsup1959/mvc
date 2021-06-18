package com.itbank.admin_board;

import java.util.HashMap;
import java.util.List;

public interface CoboardDAO {

	List<CoboardDTO> clist(HashMap<String, Object> param);

	int cboardCount();

	CoboardDTO cselectOne(int board_number);

	CoboardDTO cnext(int board_number);

	CoboardDTO cprev(int board_number);

	int cupdate(CoboardDTO dto);

}
