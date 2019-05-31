package net.java_school.controller;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import net.java_school.blog.Article;
import net.java_school.blog.Category;
import net.java_school.blog.Lang;
import net.java_school.board.Board;
import net.java_school.board.BoardService;
import net.java_school.commons.Paginator;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.googlecode.objectify.Key;

@Controller
@RequestMapping("/admin")
public class AdminController extends Paginator {

	private BoardService boardService;

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	@GetMapping
	public String index(Model model) {

		List<Article> articles = ofy()
				.load()
				.type(Article.class)
				.order("date")
				.list();

		model.addAttribute("articles", articles);

		return "admin/index";
	}
	@GetMapping("/new")
	public String postBlog() {
		return "admin/new";
	}

	@PostMapping("/new")
	public String postBlog(Article article, String category, Locale locale, Principal principal) {
		String lang = locale.getLanguage();
		Key<Lang> theLang = Key.create(Lang.class, lang);
		Key<Category> theCategory = Key.create(theLang, Category.class, category);
		article.setTheCategory(theCategory);
		article.setOwner(principal.getName());

		Date today = new Date();
		article.setDate(today);
		article.setLastModified(today);

		ofy().save().entity(article).now();

		return "redirect:/admin";
	}

	@GetMapping("/modify")
	public String modifyBlog(String webSafeString, Model model) {
		Key<Article> key = Key.create(webSafeString);
		Article article = ofy()
				.load()
				.key(key)
				.now();
		model.addAttribute("article", article);

		return "admin/modify";
	}

	@PostMapping("/modify")
	public String modifyBlog(Article article, String webSafeString) {
		Key<Article> key = Key.create(webSafeString);
		Article storedArticle = ofy()
				.load()
				.key(key)
				.now();

		storedArticle.setTitle(article.getTitle());
		storedArticle.setKeywords(article.getKeywords());
		storedArticle.setDescription(article.getDescription());
		storedArticle.setContent(article.getContent());
		storedArticle.setLastModified(new Date());

		ofy().save().entity(storedArticle).now();

		return "redirect:/admin";
	}

	@PostMapping("/delete")
	public String delBlog(String webSafeString) {
		Key<Article> key = Key.create(webSafeString);
		ofy().delete().key(key).now();

		return "redirect:/admin";
	}

	@GetMapping("/board")
	public String boardList(Model model) {
		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);

		return "admin/board";
	}

	@PostMapping("/createBoard")
	public String createBoard(Board board) {
		boardService.createBoard(board);

		return "redirect:/admin/board";
	}

	@PostMapping("/editBoard")
	public String editBoard(Board board) {
		boardService.editBoard(board);

		return "redirect:/admin/board";
	}

}