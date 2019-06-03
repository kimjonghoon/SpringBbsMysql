package net.java_school.spring.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import net.java_school.commons.WebContants;

public class GoogleAccountsAuthenticationEntryPoint implements AuthenticationEntryPoint {
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		response.sendRedirect(userService.createLoginURL(WebContants.GO_TO_PAGE_AFTER_LOGIN));
	}
}