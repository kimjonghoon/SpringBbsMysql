package net.java_school.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.users.UserServiceFactory;

@Controller
@RequestMapping("/")
public class HomeController {

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "index";
    }

    @RequestMapping(value="/error", method = {RequestMethod.GET, RequestMethod.POST})
    public String error() {
        return "403";
    }

    @RequestMapping(value = "/403", method = {RequestMethod.GET, RequestMethod.POST})
    public String error403() {
        return "403";
    }

	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();

		String url = UserServiceFactory.getUserService().createLogoutURL("/");

		response.sendRedirect(url);
	}

}