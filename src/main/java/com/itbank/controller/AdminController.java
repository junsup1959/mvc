package com.itbank.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.admin_board.Paging;
import com.itbank.admin_board.boardDTO;
import com.itbank.admin_member.Admin_memberDTO;
import com.itbank.member.MemberDTO;
import com.itbank.service.AdminService;
import com.itbank.service.BoardSerivce;
import com.itbank.service.CinemaService;
import com.itbank.service.MemberService;
import com.itbank.theater.TheaterDTO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired private AdminService as; 
	@Autowired private BoardSerivce bs;
	@Autowired private MemberService ms;
	@Autowired private CinemaService cs;
	
	private ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping({"", "/"})
	public String admin(HttpSession session) {
		return "admin/admin_main";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/admin_login";
	}
	
	@PostMapping("/login")
	public ModelAndView login(Admin_memberDTO dto, HttpSession session) {
	
		
		String viewName = "redirect:/admin";
		Admin_memberDTO ad_login = as.login(dto);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ad_login != null ? viewName : "msg");
		
		if(ad_login == null) {
			mav.addObject("msg", "로그인 실패");
		}
		
		session.setAttribute("ad_login", ad_login );
		session.setMaxInactiveInterval(60*60);
		return mav;
	}	
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin";
	}
	
	@GetMapping("/adminMypage")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("ad_login") == null) {
			mav.setViewName("msg");
			mav.addObject("msg","잘못된 접근입니다");
		}
		mav.setViewName("admin/admin_member/adminMypage");
		return mav;
	}
	
	
//	@GetMapping("/customer/customerList")
//	public ModelAndView customerList(@RequestParam HashMap<String, Object> param, int page,int number) {
//		ModelAndView mav= new ModelAndView("admin/customer/customerList");
//		int memberCount = ms.memberCount();
//		Paging paging = new Paging(page, memberCount);
//		mav.addObject("paging", paging);
//		return mav;
//	}
	
	@GetMapping("/admin_member")
	public ModelAndView admin_member(@RequestParam HashMap<String, Object> param, int page) {
		ModelAndView mav=new ModelAndView("admin/admin_member/admin_member");
		int adminCount = as.adminCount();
		Paging paging = new Paging(page, adminCount);
		List<Admin_memberDTO>list=as.selectAll();
		mav.addObject("paging", paging);
		mav.addObject("list", list);
		return mav;
	}
	

	@PostMapping("/admin_member/insert")
	@ResponseBody
	public String admin_insert(Admin_memberDTO dto) {
		System.out.println(dto.getAdmin_name());
		int row =as.insert(dto);
		System.out.println(row);
		return row+"";
	}
	

	@GetMapping(value="/admin_member/{admin_num}", produces = "application/json; charset=utf-8")
	@ResponseBody					// 그냥 컨트롤러에서 json을 받을려면 ReponseBody 해줘야함
	public String selectOne(@PathVariable String admin_num) throws JsonProcessingException {
		System.out.println(admin_num);
		String json = null;
		Admin_memberDTO dto = as.selectOne(admin_num);
		System.out.println("selectOne 실행 후 : " + dto.getAdmin_name());
		json = mapper.writeValueAsString(dto);
		
		return json;
	}
	
	@PostMapping("/admin_member/update")
	@ResponseBody
	public String update(Admin_memberDTO dto) {
		System.out.println(dto.getAdmin_name());
		int row = as.update(dto);
		return row+"";
	}


	
	//////////////////////////////////////////////////////////////
	// -----------------------board-------------------------
	
	
	
	
	@GetMapping("/board")
	public ModelAndView board(@RequestParam HashMap<String, Object> param, int page) {
		ModelAndView mav= new ModelAndView("admin/board/boardList");
		int baordCount = bs.boardCount();
		Paging paging = new Paging(page, baordCount);
		
		List<boardDTO> list=bs.list(paging,param);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	@GetMapping("/board/read/{board_number}")
	public ModelAndView read(@PathVariable int board_number) {
		ModelAndView mav= new ModelAndView("admin/board/read");
		boardDTO dto=bs.selectOne(board_number);
		boardDTO np=bs.next(board_number);
		dto.setBoard_next(np.getBoard_next());
		np=bs.prev(board_number);
		dto.setBoard_prev(np.getBoard_prev());
		
		
		mav.addObject("dto",dto);
		
		if(dto.getBoard_next()!=0) {
			boardDTO next = bs.selectOne(dto.getBoard_next());
			mav.addObject("next", next);
		}
		if(dto.getBoard_prev()!=0) {
			boardDTO prev = bs.selectOne(dto.getBoard_prev());
			mav.addObject("prev", prev);
		}
		return mav;
	}
	
	@GetMapping("/board/write")
	public String write() {
		return "admin/board/write";

	}
	
	@PostMapping("/board/write")
	public String board(boardDTO dto,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		int row=bs.insert(dto);
		String word= URLEncoder.encode(keyword, "UTF-8");
		
	return "redirect:/admin/board?search="+search+"&keyword="+word+"&page="+page;
	}
	
	@GetMapping("/board/update/{board_number}")
	public ModelAndView update(@PathVariable int board_number) {
		
		ModelAndView mav= new ModelAndView("admin/board/update");
		boardDTO dto=bs.selectOne(board_number);
		
		mav.addObject("dto",dto);
		
		return mav;
	}
	@PostMapping("/board/update/{board_number}")
	public String update(boardDTO dto,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		String word= URLEncoder.encode(keyword, "UTF-8");
		int row =bs.update(dto);
		
		return "redirect:/admin/board/read/"+dto.getBoard_number()+"?search="+search+"&keyword="+word+"&page="+page;
	}
	
	
	@GetMapping("/board/delete/{board_number}")
	public String delete(@PathVariable int board_number,@RequestParam String search,String keyword,int page) throws UnsupportedEncodingException {
		String word= URLEncoder.encode(keyword, "UTF-8");
		int row = bs.delete(board_number);
		return "redirect:/admin/board?search="+search+"&keyword="+word+"&page="+page;
	}



	@RequestMapping(value="/board/write/uploadSummernoteImageFile",method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,HttpServletRequest request) throws JsonProcessingException {
		
		//JsonObject jsonObject = new JsonObject();
		String json=null;
		HashMap<String, String> jm=new HashMap<>();		
		String savedFileName = bs.summernote(multipartFile,jm);
					String cpath = request.getContextPath();
			jm.put("url",cpath+"/upload/"+savedFileName);
			jm.put("responseCode", "success");		
		
		json=mapper.writeValueAsString(jm);
		return json;
	}
	
	//////////////////영화관 ////////////////////////////////////
	@GetMapping("/cinema")
	public ModelAndView cinema() {
		ModelAndView mav= new ModelAndView("/admin/cinema/cinema");
		List<TheaterDTO> list = cs.selectAll();
		mav.addObject("list", list);
		return mav;
	}
	@PostMapping("/cinema")
	@ResponseBody
	public String  c_insert(TheaterDTO dto) {
		int row = cs.insert(dto);
		return row+"";
	}

	@GetMapping(value = "/cinema/{branchcode}", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String c_upate(@PathVariable String branchcode) throws JsonProcessingException {
		TheaterDTO dto = cs.selectOne(branchcode);
		String json = mapper.writeValueAsString(dto);
		System.out.println(json);
		return json;
	}
	
	@PutMapping(value = "/cinema" ,consumes = "application/json; charset=utf-8")
	@ResponseBody
	public String c_update(@RequestBody TheaterDTO dto) {
		int row = cs.update(dto);
		return row+"";
	}
	

	//////////////////////////////////////////////////////////////
	// -----------------------customer-------------------------
	
	@GetMapping("/customer/customerList")
	public ModelAndView customerList(@RequestParam HashMap<String, Object> param, int page,int number) {
		ModelAndView mav= new ModelAndView("admin/customer/customerList");
		int memberCount = ms.memberCount();
		Paging paging = new Paging(page, memberCount);
		List<MemberDTO> customerList = null;
		switch(number) {
			case 1:	customerList = ms.customerDateList(paging,param); break;
			case 2: customerList = ms.customerGradeList(paging,param); break;
			case 3: customerList = ms.customerThisList(paging,param); break;
			case 4: customerList = ms.customerLastList(paging,param); break;
		}
		mav.addObject("customerList", customerList);
		mav.addObject("paging", paging);
		return mav;
	}
	
	
	@GetMapping("/customer/customerRead/{member_number}")
	public ModelAndView customerRead(@PathVariable String member_number) {
		ModelAndView mav= new ModelAndView("admin/customer/customerRead");
		MemberDTO dto= ms.selectOne4(member_number);
		mav.addObject("dto",dto);
		return mav;
	}
	
}