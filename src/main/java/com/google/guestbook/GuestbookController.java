package com.google.guestbook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

@Controller
@RequestMapping("guestbook")
public class GuestbookController {
	@RequestMapping(value="guestbook", method=RequestMethod.GET)
	public String guestbook(String guestbookName, Model model) {
		model.addAttribute("guestbookName", guestbookName);
		return "guestbook/guestbook";
	}
	@RequestMapping(value="sign", method=RequestMethod.POST)
	public String sign(HttpServletRequest req, HttpServletResponse resp) {
		Greeting greeting;
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String guestbookName = req.getParameter("guestbookName");
		String content = req.getParameter("content");
		if (user != null) {
			greeting = new Greeting(guestbookName, content, user.getUserId(), user.getEmail());
		} else {
			greeting = new Greeting(guestbookName, content);
		}
		ObjectifyService.ofy().save().entity(greeting).now();
		return "redirect:/guestbook/guestbook?guestbookName=" + guestbookName;
	}
}
