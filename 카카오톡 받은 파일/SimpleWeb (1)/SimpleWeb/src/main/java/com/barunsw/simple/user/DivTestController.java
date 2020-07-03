package com.barunsw.simple.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class DivTestController {
	@RequestMapping(value="/divTest")
	public String indexWindow() {
		return "test/divTest";
	}
}
