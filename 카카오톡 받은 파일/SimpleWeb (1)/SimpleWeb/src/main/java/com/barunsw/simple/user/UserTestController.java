package com.barunsw.simple.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class UserTestController {
	private static final Logger LOGGER = LogManager.getLogger(UserTestController.class);

	@Autowired
	private UserService userService;
	
/*	
	// index
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String index(Model model) {
//		model.addAttribute("userList", userService.selectUserList(new UserVo()));
		return "user/index";
	}


	@RequestMapping(value="/list", method = RequestMethod.GET)
	public @ResponseBody List<UserVo> getUser(HttpServletRequest request, HttpServletResponse response) {
//		request.getHeader(name);
//		response.getHeader(name);
//		request.getInputStream();
//		response.getOutputStream();
		return userService.selectUserList(new UserVo());
	}
	
	@RequestMapping(value="/userOne", method = RequestMethod.GET)
	@ResponseBody
	public UserVo getUserOne(@RequestParam String userId, HttpServletResponse response) {
		return userService.selectUserOne(userId);
	}
	
	// jsp 페이지 - insert(유저 등록), update(유저 수정)
	@RequestMapping(value="/insert", method = RequestMethod.GET)
	public String insert(Model model) {
		return "user/insert";
	}
	
	@RequestMapping(value="/update", method = RequestMethod.GET)
	public String update(@RequestParam String userId, Model model) {
		model.addAttribute("userId", userId);
		return "user/update";
	}
	
	// service
	@RequestMapping(value="/insertUser", method = RequestMethod.POST)
	public String insertUser(@ModelAttribute UserVo userVo) {
		userService.insertUser(userVo);
		return "redirect:/user/index";
	}
	
	@RequestMapping(value="/updateUser", method = RequestMethod.POST)
	public String updateUser(@ModelAttribute UserVo userVo) {
		userService.updateUser(userVo);
		return "redirect:/user/index";
	}
	
	@RequestMapping(value="/deleteUser", method = RequestMethod.GET)
	public String deleteUser(@RequestParam String userId) {
		userService.deleteUser(userId);
		return "redirect:/user/index";
	}
*/

	// window이용 CRUD 생성
	/*
	@RequestMapping(value="/indexWindow", method = RequestMethod.GET)
	public String indexWindow(Model model) {
		return "user/indexWindow2";
	}
	@RequestMapping(value="/list", method = RequestMethod.GET)
	public @ResponseBody List<UserVo> getUser(HttpServletRequest request, HttpServletResponse response) {
		return userService.selectUserList(new UserVo());
	}
	
	@RequestMapping(value="/one", method = RequestMethod.GET)
	@ResponseBody
	public UserVo getUserOne(@RequestParam String userId, HttpServletResponse response) {
		return userService.selectUserOne(userId);
	}
	
	// service
	@RequestMapping(value="/insertUser", method = RequestMethod.POST)
	public String insertUser(@ModelAttribute UserVo userVo) {
		userService.insertUser(userVo);
		return "redirect:/user/indexWindow";
	}
	
	@RequestMapping(value="/updateUser", method = RequestMethod.POST)
	public String updateUser(@ModelAttribute UserVo userVo) {
		userService.updateUser(userVo);
		return "redirect:/user/indexWindow";
	}
	
	@RequestMapping(value="/deleteUser", method = RequestMethod.GET)
	public String deleteUser(@RequestParam String userId) {
		userService.deleteUser(userId);
		return "redirect:/user/indexWindow";
	}
	*/
}
