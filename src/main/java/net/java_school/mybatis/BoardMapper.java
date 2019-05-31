package net.java_school.mybatis;

import java.util.HashMap;
import java.util.List;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.Board;
import net.java_school.board.Comment;

public interface BoardMapper {

    public Board selectOneBoard(String boardCd);

    public List<Board> selectAllBoard();

    public void insertBoard(Board board);

    public void updateBoard(Board board);

    public List<Article> selectListOfArticles(HashMap<String, String> hashmap);

    public int selectCountOfArticles(HashMap<String, String> hashmap);

    public int insert(Article article);

    public void insertAttachFile(AttachFile attachFile);

    public void update(Article article);

    public void delete(int articleNo);

    public void insertOneViews(HashMap<String, String> hashmap);

    public Article selectOne(int articleNo);

    public Article selectNextOne(HashMap<String, String> hashmap);

    public Article selectPrevOne(HashMap<String, String> hashmap);

    public List<AttachFile> selectListOfAttachFiles(int articleNo);

    public void deleteFile(int attachFileNo);

    public void insertComment(Comment comment);

    public void updateComment(Comment comment);

    public void deleteComment(int commentNo);

    public List<Comment> selectListOfComments(int articleNo);

    public AttachFile selectOneAttachFile(int attachFileNo);

    public Comment selectOneComment(int commentNo);

    public int selectCountOfViews(int articleNo);

}