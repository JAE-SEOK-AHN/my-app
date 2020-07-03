package com.barunsw.simple.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class UserController {
	private static final Logger LOGGER = LogManager.getLogger(UserController.class);

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/indexWindow", method = RequestMethod.GET)
	public String indexWindow(Model model) {
		return "user/indexWindow";
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
	
	@RequestMapping(value="/save", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> save(@RequestParam HashMap<String, String> param, @ModelAttribute UserVo userVo) {
		Map<String, String> resultMap = new HashMap<String, String>();
		String mode = param.get("mode");
		
		if ( mode.equals("INSERT") ) {
			userService.insertUser(userVo);
		}
		else if ( mode.equals("UPDATE") ) {
			userService.updateUser(userVo);
		}
		else if ( mode.equals("DELETE") ) {
			param.get("userVo");

			int result = userService.deleteUser(userVo.getUserId());
			if ( result == 1 ) {
				resultMap.put("userId", userVo.getUserId());
				resultMap.put("result", "OK");
			}
			else {
				resultMap.put("result", "FAIL");
			}
			System.out.println("userVo.getUserId() is not null");
			
		}
		else {
			System.out.println("동일한 mode가 존재하지 않음");
			resultMap.put("result", "FAIL");
		}
		
		return resultMap;
	}
	
	@RequestMapping(value="/test", method = RequestMethod.GET)
	public String test() {
		return "user/test";
	}
}
