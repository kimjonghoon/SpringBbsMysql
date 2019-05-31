package net.java_school.controller;

import java.net.URLEncoder;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.Board;
import net.java_school.board.BoardService;
import net.java_school.commons.NumbersForPaging;
import net.java_school.commons.Paginator;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

@Controller
@RequestMapping("/bbs")
public class BbsController extends Paginator {
	private final BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	private BoardService boardService;

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	private String getBoardName(String boardCd, String lang) {
		Board board = boardService.getBoard(boardCd);

		switch (lang) {
		case "en":
			return board.getBoardNm();
		case "ko":
			return board.getBoardNm_ko();
		default:
			return board.getBoardNm();
		}
	}

	@GetMapping("/{boardCd}")
	public String list(@CookieValue(value="numPerPage", defaultValue="10") String num, @PathVariable String boardCd, Integer page, String searchWord, Locale locale, Model model) {

		if (page == null) {
			page = 1;
		}

		int numPerPage = Integer.parseInt(num);
		int pagePerBlock = 10;

		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);

		NumbersForPaging numbers = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);

		HashMap<String, String> map = new HashMap<>();

		map.put("boardCd", boardCd);
		map.put("searchWord", searchWord);

		Integer offset = (page - 1) * numPerPage;
		Integer rowCount = numPerPage;
		map.put("offset", offset.toString());
		map.put("rowCount", rowCount.toString());

		List<Article> list = boardService.getArticleList(map);

		Integer listItemNo = numbers.getListItemNo();
		Integer prevPage = numbers.getPrevBlock();
		Integer nextPage = numbers.getNextBlock();
		Integer firstPage = numbers.getFirstPage();
		Integer lastPage = numbers.getLastPage();
		Integer totalPage = numbers.getTotalPage();

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("totalPage", totalPage);

		String lang = locale.getLanguage();
		List<Board> boards = boardService.getBoards();
		String boardName = this.getBoardName(boardCd, lang);
		model.addAttribute("boards", boards);
		model.addAttribute("boardName", boardName);

		model.addAttribute("boardCd", boardCd);

		return "bbs/list";

	}

	@GetMapping("/{boardCd}/{articleNo}")
	public String view(@CookieValue(value="numPerPage", defaultValue="10") String num, @PathVariable String boardCd, @PathVariable Integer articleNo,
			Integer page, String searchWord, Locale locale, HttpServletRequest req, Model model) {

		if (page == null) {
			page = 1;
		}
		String lang = locale.getLanguage();

		//articleNo, user'ip, yearMonthDayHour
		String ip = req.getRemoteAddr();
		LocalDateTime now = LocalDateTime.now();
		Integer year = now.getYear();
		Integer month = now.getMonthValue();
		Integer day = now.getDayOfMonth();
		Integer hour = now.getHour();
		String yearMonthDayHour = year.toString() + month.toString() + day.toString() + hour.toString();

		try {
			boardService.increaseHit(articleNo, ip, yearMonthDayHour);
		} catch (Exception e) {
		}

		Article article = boardService.getArticle(articleNo);
		List<AttachFile> attachFileList = boardService.getAttachFileList(articleNo);
		Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
		Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
		String boardName = this.getBoardName(boardCd, lang);

		String title = article.getTitle();
		String content = article.getContent();
		String name = article.getName();
		String email = article.getEmail();
		Date regdate = article.getRegdate();

		int hit = boardService.getTotalViews(articleNo);

		model.addAttribute("title", title);
		model.addAttribute("content", content);
		model.addAttribute("hit", hit);
		model.addAttribute("name", name);
		model.addAttribute("email", email);
		model.addAttribute("regdate", regdate);
		model.addAttribute("attachFileList", attachFileList);
		model.addAttribute("nextArticle", nextArticle);
		model.addAttribute("prevArticle", prevArticle);

		int numPerPage = Integer.parseInt(num);
		int pagePerBlock = 10;

		int totalRecord = boardService.getTotalRecord(boardCd, searchWord);

		NumbersForPaging numbers = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);

		HashMap<String, String> map = new HashMap<>();
		map.put("boardCd", boardCd);
		map.put("searchWord", searchWord);

		Integer offset = (page - 1) * numPerPage;
		Integer rowCount = numPerPage;
		map.put("offset", offset.toString());
		map.put("rowCount", rowCount.toString());

		List<Article> list = boardService.getArticleList(map);

		int listItemNo = numbers.getListItemNo();
		int prevPage = numbers.getPrevBlock();
		int nextPage = numbers.getNextBlock();
		int firstPage = numbers.getFirstPage();
		int lastPage = numbers.getLastPage();
		int totalPage = numbers.getTotalPage();

		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prevPage", prevPage);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("nextPage", nextPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("boardName", boardName);

		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);

		model.addAttribute("articleNo", articleNo);
		model.addAttribute("boardCd", boardCd);

		return "bbs/view";
	}

	@GetMapping("/{boardCd}/new")
	public String writeForm(@PathVariable String boardCd, Locale locale, Model model) {
		String lang = locale.getLanguage();
		String boardName = this.getBoardName(boardCd, lang);
		List<Board> boards = boardService.getBoards();

		model.addAttribute("boardName", boardName);
		model.addAttribute("article", new Article());
		model.addAttribute("boards", boards);
		model.addAttribute("boardCd", boardCd);

		return "bbs/write";

	}
	@PostMapping("/upload")
	public String upload(Integer articleNo, String boardCd, Integer page, String searchWord, HttpServletRequest req) {
		Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
		List<BlobKey> blobKeys = blobs.get("attachFile");

		if (blobKeys != null && !blobKeys.isEmpty()) {
			BlobInfoFactory blobInfoFactory = new BlobInfoFactory();
			int size = blobKeys.size();

			for (int i = 0; i < size; i++) {
				BlobInfo blobInfo = blobInfoFactory.loadBlobInfo(blobKeys.get(i));
				AttachFile attachFile = new AttachFile();
				String filekey = blobKeys.get(i).getKeyString();
				attachFile.setFilekey(filekey);
				attachFile.setFilename(blobInfo.getFilename());
				attachFile.setFiletype(blobInfo.getContentType());
				attachFile.setFilesize(blobInfo.getSize());
				attachFile.setCreation(blobInfo.getCreation());
				attachFile.setArticleNo(articleNo);
				Article article = boardService.getArticle(articleNo);
				attachFile.setEmail(article.getEmail());
				boardService.addAttachFile(attachFile);
			}

		}

		return "redirect:/bbs/" + boardCd + "/" + articleNo + "?page=" + page + "&searchWord=" + searchWord;

	}

	@PostMapping("/{boardCd}")
	public String write(@Valid Article article,
			BindingResult bindingResult,
			@PathVariable String boardCd,
			Locale locale,
			Model model,
			Principal principal) throws Exception {

		if (bindingResult.hasErrors()) {
			String boardName = this.getBoardName(boardCd, locale.getLanguage());
			model.addAttribute("boardName", boardName);
			List<Board> boards = boardService.getBoards();
			model.addAttribute("boards", boards);
			model.addAttribute("boardCd", boardCd);

			return "bbs/write";
		}

		article.setBoardCd(boardCd);
		article.setEmail(principal.getName());
		boardService.addArticle(article);

		return "redirect:/bbs/" + article.getBoardCd() + "?page=1";

	}

	@GetMapping("/{boardCd}/{articleNo}/edit")
	public String modifyForm(@PathVariable String boardCd, @PathVariable Integer articleNo, Locale locale, Model model) {

		String lang = locale.getLanguage();
		Article article = boardService.getArticle(articleNo);
		String boardName = this.getBoardName(boardCd, lang);

		model.addAttribute("article", article);
		model.addAttribute("boardName", boardName);

		List<Board> boards = boardService.getBoards();
		model.addAttribute("boards", boards);
		model.addAttribute("boardCd", boardCd);
		model.addAttribute("articleNo", articleNo);

		return "bbs/modify";
	}

	@PostMapping("/{boardCd}/{articleNo}")
	public String modify(@Valid Article article,
			BindingResult bindingResult,
			@PathVariable String boardCd,
			@PathVariable Integer articleNo,
			Integer page,
			String searchWord,
			Locale locale,
			Model model) throws Exception {

		if (bindingResult.hasErrors()) {
			String boardName = this.getBoardName(article.getBoardCd(), locale.getLanguage());
			model.addAttribute("boardName", boardName);
			List<Board> boards = boardService.getBoards();
			model.addAttribute("boards", boards);
			model.addAttribute("boardCd", boardCd);
			model.addAttribute("articleNo", articleNo);

			return "bbs/modify";
		}

		article.setArticleNo(articleNo);
		article.setBoardCd(boardCd);
		String email = boardService.getArticle(article.getArticleNo()).getEmail();
		article.setEmail(email);

		boardService.modifyArticle(article);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/" + boardCd + "/" + articleNo + "?page=" + page + "&searchWord=" + searchWord;

	}

	@RequestMapping(value = "/{boardCd}/{articleNo}", method = RequestMethod.DELETE)
	public String deleteArticle(@PathVariable String boardCd, @PathVariable Integer articleNo, Integer page, String searchWord) {
		Article article = boardService.getArticle(articleNo);
		boardService.removeArticle(article);

		return "redirect:/bbs/" + boardCd + "?page=" + page + "&searchWord=" + searchWord;

	}

	@PostMapping("/deleteAttachFile")
	public String deleteAttachFile(int attachFileNo,
			Integer articleNo,
			String boardCd,
			Integer page,
			String searchWord) throws Exception {

		AttachFile attachFile = boardService.getAttachFile(attachFileNo);
		boardService.removeAttachFile(attachFile);
		
		BlobKey blobKey = new BlobKey(attachFile.getFilekey());
		blobstoreService.delete(blobKey);

		searchWord = URLEncoder.encode(searchWord, "UTF-8");

		return "redirect:/bbs/" + boardCd + "/" + articleNo + "?page=" + page + "&searchWord=" + searchWord;

	}

}