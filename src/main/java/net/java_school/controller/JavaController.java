package net.java_school.controller;

import net.java_school.blog.Article;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/java")
public class JavaController {

	@RequestMapping(method=RequestMethod.GET)
	public String index() {
		return "java/index";
	}

	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Article getArticle(@PathVariable String id) {
		Article article = new Article();
		
		switch (id) {
		case "jdk-install":
			article.setTitle("JDK 설치");
			article.setKeywords("JDK,Java,PATH,CLASSPATH");
			article.setDescription("자바 설치를 설명합니다.");
			article.setContent("본문");
		default:
			article.setTitle("Tomcat 설치");
			article.setKeywords("Tomcat,");
			article.setDescription("톰캣 설치를 설명합니다.");
			article.setContent("본문...");
		}
		
		return article;
	}

}